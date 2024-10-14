package com.iisysgroup.itexstore

import android.content.Intent
import android.os.Build
import android.util.Log
import androidx.annotation.NonNull
import android.Manifest
import android.content.Context
import android.content.pm.PackageManager
import android.net.Uri
import android.os.PowerManager
import android.provider.Settings
import androidx.core.app.ActivityCompat
import androidx.core.content.ContextCompat
import com.iisysgroup.itexstore.platform.subs.SmartPermission
import com.iisysgroup.itexstore.utils.HelperUtil
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import io.flutter.embedding.android.FlutterActivity

class MainActivity : FlutterActivity() {
    private val CHANNEL = "itexstore_methods"
    private lateinit var storeFunctions: StoreFunctions
    private val TAG = "MainActivity"

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        storeFunctions = StoreFunctions(this)
        MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            CHANNEL
        ).setMethodCallHandler { call, result ->
            when (call.method) {
                "initBackgroundService" -> {
                    try {
                        val serviceIntent = Intent(this, BackgroundService::class.java)
                        stopService(serviceIntent)
                        startService(serviceIntent)
                        val networkMonitor = NetworkMonitor(this)
                        networkMonitor.register()

//                        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
//                            val packageName = "com.iisysgroup.itexstore"
//                            val pm = getSystemService(PowerManager::class.java)
//                            if (!pm.isIgnoringBatteryOptimizations(packageName)) {
//                                val intent = Intent(Settings.ACTION_REQUEST_IGNORE_BATTERY_OPTIMIZATIONS)
//                                intent.data = Uri.parse("package:$packageName")
//                                startActivity(intent)
//                            }
//                        }

                        result.success(true)

                    } catch (e: Exception) {
                        Log.d(TAG, "Exception on initBackgroundService: ${e.message}")
                        result.success(false)
                    }
                }

                "getDeviceInfo" -> {
                    result.success(storeFunctions.getDeviceInfo())
                }

                "getSerialNumber" -> {
                    result.success(storeFunctions.getSN())
                }

                "isNetworkConnected" -> {
                    result.success(HelperUtil.isNetworkConnected(this))
                }

                "pushMessage" -> {
                    val message = call.argument("message") ?: ""
                    result.success(storeFunctions.pushMessage(message))
                }

                "getInstalledApps" -> {
                    val excludeSystemApps = call.argument("excludeSystemApps") ?: true
                    val withIcon = call.argument("withIcon") ?: true
                    val packageNamePrefix: String = call.argument("packageNamePrefix") ?: ""
                    Thread {
                        result.success(
                            storeFunctions.getInstalledApps(
                                excludeSystemApps,
                                withIcon,
                                packageNamePrefix
                            )
                        )
                    }.start()

                }

                "startApp" -> {
                    val packageName: String? = call.argument("packageName")
                    result.success(storeFunctions.startApp(packageName))
                }

                "openSettings" -> {
                    val packageName: String? = call.argument("packageName")
                    storeFunctions.openSettings(packageName)
                }

                "getAppInfo" -> {
                    val packageName: String? = call.argument("packageName")
                    result.success(storeFunctions.getAppInfo(packageName))
                }

                "uninstallApp" -> {
                    val packageName: String? = call.argument("packageName")
                    result.success(storeFunctions.uninstallApp(packageName!!))
                }

                "installApp" -> {
                    val path: String? = call.argument("path")
                    val packageName: String? = call.argument("packageName")
                    result.success(storeFunctions.installApp(path, packageName))
                }

                "requestSmartPermissions" -> {
                    requestSmartPermissions(result)
                }


                else -> {
                    result.notImplemented()
                }
            }
        }
    }

    override fun onDestroy() {
        super.onDestroy()
        storeFunctions.closeService()
    }


    private fun requestSmartPermissions(result: MethodChannel.Result) {
        val permissions = SmartPermission(this).permissionList
//        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.Q) {
//            permissions.add(Manifest.permission.ACCESS_BACKGROUND_LOCATION)
//        }
        val permissionsToRequest = permissions.filter { p ->
            ContextCompat.checkSelfPermission(this, p) != PackageManager.PERMISSION_GRANTED
        }

        if (permissionsToRequest.isNotEmpty()) {
            Log.d(TAG, "Requesting permissions: $permissionsToRequest")
            ActivityCompat.requestPermissions(this, permissionsToRequest.toTypedArray(), 1)
            result.success(permissionsToRequest.first())
        } else {
            Log.d(TAG, "All permissions granted")
            result.success(null)
        }
    }

}
