package com.iisysgroup.itexstore.platform

import android.content.Context
import android.graphics.Bitmap
import android.os.Build
import android.util.Log
import com.iisysgroup.itexstore.utils.HelperUtil
import com.pos.device.SDKException
import com.pos.device.SDKManager
import com.pos.device.SDKManagerCallback
import com.pos.device.sys.SystemManager
import com.pos.device.config.DevConfig
import com.pos.device.rtc.RealTimeClock

class Amp(private val context: Context) : PlatformSdk {
    private val TAG = "Amp"

    fun setInstance() {
        try {
            SDKManager.init(context, sdkManagerCallback);
        } catch (e: Exception) {
            e.printStackTrace()
            Log.d(TAG, "Exception from setInstance: ${e.message}")
        }
    }

    fun closeInstance()
    {
        SDKManager.release()
    }

    private val sdkManagerCallback: SDKManagerCallback = object : SDKManagerCallback {
        override
        fun onFinish() {
            try {
                Log.d(TAG, "SDK Initialized")
            } catch (e: SDKException) {
                e.printStackTrace()
            }
        }
    }

    override fun getSerialNumber(): String? {

        return try {
            DevConfig.getSN()
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
            "manufacturer" to "AMP",
            "model" to DevConfig.getMachine(),
            "osVersion" to "OS Version: ${Build.VERSION.SDK_INT} (API Level: ${Build.VERSION.RELEASE})",
            "sdkVersion" to Build.VERSION.SDK_INT.toString(),
            "ram" to HelperUtil.getAvailableRam(context).toString(),
            "rom" to HelperUtil.getAvailableRom().toString(),
            "firmware" to DevConfig.getFirmwareVersion(),
            "batteryTemp" to HelperUtil.getBatteryTemperature(context).toString() + "°C",
            "networkType" to HelperUtil.getConnectionType(context)
        )
    }

    override fun installApp(path: String, packageName: String): Boolean {
        return try {
            val installed: Int = SystemManager.installApp(path)
            installed == 0
        } catch (e: Exception) {
            Log.d(TAG, "Exception installApp : ${e.message}")
            false
        }

    }

    override fun rebootDevice(): Boolean {
        return try {
            SystemManager.reboot()
            true
        } catch (e: Exception) {
            Log.d(TAG, "Exception rebootDevice : ${e.message}")
            false
        }
    }

    override fun setTimeZone(tz: String): Boolean {
        return try {
            RealTimeClock.setAutoTimezone(context, true)
            true
        } catch (e: Exception) {
            Log.d(TAG, "Exception setTimeZone : ${e.message}")
            false
        }
    }

    override fun shutdownDevice(): Boolean {
        return try {
            SystemManager.shutdown()
            true
        } catch (e: Exception) {
            Log.d(TAG, "Exception shutdown : ${e.message}")
            false
        }
    }

    override fun uninstallApp(packageName: String): Boolean {
        return try {
            val uninstalled: Int = SystemManager.uninstallApp(packageName)
            uninstalled == 0
        } catch (e: Exception) {
            Log.d(TAG, "Exception uninstallApp : ${e.message}")
            false
        }
    }

    override fun captureScreen(): Bitmap? {
        Log.d(TAG, "captureScreen not implemented")
        return null
    }

}