package com.iisysgroup.itexstore.platform

import android.annotation.SuppressLint
import android.annotation.TargetApi
import android.content.Context
import android.content.Intent
import android.graphics.Bitmap
import android.net.Uri
import android.os.Build
import android.os.Environment
import android.os.RemoteException
import android.util.Log
import com.iisysgroup.itexstore.utils.HelperUtil
import com.socsi.smartposapi.terminal.TerminalManager
import com.socsi.smartposapi.DeviceMaster
import java.io.BufferedReader
import java.io.File
import java.io.IOException
import java.io.InputStreamReader
import java.util.TimeZone


class Sunyard(private val context: Context) : PlatformSdk {
    private val TAG = "Sunyard"
    private var terminalManager: TerminalManager? = null
    fun setInstance() {
//        DeviceMaster.getInstance().init(context.applicationContext);
        terminalManager = TerminalManager.getInstance()
    }

    override fun getSerialNumber(): String? {
        return try {
            terminalManager?.getSN()
        } catch (e: Exception) {
            println(e)
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
            "manufacturer" to "Sunyard",
            "model" to Build.MODEL,
            "osVersion" to "OS Version: ${Build.VERSION.SDK_INT} (API Level: ${Build.VERSION.RELEASE})",
            "sdkVersion" to Build.VERSION.SDK_INT.toString(),
            "ram" to HelperUtil.getAvailableRam(context).toString(),
            "rom" to HelperUtil.getAvailableRom().toString(),
            "firmware" to terminalManager?.getDeviceInfo()?.getFirmwareVersion(),
            "batteryTemp" to HelperUtil.getBatteryTemperature(context).toString() + "°C",
            "networkType" to HelperUtil.getConnectionType(context)
        )
    }

    override fun installApp(path: String, packageName: String): Boolean {
        var result: Int
        var file = File(path)
        try {
            val args = arrayOf<String>(
                "pm", "install", "-i", packageName, "-r",
                file.absolutePath
            )
            val processBuilder = ProcessBuilder(*args)
            var process: Process? = null
            var successResult: BufferedReader? = null
            var errorResult: BufferedReader? = null
            val successMsg = StringBuilder()
            val errorMsg = StringBuilder()
            try {
                process = processBuilder.start()
                successResult = BufferedReader(InputStreamReader(process.inputStream))
                errorResult = BufferedReader(InputStreamReader(process.errorStream))
                var s: String?
                while (successResult.readLine().also { s = it } != null) {
                    successMsg.append(s)
                }
                while (errorResult.readLine().also { s = it } != null) {
                    errorMsg.append(s)
                }
            } catch (e: Exception) {
                e.printStackTrace()
                result = 2
            } finally {
                try {
                    successResult?.close()
                    errorResult?.close()
                } catch (e: IOException) {
                    e.printStackTrace()
                }
                process?.destroy()
            }
            if (successMsg.toString().contains("Success") || successMsg.toString()
                    .contains("success")
            ) {
                result = 1
                Log.i("LZF", successMsg.toString())
            } else {
                result = 2
                Log.i("LZF", errorMsg.toString())
            }
        } catch (e: Exception) {
            result = -1
            e.printStackTrace()
        }
        return result == 1
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

    @TargetApi(Build.VERSION_CODES.ICE_CREAM_SANDWICH)
    override fun uninstallApp(packageName: String): Boolean {
        return try {
            val packageURI: Uri = Uri.parse("package:$packageName")
            val intent = Intent(Intent.ACTION_DELETE, packageURI)
            intent.putExtra(Intent.EXTRA_RETURN_RESULT, true)
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
                context.startForegroundService(intent)
            } else {
                context.startService(intent)
            }
            true
        } catch (e: RemoteException) {
            Log.d(TAG, "Exception uninstallApp: ${e.message}")
            false
        }
    }

    override fun captureScreen(): Bitmap? {
        Log.d(TAG, "captureScreen not implemented")
        return null
    }
}