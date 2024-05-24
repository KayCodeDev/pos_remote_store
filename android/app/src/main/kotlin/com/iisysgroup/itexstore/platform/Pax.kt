package com.iisysgroup.itexstore.platform

import android.annotation.SuppressLint
import android.content.Context
import android.graphics.Bitmap
import android.os.Build
import android.util.Log
import com.iisysgroup.itexstore.utils.HelperUtil
import com.pax.dal.IDAL
import com.pax.neptunelite.api.NeptuneLiteUser
import com.pax.dal.entity.ETermInfoKey


class Pax(private val context: Context) : PlatformSdk {
    private val TAG = "Pax"
    private var idal: IDAL? = null

    fun setInstance() {
        try {
//            idal = NeptuneLiteUser.getInstance().getDalWithProcessSafe(context)
            idal = NeptuneLiteUser.getInstance().getDal(context)
        } catch (e: Exception) {
            Log.d(TAG, "Exception from setInstance: ${e.message}")
        }
    }


    @SuppressLint("NewApi")
    override fun getSerialNumber(): String? {
        var sn: String? = null
        return try {
            val map: Map<ETermInfoKey, String>? = idal?.getSys()?.getTermInfo()

            if (map != null) {
                sn = map[ETermInfoKey.SN]
            }

            sn
        } catch (e: Exception) {
            Log.d(TAG, "Exception getSerialNumber : ${e.message}")
            null
        }

    }

    @SuppressLint("NewApi")
    override fun getTerminalInfo(): Map<String, String?> {
        return mapOf(
            "serialNumber" to getSerialNumber(),
            "batteryLevel" to HelperUtil.getBatteryLevel(context).toString(),
            "imei" to getSerialNumber(),
            "manufacturer" to "PAX",
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
            val installed: Int = idal?.getSys()?.installApp(path)!!
           installed != 1
        } catch (e: Exception) {
            Log.d(TAG, "Exception installApp : ${e.message}")
            false
        }

    }

    override fun rebootDevice(): Boolean {
        return try {
            idal?.getSys()?.reboot()
            true
        } catch (e: Exception) {
            Log.d(TAG, "Exception installApp : ${e.message}")
            false
        }

    }

    override fun setTimeZone(tz: String): Boolean {
        return try {
            idal?.getSys()?.setTimeZone(tz)
            true
        } catch (e: Exception) {
            Log.d(TAG, "Exception setTimeZone : ${e.message}")
            false
        }
    }

    override fun shutdownDevice(): Boolean {
        return try {
            idal?.getSys()?.shutdown()
            true
        } catch (e: Exception) {
            Log.d(TAG, "Exception shutdownDevice : ${e.message}")
            false
        }
    }


    override fun uninstallApp(packageName: String): Boolean {
        return try {
            val uninstalled: Int = idal?.getSys()?.uninstallApp(packageName)!!
            uninstalled == 1
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