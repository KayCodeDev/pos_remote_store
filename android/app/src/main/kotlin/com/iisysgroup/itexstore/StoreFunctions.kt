package com.iisysgroup.itexstore

import android.annotation.SuppressLint
import android.annotation.TargetApi
import android.content.Context
import android.content.Intent
import android.content.Intent.FLAG_ACTIVITY_NEW_TASK
import android.content.pm.PackageManager
import android.graphics.Bitmap
import android.net.Uri
import android.os.Build
import android.provider.Settings.ACTION_APPLICATION_DETAILS_SETTINGS
import com.iisysgroup.itexstore.utils.HelperUtil
import java.util.Locale.ENGLISH
import android.os.Build.VERSION_CODES
import android.util.Log
import com.iisysgroup.itexstore.platform.PlatformSdk
import com.iisysgroup.itexstore.platform.Sunyard
//import java.util.Random
import kotlin.random.Random


class StoreFunctions(private val context: Context) {
    private val packageManager: PackageManager = context.packageManager
    private val TAG = "StoreFunctions"
    private val sunyard: Sunyard = Sunyard(context)

    init {
        sunyard.setInstance()
    }

    private fun getPlatform(): PlatformSdk? {
        return sunyard;
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
        return getPlatform()?.installApp(path!!, packageName!!) ?: false
    }

    fun uninstallApp(packageName: String?): Boolean {
        val platformSdk: PlatformSdk? = getPlatform()

        return platformSdk?.uninstallApp(packageName!!)
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