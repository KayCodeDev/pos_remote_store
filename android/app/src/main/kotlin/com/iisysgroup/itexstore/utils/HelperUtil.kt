package com.iisysgroup.itexstore.utils

import android.Manifest
import android.annotation.SuppressLint
import android.annotation.TargetApi
import android.app.ActivityManager
import android.app.DownloadManager
import android.app.Notification
import android.app.NotificationChannel
import android.app.NotificationManager
import android.content.Context
import android.content.ContextWrapper
import android.content.Intent
import android.content.IntentFilter
import android.content.SharedPreferences
import android.content.pm.ApplicationInfo
import android.content.pm.PackageInfo
import android.content.pm.PackageManager
import android.graphics.Bitmap
import android.graphics.Canvas
import android.graphics.drawable.BitmapDrawable
import android.graphics.drawable.Drawable
import android.location.Location
import android.location.LocationListener
import android.location.LocationManager
import android.net.ConnectivityManager
import android.net.Uri
import android.os.BatteryManager
import android.os.Build
import android.os.Build.VERSION.SDK_INT
import android.os.Build.VERSION_CODES.P
import android.os.Environment
import android.util.Log
import android.widget.Toast
//import androidx.core.app.ActivityCompat
import androidx.core.app.NotificationCompat
import androidx.core.content.ContextCompat
import com.google.gson.Gson
import com.google.gson.reflect.TypeToken
import com.iisysgroup.itexstore.R
import okhttp3.MediaType.Companion.toMediaTypeOrNull
import okhttp3.MultipartBody
import okhttp3.OkHttpClient
import okhttp3.Request
import okhttp3.RequestBody
import okhttp3.RequestBody.Companion.asRequestBody
import java.io.BufferedWriter
import java.io.ByteArrayOutputStream
import java.io.File
import java.io.FileOutputStream
import java.io.IOException
import java.io.OutputStreamWriter
import java.net.Socket
import java.security.SecureRandom
import java.text.SimpleDateFormat
//import java.util.Base64
import android.util.Base64
import java.util.Date
import java.util.Locale
import java.util.zip.ZipFile
import javax.crypto.Cipher
import javax.crypto.spec.IvParameterSpec
import javax.crypto.spec.SecretKeySpec
import android.os.Bundle
import android.telephony.TelephonyManager
import kotlin.random.Random

class HelperUtil {


