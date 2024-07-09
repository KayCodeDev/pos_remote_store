package com.iisysgroup.itexstore

import com.iisysgroup.itexstore.R
import android.annotation.TargetApi
import android.app.*
import android.content.Context
import android.content.Intent
import android.graphics.Bitmap
import android.os.Build
import android.os.Handler
import android.os.IBinder
import android.os.Looper
import android.util.Log
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.GlobalScope
import kotlinx.coroutines.launch
//import java.time.Duration
import java.io.BufferedReader
import java.io.InputStreamReader
import java.net.InetAddress
import java.net.Socket
import com.google.gson.Gson
import com.google.gson.reflect.TypeToken
import java.io.File
import java.util.concurrent.Executors
import androidx.core.app.NotificationCompat
import com.iisysgroup.itexstore.utils.HelperUtil
import java.io.IOException
import kotlin.random.Random
import java.util.concurrent.TimeUnit
import kotlinx.coroutines.delay

@TargetApi(Build.VERSION_CODES.O)
class BackgroundService : Service() {
    private val TAG = "ITEXStoreBGS"
    private val BASE_URL = "https://store-api.itexapp.com/api/v1/store"
    private val TCP_SERVER_IP = "store-api.itexapp.com"
    private val TCP_SERVER_PORT = 9091

//    private val BASE_URL = "http://54.203.193.56:9090/api/v1/store"
//    private val TCP_SERVER_IP = "54.203.193.56"
//    private val TCP_SERVER_PORT = 9091

//    private val BASE_URL = "http://192.168.181.37:9090/api/v1/store"
//    private val TCP_SERVER_IP = "192.168.181.37"
//    private val TCP_SERVER_PORT = 9091

    private val CALL_HOME_ENDPOINT = "terminal/sync"
    private val UPDATE_TASK_ENDPOINT = "task/update"
    private val NOTIFY_DOWNLOAD_ENDPOINT = "notify/download"

    private val TOKEN =
        "q3QreaNLqJzSp5SGVw/dUH/zMQlVo1HthfXkkGS1iP1xKWe2WwLPOFd4PErm/makjhsE6nBxDMETeCY2CBZ81dlBiFn7CVCSridhn/BQwo7L2ZT9gZRV8RbyV9/IH4GZ+UZYHg=="
    private val SECRET_KEY =
        "WnxuisbwCzbX4S5BYPl/dnOF5c7Mf+mPqjxTx6dZXC2JizxVYcMOcVw3+7TcoryzU2s1yHcu+sTPZz8GOj2Du5H8FXv6bnFwjECugHBq/463BwCBJvw8uAMXmjbvj9P4lzb3HA=="


    private var socket: Socket? = null
    private var reader: BufferedReader? = null
    private var connected = false
    private val handler = Handler(Looper.getMainLooper())
    private val executor = Executors.newSingleThreadExecutor()

    private lateinit var context: Context
    private lateinit var storeFunctions: StoreFunctions

    private val runnable: Runnable by lazy {
        Runnable {
            GlobalScope.launch(Dispatchers.IO) {
                delay(TimeUnit.SECONDS.toMillis(30))
                sendEncryptedSyncRequest(storeFunctions)
                connectToTcpServer(storeFunctions)
            }
            handler.postDelayed(runnable, TimeUnit.MINUTES.toMillis(20))
        }
    }

    override fun onCreate() {
        super.onCreate()
        context = this
        storeFunctions = StoreFunctions(this)
    }

    override fun onBind(intent: Intent): IBinder? {
        return null
    }

    override fun onStartCommand(intent: Intent?, flags: Int, startId: Int): Int {
        HelperUtil.listenToLocation(this)
        handler.post(runnable)
        startForegroundService()
        return START_STICKY
    }

