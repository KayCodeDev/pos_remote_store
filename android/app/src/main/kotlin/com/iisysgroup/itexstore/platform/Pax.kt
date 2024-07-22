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
            "osVersion" to "OS Version: ${Build.VERSION.RELEASE} (API Level: ${Build.VERSION.SDK_INT})",
            "sdkVersion" to Build.VERSION.SDK_INT.toString(),
            "ram" to HelperUtil.getAvailableRam(context).toString(),
            "rom" to HelperUtil.getAvailableRom().toString(),
            "firmware" to Build.VERSION.RELEASE,
            "batteryTemp" to HelperUtil.getBatteryTemperature(context).toString() + "°C",
            "networkType" to HelperUtil.getConnectionType(context),
            "printer" to getPrinterStatus()
        )
    }

    override fun installApp(path: String, packageName: String): Boolean {
        return try {
            val installed: Int = idal?.getSys()?.installApp(path)!!
           installed == 0
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
            val unInstalled: Int =  idal?.getSys()?.uninstallApp(packageName)!!
            unInstalled == 0
        } catch (e: Exception) {
            Log.d(TAG, "Exception uninstallApp : ${e.message}")
            false
        }

    }

    override fun captureScreen(): Bitmap? {
        Log.d(TAG, "captureScreen not implemented")
        return null
    }

    private fun getPrinterStatus(): String {
        val status: Int? = idal?.getPrinter()?.getStatus()!!
        var result = "N/A"
        when (status!!) {
            0 -> {
                result = "Printer OK"
            }

            2 -> {
                result = "Paper out"
            }

            3 -> {
                result = "Print Data Packet Error"
            }

            4 -> {
                result = "Printer Error"
            }

            8 -> {
                result = "Over Heat"
            }

            -6 -> {
                result = "Print Cut Jam Error"
            }

            1 -> {
                result = "Printer Busy"
            }

            -5 -> {
                result = "Printer Cover Opened"
            }

            9 -> {
                result = "Printer Battery Low"
            }

            -4 -> {
                result = "No TTF"
            }
        }

        return result
    }
}