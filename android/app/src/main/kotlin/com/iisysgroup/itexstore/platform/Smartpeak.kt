package com.iisysgroup.itexstore.platform

import android.annotation.SuppressLint
import android.content.Context
import android.content.Intent
import android.graphics.Bitmap
import android.net.Uri
import android.os.Build
import android.os.RemoteException
import android.util.Log
import java.io.File
import java.util.TimeZone
import com.basewin.services.ServiceManager;
import com.iisysgroup.itexstore.platform.subs.SmartPermission
import com.iisysgroup.itexstore.utils.HelperUtil

class Smartpeak(private val context: Context) : PlatformSdk {
    private val TAG = "Smartpeak"
    var hasPermission: Boolean = false;

    fun setInstance()
    {
        if(SmartPermission(context).checkPermission()) {
            ServiceManager.getInstence().init(context.applicationContext)
        }
    }
    override fun getSerialNumber(): String? {
        return try {
            ServiceManager.getInstence().getDeviceinfo().getSN()
        } catch (e: RemoteException) {
            Log.d(TAG, "Exception: ${e.message}")
            null
        }
    }

    @SuppressLint("NewApi")
    override fun getTerminalInfo(): Map<String, String?> {
        return mapOf(
            "serialNumber" to getSerialNumber(),
            "batteryLevel" to HelperUtil.getBatteryLevel(context).toString(),
            "imei" to getSerialNumber(),
            "manufacturer" to "SmartPeak",
            "model" to Build.MODEL,
            "osVersion" to "OS Version: ${Build.VERSION.SDK_INT} (API Level: ${Build.VERSION.RELEASE})",
            "sdkVersion" to Build.VERSION.SDK_INT.toString(),
            "ram" to HelperUtil.getAvailableRam(context).toString(),
            "rom" to HelperUtil.getAvailableRom().toString(),
            "firmware" to ServiceManager.getInstence().getDeviceinfo().getSystemVersion(),
            "batteryTemp" to HelperUtil.getBatteryTemperature(context).toString() + "°C",
            "networkType" to HelperUtil.getConnectionType(context)
        )
    }
    override fun installApp(path: String, packageName: String): Boolean {

        return try {
            val intent = Intent("android.intent.action.VIEW.HIDE")
            intent.setDataAndType(
                Uri.fromFile(File(path)), "application/vnd.android.package-archive"
            )
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
                context.startForegroundService(intent)
            } else {
                context.startService(intent)
            }
            true
        } catch (e: RemoteException) {
            Log.d(TAG, "Exception installApp : ${e.message}")
            false
        }
    }

    override fun rebootDevice(): Boolean {
        Log.d(TAG, "rebootDevice not implemented")
        return false
    }

    override fun setTimeZone(tz: String): Boolean {
        return try {
            TimeZone.setDefault(TimeZone.getTimeZone(tz))
            true
        } catch (e: RemoteException) {
            Log.d(TAG, "Exception setTimeZone: ${e.message}")
            false
        }
    }

    override fun shutdownDevice(): Boolean {
        Log.d(TAG, "shutdownDevice not implemented")
        return false
    }

    override fun uninstallApp(packageName: String): Boolean {
        return try {
            val intent = Intent("android.intent.action.UNINSTALL.SILENT")
            intent.putExtra("packageName", packageName)
            context.startService(intent)
            true
        } catch (e: Exception) {
            Log.d(TAG, "Exception v: ${e.message}")
            false
        }
    }

    override fun captureScreen(): Bitmap? {
        Log.d(TAG, "captureScreen not implemented")
        return null
    }
}