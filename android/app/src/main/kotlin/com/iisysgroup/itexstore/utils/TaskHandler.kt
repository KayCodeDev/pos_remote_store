package com.iisysgroup.itexstore.utils

import android.graphics.Bitmap
import android.util.Log
import com.iisysgroup.itexstore.StoreFunctions
import java.io.File
import android.app.*
import android.content.Context
import kotlinx.coroutines.launch
import kotlinx.coroutines.*
import com.google.gson.Gson
import com.google.gson.reflect.TypeToken

class TaskHandler(
    private val storeFunctions: StoreFunctions,
    private val context: Context
) {
    companion object {
        private const val TAG = "TaskHandler"

        //        private val BASE_URL = "http://${HelperUtil.BaseUrl}:9090/api/v1/store"
        private val BASE_URL = "https://${HelperUtil.BaseUrl}/api/v1/store"
        private val CALL_HOME_ENDPOINT = "terminal/sync"
        private val UPDATE_TASK_ENDPOINT = "task/update"
        private val NOTIFY_DOWNLOAD_ENDPOINT = "notify/download"
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

                val payload: Map<String, Any?> = mapOf(
                    "deviceInfo" to info, "installedApp" to installedApps
                )

                val payloadString: String = Gson().toJson(payload)

                val url = "$BASE_URL/$CALL_HOME_ENDPOINT"
                val serialNumber: String? = storeFunctions.getSN()
                val response: Map<String, Any>? =
                    HelperUtil.sendPost(url, payloadString, TOKEN, serialNumber!!)

                val tasks = response?.get("tasks")
                if (tasks != null && tasks is List<*> && tasks.isNotEmpty() && tasks.all { it is Map<*, *> }) {
                    handleServerTask(
                        tasks as List<Map<String, Any>>, "call_home"
                    )
                } else {

                }
//            publishMessage("itx/terminal/sync/${info["serialNumber"]}", payloadString);
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
            try {
                val url = "$BASE_URL/$NOTIFY_DOWNLOAD_ENDPOINT/$appUuid/$versionUuid"
                val serialNumber: String? = storeFunctions.getSN()
                HelperUtil.sendGet(url, TOKEN, serialNumber!!)
            } catch (e: Exception) {
                println(e)
                Log.e(TAG, "Exception reportDownload: ${e.message}")
            }
        }

    }

    private fun updateTask(
        serialNumber: String, task: Map<String, Any>, status: String, message: String, file: File?
    ) {
        coroutineScope.launch {
            try {
                val request = mapOf(
                    "serialNumber" to serialNumber,
                    "taskId" to task["taskId"].toString(),
                    "status" to status,
                    "message" to message
                )

                val url = "$BASE_URL/$UPDATE_TASK_ENDPOINT"
                HelperUtil.sendForm(url, request, file, TOKEN, serialNumber)
            } catch (e: Exception) {
                println(e)
                Log.e(TAG, "Exception updateTask: ${e.message}")
            }
        }
    }


}