    private fun startForegroundService() {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            val channelName = "ITEX Store Notification"
            val notificationChannel =
                NotificationChannel(
                    HelperUtil.ChannelID,
                    channelName,
                    NotificationManager.IMPORTANCE_NONE
                )
            val manager = getSystemService(NotificationManager::class.java)
            manager.createNotificationChannel(notificationChannel)

            val notificationId: Int = Random.nextInt(0, 1000)
            val notification = Notification.Builder(this, HelperUtil.ChannelID)
                .setContentTitle("ITEX Store")
                .setContentText("ITEX Store is running")
                .setSmallIcon(R.drawable.logo)
                .build()

            startForeground(notificationId, notification)
        } else {
            val notificationId: Int = Random.nextInt(0, 1000)
            val notification = NotificationCompat.Builder(this, HelperUtil.ChannelID)
                .setContentTitle("ITEX Store")
                .setContentText("ITEX Store is running")
                .setSmallIcon(R.drawable.logo)
                .build()

            startForeground(notificationId, notification)
        }
    }

    private fun sendEncryptedSyncRequest(storeFunctions: StoreFunctions) {
        try {
            val info: Map<String, Any?> = storeFunctions.getDeviceInfo()
            val installedApps: List<Map<String, Any?>> = storeFunctions.getInstalledApps(
                excludeSystemApps = true,
                withIcon = false,
                packageNamePrefix = ""
            )

            val payload: Map<String, Any?> = mapOf(
                "deviceInfo" to info,
                "installedApp" to installedApps
            )

            val payloadString: String = Gson().toJson(payload)

            // Log.d(TAG, "Payload String: $payloadString")
            // val encrypted: String = HelperUtil.encryptData(payloadString, SECRET_KEY)
            // Log.d(TAG, "Encrypted Payload String: $encrypted")

            // val request = """{"data": $encrypted }"""

            val url = "$BASE_URL/$CALL_HOME_ENDPOINT"
            val serialNumber: String? = storeFunctions.getSN()
            val response: Map<String, Any>? =
                HelperUtil.sendPost(url, payloadString, TOKEN, serialNumber!!)

            val tasks = response?.get("tasks")
            if (tasks != null && tasks is List<*> && tasks.isNotEmpty() && tasks.all { it is Map<*, *> }) {
                executor.execute {
                    handleServerTask(tasks as List<Map<String, Any>>, storeFunctions, "call_home")
                }
            }
        } catch (e: Exception) {
            Log.e(TAG, "Exception: ${e.message}")
        }
    }

    private fun connectToTcpServer(storeFunctions: StoreFunctions) {
        try {
            val sn: String? = storeFunctions.getSN()
            if (!connected) {
                socket = Socket(InetAddress.getByName(TCP_SERVER_IP), TCP_SERVER_PORT)
                reader = BufferedReader(InputStreamReader(socket!!.getInputStream()))
                connected = true

                if (socket != null) {
                    val message =
                        """{"action":"joining", "serialNumber": "$sn"}"""
                    HelperUtil.sendTcpMessageToServer(message, socket!!)
                }

                val heartbeatThread = Thread {
                    try {
                        while (connected && socket != null) {
                            Thread.sleep(300000)
                            val heartbeatMessage =
                                """{"action":"heartbeat", "serialNumber": "$sn"}"""
                            HelperUtil.sendTcpMessageToServer(heartbeatMessage, socket!!)

                        }
                    } catch (e: InterruptedException) {
                        Log.e(TAG, "Heartbeat thread interrupted")
                    } catch (e: Exception) {
                        Log.e(TAG, "Error in heartbeat thread: ${e.message}")
                    }
                }
                heartbeatThread.start()
            }


            while (connected && socket != null) {
                try {
                    if (reader!!.ready()) {
                        val message = reader!!.readLine()
                        if (message != null) {

                            val mapType = object : TypeToken<Map<String, Any>?>() {}.type
                            val socketMessage: Map<String, Any> =
                                Gson().fromJson(message, mapType)

                            val tasks = socketMessage["tasks"]
                            if (tasks is List<*> && tasks.isNotEmpty() && tasks.all { it is Map<*, *> }) {
                                executor.execute {
                                    handleServerTask(
                                        tasks as List<Map<String, Any>>,
                                        storeFunctions,
                                        "socket"
                                    )
                                }
                            }
                        }
                    } else {
                        Thread.sleep(30000)
                    }
                } catch (e: IOException) {
                    Log.e(TAG, "Socket connection closed by server: ${e.message}")
                    connected = false
                    break
                }
            }
        } catch (e: Exception) {
            Log.e(TAG, "Error connecting to TCP server: ${e.message}")
            connected = false
        } finally {
            if (socket != null) {
                closeTcpConnection(socket!!, reader)
            }
        }

    }

    private fun handleServerTask(
        tasks: List<Map<String, Any>>?,
        storeFunctions: StoreFunctions,
        channel: String
    ) {
        try {
            val serialNumber: String? = storeFunctions.getSN()
            var imageFile: File? = null
            var result: Boolean = false
            for (map in tasks!!) {
                when (map["taskType"]) {
                    "PUSH_APP" -> {
                        val version: Map<String, Any?>? = (map["appVersion"] as? Map<String, Any?>)
                        val downloadUrl: String? =
                            version?.get("downloadUrl")?.toString()
                        val packageName: String? = (version
                            ?.get("app") as? Map<String, Any?>)
                            ?.get("packageName")?.toString()
                        val appName: String? = (version
                            ?.get("app") as? Map<String, Any?>)
                            ?.get("name")?.toString()
                        val appUuid: String? = (version
                            ?.get("app") as? Map<String, Any?>)
                            ?.get("uuid")?.toString()
                        val versionUuid: String? = version?.get("uuid") as? String
                        val versionName: String? = version?.get("version") as? String

                        val sameVersion: Boolean = checkSameVersion(version, packageName)

                        if (!sameVersion) {
                            val fileNamePath = "${packageName?.replace(".", "_")}_${versionUuid}.apk"
                            val fileName = "$appName v$versionName"
                            val path: String? =
                                HelperUtil.downloadFile(
                                    context,
                                    downloadUrl!!,
                                    fileName,
                                    fileNamePath
                                )
                            result = if (path != null) {
                                val apk: File = File(path)
                                if (apk.exists()) {
                                    storeFunctions.installApp(path, packageName)
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
                        result = storeFunctions.uninstallApp(packageName)
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
                    if (result) "Completed" else "${map["taskType"]} failed or not implemented by OEM or client app"
                updateTask(serialNumber!!, map, status, message, imageFile)

            }
        } catch (e: Exception) {
            Log.e(TAG, "Exception handleServerTask: ${e.message}")
        }
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
        try {
            val url = "$BASE_URL/$NOTIFY_DOWNLOAD_ENDPOINT/$appUuid/$versionUuid"
            val serialNumber: String? = storeFunctions.getSN()
            HelperUtil.sendGet(url, TOKEN, serialNumber!!)
        } catch (e: Exception) {
            Log.e(TAG, "Exception reportDownload: ${e.message}")
        }

    }

    private fun updateTask(
        serialNumber: String,
        task: Map<String, Any>,
        status: String,
        message: String,
        file: File?
    ) {
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
            Log.e(TAG, "Exception updateTask: ${e.message}")
        }
    }

    private fun closeTcpConnection(socket: Socket?, reader: BufferedReader?) {
        try {
            reader?.close()
            socket?.close()
            connected = false
            Log.d(TAG, "TCP connection closed")
        } catch (e: Exception) {
            Log.e(TAG, "Exception closeTcpConnection: ${e.message}")
        }
    }


    override fun onDestroy() {
        super.onDestroy()
        handler.removeCallbacks(runnable)
        storeFunctions.closeService()
    }
}