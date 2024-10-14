package com.iisysgroup.itexstore

//import java.util.Random
import android.annotation.TargetApi
import android.content.ComponentName
import android.content.Context
import android.content.Intent
import android.content.Intent.FLAG_ACTIVITY_NEW_TASK
import android.content.pm.PackageManager
import android.graphics.Bitmap
import android.net.Uri
import android.os.Build
import android.os.Build.VERSION_CODES
import android.provider.Settings.ACTION_APPLICATION_DETAILS_SETTINGS
import android.util.Log
import com.iisysgroup.itexstore.platform.Morefun
import com.iisysgroup.itexstore.platform.PlatformSdk
import com.iisysgroup.itexstore.utils.HelperUtil
import kotlinx.coroutines.runBlocking
import java.util.Locale.ENGLISH
import kotlin.random.Random


class StoreFunctions(private val context: Context) {
    private val packageManager: PackageManager = context.packageManager
    private val TAG = "StoreFunctions"
    private val morefun: Morefun = Morefun(context)


    init {
        morefun.bindService()
    }

    fun closeService() {
        morefun.unbindService()
    }

    private fun getPlatform(): PlatformSdk? {
        return morefun
    }

    fun getSN(): String? {
        return getPlatform()?.getSerialNumber()
    }

    @TargetApi(VERSION_CODES.GINGERBREAD)
    fun getDeviceInfo(): Map<String, String?> {
        try {
            val info: MutableMap<String, String?> =
                getPlatform()?.getTerminalInfo()?.toMutableMap() ?: mutableMapOf()

            var long = ""
            var lat = ""
            val savedLocation: String? = HelperUtil.getFromSharedPrefs(context, "location")
            if (savedLocation != null) {
                val locationPart: List<String> = savedLocation.split(":")
                if (locationPart.count() > 1) {
                    long = locationPart[0]
                    lat = locationPart[1]
                }
            }

            info["longitude"] = long
            info["latitude"] = lat
            info["batteryStatus"] = HelperUtil.isDeviceCharging(context)

            Log.d(TAG, info.toString());

            return info.toMap()
        } catch (e: Exception) {
            Log.d(TAG, "getDeviceInfo Exception: ${e.message}")
            return mapOf()
        }
    }

    fun rebootDevice(): Boolean {
        return getPlatform()?.rebootDevice()!!

    }

    fun setTimeZone(tz: String?): Boolean {
        return getPlatform()?.setTimeZone(tz ?: "Africa/Lagos")!!

    }

    fun shutdownDevice(): Boolean {
        return getPlatform()?.shutdownDevice()!!

    }


    fun captureScreen(): Bitmap? {
        return getPlatform()?.captureScreen()

    }

    fun pushMessage(message: String): Boolean {
        return try {
            val notificationId: Int = Random.nextInt(0, 1000)
            HelperUtil.showNotification(context, notificationId, "Push Message", message)
            true
        } catch (e: Exception) {
            Log.d(TAG, "pushMessage Exception: ${e.message}")
            false
        }
    }

    fun getInstalledApps(
        excludeSystemApps: Boolean,
        withIcon: Boolean,
        packageNamePrefix: String
    ): List<Map<String, Any?>> {
        val packageManager = packageManager
        var installedApps = packageManager.getInstalledApplications(0)
        installedApps = packageManager.getInstalledApplications(0)
        if (excludeSystemApps)
            installedApps =
                installedApps.filter { app ->
                    !HelperUtil.isSystemApp(
                        packageManager,
                        app.packageName
                    )
                }
        if (packageNamePrefix.isNotEmpty())
            installedApps = installedApps.filter { app ->
                app.packageName.startsWith(
                    packageNamePrefix.lowercase(ENGLISH)
                )
            }
        return installedApps.map { app ->
            HelperUtil.convertAppToMap(
                packageManager,
                app,
                withIcon
            )
        }
    }

    @TargetApi(Build.VERSION_CODES.CUPCAKE)
    fun startApp(packageName: String?): Boolean {
        if (packageName.isNullOrBlank()) return false
        return try {
            val launchIntent = packageManager.getLaunchIntentForPackage(packageName)
            context.startActivity(launchIntent)
            true
        } catch (e: Exception) {
            Log.d(TAG, "Exception startApp : ${e.message}")
            false
        }
    }


    @TargetApi(VERSION_CODES.GINGERBREAD)
    fun openSettings(packageName: String?) {
        if (!HelperUtil.isAppInstalled(context, packageName)) {
            return
        }
        val intent = Intent().apply {
            flags = FLAG_ACTIVITY_NEW_TASK
            action = ACTION_APPLICATION_DETAILS_SETTINGS
            data = Uri.fromParts("package", packageName, null)
        }
        context.startActivity(intent)
    }

    fun getAppInfo(
        packageName: String?
    ): Map<String, Any?>? {
        var installedApps = packageManager.getInstalledApplications(0)
        installedApps = packageManager.getInstalledApplications(0)
        installedApps = installedApps.filter { app -> app.packageName == packageName }
        return if (installedApps.isEmpty()) null
        else HelperUtil.convertAppToMap(packageManager, installedApps[0], true)
    }

    fun installApp(path: String?, packageName: String?): Boolean {
        return getPlatform()?.installApp(path!!, packageName!!) == true
    }

    fun uninstallApp(packageName: String?): Boolean {
        return runBlocking {
            val platformSdk: PlatformSdk? = getPlatform()
            platformSdk?.uninstallApp(packageName!!)
                ?: try {
                    val intent = Intent(Intent.ACTION_DELETE)
                    intent.data = Uri.parse("package:$packageName")
                    context.startActivity(intent)
                    true
                } catch (e: Exception) {
                    false
                }
        }
    }

    fun sendParameters(context: Context, params: Map<String, Any?>): Boolean {
        if (params["packageName"] != null) {
            val intent = Intent()
            val packageName = params["packageName"] as String
            intent.component = ComponentName(packageName, "$packageName.ITEXStoreParams")

            for (param in params.entries.iterator()) {
                intent.putExtra(param.key, param.value as String)
            }

            return try {
                val componentName = context.startService(intent)
                componentName != null
            } catch (e: Exception) {
                e.printStackTrace()
                false
            }
        } else {
            return false
        }
    }


}