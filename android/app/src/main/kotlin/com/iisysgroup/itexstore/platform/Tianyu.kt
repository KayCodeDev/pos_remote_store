package com.iisysgroup.itexstore.platform

import android.content.Context
import android.graphics.Bitmap
import android.os.Build
import android.os.RemoteException
import android.util.Log
import com.iisysgroup.itexstore.utils.HelperUtil
import com.whty.smartpos.tysmartposapi.ITYSmartPosApi


class Tianyu(private val context: Context) : PlatformSdk {
    private val TAG = "Tianyu"
    private var smartPosApi: ITYSmartPosApi? = null

    fun setInstance() {
        smartPosApi = ITYSmartPosApi.get(context)
    }

    override fun getSerialNumber(): String? {
        return try {
            smartPosApi?.getDeviceSN()
        } catch (e: Exception) {
            Log.d(TAG, "Exception getSerialNumber : ${e.message}")
            null
        }
    }

    override fun getTerminalInfo(): Map<String, String?> {
        return mapOf(
            "serialNumber" to getSerialNumber(),
            "batteryLevel" to HelperUtil.getBatteryLevel(context).toString(),
            "imei" to getSerialNumber(),
            "manufacturer" to "Tianyu",
            "model" to Build.MODEL,
            "osVersion" to "OS Version: ${Build.VERSION.SDK_INT} (API Level: ${Build.VERSION.RELEASE})",
            "sdkVersion" to Build.VERSION.SDK_INT.toString(),
            "ram" to HelperUtil.getAvailableRam(context).toString(),
            "rom" to HelperUtil.getAvailableRom().toString(),
            "firmware" to Build.VERSION.RELEASE,
            "batteryTemp" to HelperUtil.getBatteryTemperature(context).toString() + "°C",
            "networkType" to HelperUtil.getConnectionType(context)
        )
    }

    override fun installApp(path: String, packageName: String): Boolean {
        return try {
            smartPosApi?.installApp(path)
            true
        } catch (e: RemoteException) {
            Log.d(TAG, "Exception installApp : ${e.message}")
            false
        }
    }

    override fun rebootDevice(): Boolean {
        return try {
            smartPosApi?.reboot();
            true
        } catch (e: Exception) {
            Log.d(TAG, "Exception rebootDevice : ${e.message}")
            false
        }
    }

    override fun setTimeZone(tz: String): Boolean {
        return try {
            smartPosApi?.setTimeZone(tz)
            true
        } catch (e: RemoteException) {
            Log.d(TAG, "Exception setTimeZone : ${e.message}")
            false
        }
    }

    override fun shutdownDevice(): Boolean {
        Log.d(TAG, "shutdownDevice not implemented")
        return false
    }

    override fun uninstallApp(packageName: String): Boolean {
        return try {
            smartPosApi?.uninstallApp(packageName)
            true
        } catch (e: RemoteException) {
            Log.d(TAG, "Exception installApp : ${e.message}")
            false
        }
    }

    override fun captureScreen(): Bitmap? {
        Log.d(TAG, "captureScreen not implemented")
        return null
    }
}