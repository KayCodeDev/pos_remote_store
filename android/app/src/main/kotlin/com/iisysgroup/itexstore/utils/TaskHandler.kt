package com.iisysgroup.itexstore.utils

import android.annotation.TargetApi
import android.graphics.Bitmap
import android.util.Log
import com.iisysgroup.itexstore.StoreFunctions
import java.io.File
import android.app.*
import android.content.Context
import android.os.Build
import android.util.Base64
import kotlinx.coroutines.launch
import kotlinx.coroutines.*
import com.google.gson.Gson
//import com.google.gson.reflect.TypeToken

class TaskHandler(
    private val storeFunctions: StoreFunctions,
    private val context: Context,
    private val mqttMobileClient: MqttMobileClient
) {
    companion object {
        private const val TAG = "TaskHandler"
        private val BASE_URL = "http://${HelperUtil.BaseUrl}:9090/api/v1/store"
//        private val BASE_URL = "https://${HelperUtil.BaseUrl}/api/v1/store"
        private val TASK_FILE_UPLOAD = "task/upload"
        private const val TOKEN =
            "q3QreaNLqJzSp5SGVw/dUH/zMQlVo1HthfXkkGS1iP1xKWe2WwLPOFd4PErm/makjhsE6nBxDMETeCY2CBZ81dlBiFn7CVCSridhn/BQwo7L2ZT9gZRV8RbyV9/IH4GZ+UZYHg=="

    }

    private val coroutineScope = CoroutineScope(Dispatchers.IO + SupervisorJob())

    fun sendSyncRequest() {
        coroutineScope.launch {
            try {
                val info: Map<String, Any?> = storeFunctions.getDeviceInfo()
                val installedApps: List<Map<String, Any?>> = storeFunctions.getInstalledApps(
                    excludeSystemApps = true, withIcon = false, packageNamePrefix = ""
                )

                val serialNumber: String? = storeFunctions.getSN()

                val payload: Map<String, Any?> = mapOf(
                    "event" to "terminalSync",
                    "serialNumber" to serialNumber,
                    "deviceInfo" to info,
                    "installedApp" to installedApps
                )

                val payloadString: String = Gson().toJson(payload)

                mqttMobileClient.publish(payloadString)
            } catch (e: Exception) {
                println(e)
                Log.e(TAG, "Exception: ${e.message}")
            }
        }
    }

    fun handleServerTask(
        tasks: List<Map<String, Any>>?, channel: String
    ) {
        try {
            val serialNumber: String? = storeFunctions.getSN()
            var imageFile: File? = null
            var result: Boolean = false
            for (map in tasks!!) {
                when (map["taskType"]) {
                    "PUSH_APP" -> {
                        val version: Map<String, Any?>? = (map["appVersion"] as? Map<String, Any?>)
                        val downloadUrl: String? = version?.get("downloadUrl")?.toString()
                        val packageName: String? =
                            (version?.get("app") as? Map<String, Any?>)?.get("packageName")
                                ?.toString()
                        val appName: String? =
                            (version?.get("app") as? Map<String, Any?>)?.get("name")?.toString()
                        val appUuid: String? =
                            (version?.get("app") as? Map<String, Any?>)?.get("uuid")?.toString()
                        val versionUuid: String? = version?.get("uuid") as? String
                        val versionName: String? = version?.get("version") as? String

                        val sameVersion: Boolean = checkSameVersion(version, packageName)

                        if (!sameVersion) {
                            val fileNamePath =
                                "${packageName?.replace(".", "_")}_${versionUuid}.apk"
                            val fileName = "$appName v$versionName"
                            val path: String? = HelperUtil.downloadFile(
                                context, downloadUrl!!, fileName, fileNamePath
                            )
                            result = if (path != null) {
                                val apk: File = File(path)
                                if (apk.exists()) {
                                    storeFunctions.installApp(path, packageName)
                                    Thread.sleep(10000)
                                    if (checkSameVersion(version, packageName)) {
                                        reportDownload(appUuid!!, versionUuid!!)
                                        true
                                    } else {
                                        false
                                    }
                                } else {
                                    false
                                }

                            } else {
                                false
                            }
                        } else {
                            result = true
                        }
                    }

                    "UNINSTALL_APP" -> {
                        val packageName: String = map["message"].toString()
                        storeFunctions.uninstallApp(packageName)
                        Thread.sleep(10000)
                        result = !checkExist(packageName)
                    }

                    "PUSH_MESSAGE" -> {
                        val pushMessage: String = map["message"].toString()
                        result = storeFunctions.pushMessage(pushMessage)
                    }

                    "REBOOT_DEVICE" -> {
                        result = storeFunctions.rebootDevice()
                    }

                    "SHUTDOWN_DEVICE" -> {
                        result = storeFunctions.shutdownDevice()
                    }

                    "SET_TIME_ZONE" -> {
                        val tz: String = map["message"].toString()
                        result = storeFunctions.setTimeZone(tz)
                    }

                    "CAPTURE_SCREEN" -> {
                        val image: Bitmap? = storeFunctions.captureScreen()

                        if (image != null) {
                            val fileName =
                                "${serialNumber}_${map["taskType"]}_${HelperUtil.getDateTimeAsFileName()}.png"
                            imageFile = HelperUtil.saveBitmapToFile(image, fileName)
                        }
                        result = imageFile != null
                    }

                    "PUSH_PARAMETERS" -> {
                        val parameters: Map<String, Any?> = (map["parameters"] as Map<String, Any?>)
                        result = storeFunctions.sendParameters(context, parameters)
                    }
                }


                val status = if (result) "DONE" else "FAILED"
                val message =
                    if (result) "Completed" else "${map["taskType"]} failed or not supported by OEM"
                updateTask(serialNumber!!, map, status, message, imageFile)

                if (result && arrayOf("PUSH_APP", "UNINSTALL_APP").contains(map["taskType"])) {
                    sendSyncRequest()
                }
            }
        } catch (e: Exception) {
            Log.e(TAG, "Exception handleServerTask: ${e.message}")
        }
    }

    private fun checkExist(packageName: String?): Boolean {
        val exist: Map<String, Any?>? = storeFunctions.getAppInfo(packageName)
        if (exist != null) {
            return true
        }

        return false
    }

    private fun checkSameVersion(version: Map<String, Any?>?, packageName: String?): Boolean {
        val exist: Map<String, Any?>? = storeFunctions.getAppInfo(packageName)
        if (exist != null) {
            val existVersion: Long? = exist["version_code"] as? Long
            val newVersionStr: String? = version?.get("versionCode") as? String
            val newVersion = newVersionStr?.toLong()

            if (existVersion == newVersion) {
                return true
            }
        }

        return false
    }

    private fun reportDownload(appUuid: String, versionUuid: String) {
        coroutineScope.launch {
            Log.d(TAG, "Reporting download completion")
            try {
                val serialNumber: String? = storeFunctions.getSN()
                val payload: Map<String, Any?> = mapOf(
                    "event" to "reportDownload",
                    "serialNumber" to serialNumber,
                    "appUuid" to appUuid,
                    "versionUuid" to versionUuid
                )

                val payloadString: String = Gson().toJson(payload)

                mqttMobileClient.publish(payloadString)
            } catch (e: Exception) {
                println(e)
                Log.e(TAG, "Exception reportDownload: ${e.message}")
            }
        }

    }

    @TargetApi(Build.VERSION_CODES.O)
    private fun updateTask(
        serialNumber: String, task: Map<String, Any>, status: String, message: String, file: File?
    ) {
        coroutineScope.launch {
            try {
                var fileUrl : String? = null

                if(file != null && file.isFile) {
                    val uploadRequest = mapOf(
                        "serialNumber" to serialNumber,
                        "taskId" to task["taskId"].toString(),
                    );

                    val url = "$BASE_URL/$TASK_FILE_UPLOAD"
                    val response: Map<String, Any>? =   HelperUtil.sendForm(url, uploadRequest, file, TOKEN, serialNumber)

                    fileUrl = if (response != null && response.containsKey("data")){
                        val upload  = response["data"] as Map<*, *>
                        upload["uploadUrl"].toString()
                    }else{
                        null
                    }
                }

                val payload = mapOf(
                    "event" to "updateTask",
                    "serialNumber" to serialNumber,
                    "taskId" to task["taskId"].toString(),
                    "status" to status,
                    "message" to message,
                    "file" to fileUrl
                )

                val payloadString: String = Gson().toJson(payload)

                mqttMobileClient.publish(payloadString)
            } catch (e: Exception) {
                println(e)
                Log.e(TAG, "Exception updateTask: ${e.message}")
            }
        }
    }


}