    companion object {
        var client: OkHttpClient = OkHttpClient()
        private val TAG = "HelperUtil"
        const val ChannelID = "ITEXStore"

        @SuppressLint("NewApi", "Range")
        fun downloadFile(
            context: Context,
            fileUrl: String,
            fileName: String,
            fileNamePath: String
        ): String? {
            val downloadManager =
                context.getSystemService(Context.DOWNLOAD_SERVICE) as DownloadManager
            val uri = Uri.parse(fileUrl)
            val notificationId = generateNotificationId()

            val request = DownloadManager.Request(uri)
            request.setAllowedNetworkTypes(DownloadManager.Request.NETWORK_WIFI or DownloadManager.Request.NETWORK_MOBILE)
            request.setAllowedOverRoaming(false)
            request.setTitle("ITEX Store Push")
            request.setDescription("Downloading $fileName")
            request.setNotificationVisibility(DownloadManager.Request.VISIBILITY_VISIBLE)
            request.setDestinationInExternalFilesDir(
                context,
                Environment.DIRECTORY_DOWNLOADS,
                fileNamePath
            )

            val downloadId = downloadManager.enqueue(request)

            val query = DownloadManager.Query().setFilterById(downloadId)
            var isDownloadCompleted = false
            var filePath: String? = null

            while (!isDownloadCompleted) {
                val cursor = downloadManager.query(query)
                if (cursor.moveToFirst()) {
                    when (cursor.getInt(cursor.getColumnIndex(DownloadManager.COLUMN_STATUS))) {
                        DownloadManager.STATUS_SUCCESSFUL -> {
                            isDownloadCompleted = true
                            filePath =
                                cursor.getString(cursor.getColumnIndex(DownloadManager.COLUMN_LOCAL_URI))
                                    .replace("file://", "")
                            cancelProgressNotification(context, notificationId)
                        }

                        DownloadManager.STATUS_FAILED -> {
                            isDownloadCompleted = true
                            val reason =
                                cursor.getInt(cursor.getColumnIndex(DownloadManager.COLUMN_REASON))
                            cancelProgressNotification(context, notificationId)
                            Toast.makeText(context, "Download failed: $reason", Toast.LENGTH_SHORT)
                                .show()
                        }
                    }
                }
                cursor.close()
            }

            return filePath
        }

        fun sendGet(url: String, token: String, serialNumber: String): Map<String, Any>? {
            val request = Request.Builder()
                .url(url)
                .build()

            return executeRequest(client, request, token, serialNumber)
        }

        fun sendPost(
            url: String,
            body: String,
            token: String,
            serialNumber: String
        ): Map<String, Any>? {
            val requestBody: RequestBody =
                RequestBody.create("application/json".toMediaTypeOrNull(), body)
            val request = Request.Builder()
                .url(url)
                .post(requestBody)
                .build()

            return executeRequest(client, request, token, serialNumber)
        }

        fun sendForm(
            url: String,
            formData: Map<String, String>,
            file: File?,
            token: String, serialNumber: String
        ): Map<String, Any>? {
            val requestBody = MultipartBody.Builder()
                .setType(MultipartBody.FORM)

            for ((key, value) in formData) {
                requestBody.addFormDataPart(key, value)
            }

            file?.let {
                requestBody.addFormDataPart(
                    "capture", it.name,
                    it.asRequestBody("image/png".toMediaTypeOrNull())
                )
            }
            val requestBodyFinal: RequestBody = requestBody.build()

            val request = Request.Builder()
                .url(url)
                .post(requestBodyFinal)
                .build()

            return executeRequest(client, request, token, serialNumber)
        }


        fun sendTcpMessageToServer(message: String, socket: Socket) {
            val outputStream = socket.getOutputStream()
            val writer = BufferedWriter(OutputStreamWriter(outputStream))

            writer.write(message)
            writer.newLine()
            writer.flush()
        }

        @SuppressLint("NewApi")
        fun saveBitmapToFile(bitmap: Bitmap, filename: String): File? {
            val directory =
                Environment.getExternalStoragePublicDirectory(Environment.DIRECTORY_PICTURES)
            val file = File(directory, filename)

            return try {
                val outputStream = FileOutputStream(file)
                bitmap.compress(Bitmap.CompressFormat.PNG, 100, outputStream)
                outputStream.close()
                file
            } catch (e: IOException) {
                e.printStackTrace()
                null
            }
        }

        @JvmStatic
        fun showNotification(
            context: Context,
            notificationId: Int,
            title: String,
            content: String,
            progress: Int = -1
        ) {
            if (SDK_INT >= Build.VERSION_CODES.O) {
                val channelName = "ITEX Store Push"
                val notificationChannel =
                    NotificationChannel(
                        ChannelID,
                        channelName,
                        NotificationManager.IMPORTANCE_NONE
                    )
                val manager = context.getSystemService(NotificationManager::class.java)
                manager.createNotificationChannel(notificationChannel)

                val notification = Notification.Builder(context, ChannelID)
                    .setContentTitle(title)
                    .setContentText(content)
                    .setSmallIcon(R.drawable.logo)


                if (progress >= 0) {
                    notification.setProgress(100, progress, false)
                }

                manager.notify(notificationId, notification.build())
            } else {
                val notificationManager =
                    context.getSystemService(Context.NOTIFICATION_SERVICE) as NotificationManager
                val notification = NotificationCompat.Builder(context, ChannelID)
                    .setContentTitle(title)
                    .setContentText(content)
                    .setSmallIcon(R.drawable.logo)

                if (progress >= 0) {
                    notification.setProgress(100, progress, false)
                }

                notificationManager.notify(notificationId, notification.build())
            }
        }

        @SuppressLint("NewApi")
        fun encryptData(data: String, secretKey: String): String {
            val cipher = Cipher.getInstance("AES/CBC/PKCS5Padding")
            val key = SecretKeySpec(secretKey.toByteArray(), "AES")
            val iv = ByteArray(16)
            SecureRandom().nextBytes(iv) // Generate random IV
            val ivParameterSpec = IvParameterSpec(iv)
            cipher.init(Cipher.ENCRYPT_MODE, key, ivParameterSpec)
            val encryptedBytes = cipher.doFinal(data.toByteArray())
            val encryptedData = Base64.encodeToString(encryptedBytes, Base64.DEFAULT)
            return Base64.encodeToString(iv, Base64.DEFAULT) + ":" + encryptedData
        }


        fun decryptData(encryptedDataWithIV: String, secretKey: String): String {
            val (iv, encryptedData) = encryptedDataWithIV.split(":")
            val cipher = Cipher.getInstance("AES/CBC/PKCS5Padding")
            val key = SecretKeySpec(secretKey.toByteArray(), "AES")
            val ivBytes = Base64.decode(iv.toString(), Base64.DEFAULT)
            val ivParameterSpec = IvParameterSpec(ivBytes)
            cipher.init(Cipher.DECRYPT_MODE, key, ivParameterSpec)
            val decryptedBytes =
                cipher.doFinal(Base64.decode(encryptedData.toString(), Base64.DEFAULT))
            return String(decryptedBytes)
        }

        fun getDateTimeAsFileName(): String {
            val dateFormat = SimpleDateFormat("yyyyMMdd_HHmmss", Locale.getDefault())
            val currentTime = Date()
            return dateFormat.format(currentTime)
        }

        fun getAvailableRam(context: Context): Long {
            val activityManager =
                context.getSystemService(Context.ACTIVITY_SERVICE) as ActivityManager
            val memoryInfo = ActivityManager.MemoryInfo()
            activityManager.getMemoryInfo(memoryInfo)
            return memoryInfo.availMem
        }

        fun isNetworkConnected(context: Context): Boolean {
            val connectivityManager =
                context.getSystemService(Context.CONNECTIVITY_SERVICE) as ConnectivityManager
            val networkInfo = connectivityManager.activeNetworkInfo
            return networkInfo != null && networkInfo.isConnected
        }

        fun getConnectionType(context: Context): String {
            val connectivityManager =
                context.getSystemService(Context.CONNECTIVITY_SERVICE) as ConnectivityManager
            val networkInfo = connectivityManager.activeNetworkInfo

            var networkType: String

            if (networkInfo != null && networkInfo.isConnected) {
                networkType = when (networkInfo.type) {
                    ConnectivityManager.TYPE_WIFI -> "wifi"
                    ConnectivityManager.TYPE_MOBILE -> "mobile"
                    else -> "unknown"
                }

                if (networkType == "mobile") {
                    val simInfo = getSimInfo(context)
                    networkType = "$networkType||$simInfo"
                }

                return networkType
            }
            return "not_connected"
        }

        @SuppressLint("NewApi")
        fun getAvailableRom(): Long {
            return Environment.getExternalStorageDirectory().freeSpace
        }

        @SuppressLint("InlinedApi")
        fun getBatteryTemperature(context: Context): Float {
            val intent = context.registerReceiver(null, IntentFilter(Intent.ACTION_BATTERY_CHANGED))
            val temperature = intent?.getIntExtra(BatteryManager.EXTRA_TEMPERATURE, 0) ?: 0
            return temperature / 10f
        }

        fun isAppInstalled(context: Context, packageName: String?): Boolean {
            val packageManager: PackageManager = context.packageManager
            return try {
                packageManager.getPackageInfo(packageName ?: "", PackageManager.GET_ACTIVITIES)
                true
            } catch (e: PackageManager.NameNotFoundException) {
                false
            }
        }

        @SuppressLint("InlinedApi")
        fun getBatteryLevel(context: Context): Int {
            val batteryLevel: Int = if (SDK_INT >= Build.VERSION_CODES.LOLLIPOP) {
                val batteryManager =
                    context.getSystemService(Context.BATTERY_SERVICE) as BatteryManager
                batteryManager.getIntProperty(BatteryManager.BATTERY_PROPERTY_CAPACITY)
            } else {
                val intent = ContextWrapper(context).registerReceiver(
                    null,
                    IntentFilter(Intent.ACTION_BATTERY_CHANGED)
                )
                intent!!.getIntExtra(BatteryManager.EXTRA_LEVEL, -1) * 100 / intent.getIntExtra(
                    BatteryManager.EXTRA_SCALE,
                    -1
                )
            }

            return batteryLevel
        }

        fun listenToLocation(context: Context) {
            val locationManager =
                context.getSystemService(Context.LOCATION_SERVICE) as LocationManager
            val isGpsEnabled = locationManager.isProviderEnabled(LocationManager.GPS_PROVIDER)
            val isNetworkEnabled =
                locationManager.isProviderEnabled(LocationManager.NETWORK_PROVIDER)


            val locationListener = object : LocationListener {
                override fun onLocationChanged(location: Location) {
                    saveToSharedPrefs(
                        context,
                        "location",
                        "${location.longitude}:${location.latitude}"
                    )
                }

                override fun onProviderDisabled(provider: String) {}
                override fun onProviderEnabled(provider: String) {}
                override fun onStatusChanged(provider: String, status: Int, extras: Bundle) {}
            }

            try {
                if (ContextCompat.checkSelfPermission(
                        context,
                        Manifest.permission.ACCESS_FINE_LOCATION
                    )
                    == PackageManager.PERMISSION_GRANTED
                ) {
                    val lastKnownLocation =
                        locationManager.getLastKnownLocation(LocationManager.GPS_PROVIDER)
                            ?: locationManager.getLastKnownLocation(LocationManager.NETWORK_PROVIDER)
                    lastKnownLocation?.let {
                        locationListener.onLocationChanged(it)
                    }
                    when {
                        isGpsEnabled -> {
                            locationManager.requestLocationUpdates(
                                LocationManager.GPS_PROVIDER,
                                5 * 60 * 1000L,
                                10f,
                                locationListener
                            )
                        }

                        isNetworkEnabled -> {
                            locationManager.requestLocationUpdates(
                                LocationManager.NETWORK_PROVIDER,
                                5 * 60 * 1000L,
                                10f,
                                locationListener
                            )
                        }
                    }
                }

            } catch (e: SecurityException) {
                Log.d(TAG, "${e.message}")
            }
        }

        fun saveToSharedPrefs(context: Context, key: String, value: String) {
            val sharedPreferences: SharedPreferences =
                context.getSharedPreferences("itexStorePref", Context.MODE_PRIVATE)
            val editor: SharedPreferences.Editor = sharedPreferences.edit()
            editor.putString(key, value)
            editor.apply()
        }

        fun getFromSharedPrefs(context: Context, key: String): String? {
            val sharedPreferences: SharedPreferences =
                context.getSharedPreferences("itexStorePref", Context.MODE_PRIVATE)
            return sharedPreferences.getString(key, null)
        }

        private fun getSimInfo(context: Context): String {
            try {
                val telephonyManager =
                    context.getSystemService(Context.TELEPHONY_SERVICE) as TelephonyManager

                // Get Mobile Network Operator Name
                val operatorName = telephonyManager.networkOperatorName ?: "--"

                // Get SIM Mobile Number (this might not always work due to restrictions and carrier settings)
                val simNumber = telephonyManager.line1Number ?: "--"

                // Display or use the information as needed
                return "$operatorName||$simNumber"
            } catch (e: Exception) {
                e.message?.let { Log.e(TAG, it) }
                return "--||--"
            }
        }

        fun isDeviceCharging(context: Context): String {
            return try {
                val batteryStatus: Intent? =
                    IntentFilter(Intent.ACTION_BATTERY_CHANGED).let { ifilter ->
                        context.registerReceiver(null, ifilter)
                    }

                val status: Int = batteryStatus?.getIntExtra(BatteryManager.EXTRA_STATUS, -1) ?: -1
                val isCharging: Boolean = status == BatteryManager.BATTERY_STATUS_CHARGING
                        || status == BatteryManager.BATTERY_STATUS_FULL

                if (isCharging) {
                    "charging"
                } else {
                    "not_charging"
                }
            } catch (e: Exception) {
                println(e)
                "not_charging"
            }
        }

        @TargetApi(Build.VERSION_CODES.CUPCAKE)
        fun isSystemApp(packageManager: PackageManager, packageName: String): Boolean {
            val system = arrayOf(
                "com.dsi.ant.server",
                "org.codeaurora.snapcam",
                "com.oma.drm",
                "jp.co.omronsoft.openwnn",
                "com.sunyard"
            )
            return system.any { packageName.contains(it) }
        }

        fun isServiceRunning(serviceClass: Class<*>, context: Context): Boolean {
            val manager = context.getSystemService(Context.ACTIVITY_SERVICE) as ActivityManager
            for (service in manager.getRunningServices(Integer.MAX_VALUE)) {
                if (serviceClass.name == service.service.className) {
                    return true
                }
            }
            return false
        }

        @SuppressLint("NewApi")
        fun convertAppToMap(
            packageManager: PackageManager,
            app: ApplicationInfo,
            withIcon: Boolean = true
        ): HashMap<String, Any?> {
            val map = HashMap<String, Any?>()
            map["name"] = packageManager.getApplicationLabel(app)
            map["package_name"] = app.packageName
            val packageInfo = packageManager.getPackageInfo(app.packageName, 0)
            map["version_name"] = packageInfo.versionName
            map["version_code"] = getVersionCode(packageInfo)
            map["built_with"] = getPlatform(packageInfo.applicationInfo)
            map["installed_timestamp"] = File(packageInfo.applicationInfo.sourceDir).lastModified()
            map["isSystemApp"] = isSystemApp(packageManager, app.packageName)
            return map
        }

        @JvmStatic
        fun generateNotificationId(): Int {
            return System.currentTimeMillis()
                .toInt() + (0..100).random() // Generate a unique ID based on current time and a random number
        }


        private fun getPlatform(applicationInfo: ApplicationInfo): String {
            val apkPath = applicationInfo.sourceDir
            val zipFile = ZipFile(apkPath)
            val entries: List<String> = zipFile.entries().toList().map { entry -> entry.name }
            return if (isFlutterApp(entries)) {
                "flutter"
            } else if (isReactNativeApp(entries)) {
                "react_native"
            } else if (isXamarinApp(entries)) {
                "xamarin"
            } else if (isIonicApp(entries)) {
                "ionic"
            } else {
                "native_or_others"
            }
        }

        @SuppressLint("NewApi")
        private fun executeRequest(
            client: OkHttpClient,
            request: Request,
            token: String,
            serialNumber: String
        ): Map<String, Any>? {
            try {
                val builder = request.newBuilder()


                builder.addHeader("x-api-key", token)
                builder.addHeader("x-serial-number", serialNumber)

                val newRequest = builder.build()

                val response = client.newCall(newRequest).execute()
                if (!response.isSuccessful) {
                    throw IOException("Unexpected code $response")
                } else {
                    val responseBody = response.body!!.string()

                    val mapType = object : TypeToken<Map<String, Any>>() {}.type
                    return Gson().fromJson(responseBody, mapType)
                }
            } catch (e: IOException) {
                Log.d(TAG, "Exception sending request : ${e.message}")
            }
            return null
        }

        @Suppress("DEPRECATION")
        private fun getVersionCode(packageInfo: PackageInfo): Long {
            return if (SDK_INT < P) packageInfo.versionCode.toLong()
            else packageInfo.longVersionCode
        }

        private fun drawableToByteArray(drawable: Drawable): ByteArray {
            val bitmap = drawableToBitmap(drawable)
            return ByteArrayOutputStream().use { stream ->
                bitmap.compress(Bitmap.CompressFormat.PNG, 100, stream)
                stream.toByteArray()
            }
        }

        private fun drawableToBitmap(drawable: Drawable): Bitmap {
            if (drawable is BitmapDrawable) {
                return drawable.bitmap
            }
            val bitmap = Bitmap.createBitmap(
                drawable.intrinsicWidth,
                drawable.intrinsicHeight,
                Bitmap.Config.ARGB_8888
            )
            val canvas = Canvas(bitmap)
            drawable.setBounds(0, 0, canvas.width, canvas.height)
            drawable.draw(canvas)
            return bitmap
        }

//        private fun appendValueToStringBuilder(value: Any?, stringBuilder: StringBuilder) {
//            when (value) {
//                is Map<*, *> -> {
//                    val mapString = mapToString(value as Map<String, String?>)
//                    stringBuilder.append(mapString)
//                }
//
//                is List<*> -> {
//                    val listString = listToString(value as List<Map<String, Any?>>)
//                    stringBuilder.append(listString)
//                }
//
//                else -> {
//                    stringBuilder.append(value?.toString())
//                }
//            }
//        }

//        private fun listToString(list: List<Map<String, Any?>>): String {
//            val stringBuilder = StringBuilder()
//            stringBuilder.append("[")
//            for (item in list) {
//                appendValueToStringBuilder(item, stringBuilder)
//                stringBuilder.append(", ")
//            }
//            // Remove the trailing comma and space if the list is not empty
//            if (list.isNotEmpty()) {
//                stringBuilder.deleteCharAt(stringBuilder.length - 1)
//                stringBuilder.deleteCharAt(stringBuilder.length - 1)
//            }
//            stringBuilder.append("]")
//            return stringBuilder.toString()
//        }


        private fun isFlutterApp(entries: List<String>): Boolean {
            return contains(entries, "/flutter_assets/")
        }

        private fun isReactNativeApp(entries: List<String>): Boolean {
            return contains(entries, "react_native_routes.json")
                    || contains(entries, "libs_reactnativecore_components")
                    || contains(entries, "node_modules_reactnative")
        }

        private fun isXamarinApp(entries: List<String>): Boolean {
            return contains(entries, "libaot-Xamarin")
        }

        private fun isIonicApp(entries: List<String>): Boolean {
            return contains(entries, "node_modules_ionic")
        }

        private fun contains(entries: List<String>, value: String): Boolean {
            return entries.firstOrNull { entry: String -> entry.contains(value) } != null
        }

        private const val LOCATION_PERMISSION_REQUEST_CODE = 1001


        private fun cancelProgressNotification(context: Context, notificationId: Int) {
            val notificationManager =
                context.getSystemService(Context.NOTIFICATION_SERVICE) as NotificationManager
            notificationManager.cancel(notificationId)
        }

    }
}