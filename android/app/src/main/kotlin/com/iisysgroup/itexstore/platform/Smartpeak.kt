package com.iisysgroup.itexstore.platform

import android.annotation.SuppressLint
import android.app.admin.DevicePolicyManager
import android.content.ComponentName
import android.content.Context
import android.content.Intent
import android.graphics.Bitmap
import android.net.Uri
import android.os.Build
import android.os.RemoteException
import androidx.core.content.FileProvider
import android.util.Log
import com.basewin.services.ServiceManager
import com.iisysgroup.itexstore.platform.subs.SmartPermission
import com.iisysgroup.itexstore.utils.HelperUtil
import java.io.File
import java.util.TimeZone
import com.basewin.aidl.OnGpsCallBack;
import com.basewin.define.GpsSource;


class Smartpeak(private val context: Context) : PlatformSdk {
    private val TAG = "Smartpeak"

    fun setInstance() {
        if (SmartPermission(context).checkPermission()) {
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
//            val file = File(path)
            val uri =
//                FileProvider.getUriForFile(context, "${context.packageName}.fileprovider", file)
                Uri.fromFile(File(path))

            val intent = Intent("android.intent.action.VIEW.HIDE")
            intent.setDataAndType(
                uri,
                "application/vnd.android.package-archive"
            )
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
                context.startForegroundService(intent)
            } else {
                context.startService(intent)
            }

//            val intent = Intent(context, MainActivity::class.java).apply {
//                action = "android.intent.action.VIEW.HIDE"
//                data = uri
//                type = "application/vnd.android.package-archive"
//                addFlags(Intent.FLAG_GRANT_READ_URI_PERMISSION)
//            }

//            val intent = Intent(context, MainActivity::class.java)
//            intent.action = "android.intent.action.VIEW.HIDE"
//            intent.setDataAndType(
//                uri, "application/vnd.android.package-archive"
//            )
//
//            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
//                context.startForegroundService(intent)
//            } else {
//                context.startService(intent)
//            }
            true
        } catch (e: Exception) {
            println(e)
            Log.d(TAG, "Exception installApp : ${e.message}")
            false
        }
    }

    override fun rebootDevice(): Boolean {
        return try {
            val intent = Intent()
            intent.flags = Intent.FLAG_ACTIVITY_PREVIOUS_IS_TOP
            intent.action = "com.android.settings.action.REBOOT"
            context.sendBroadcast(intent)
            true
        } catch (e: Exception) {
            println(e)
            false
        }

    }

    override fun setTimeZone(tz: String): Boolean {
        return try {
            Log.d(TAG, "setTimeZone not supported by OEM")
            false
        } catch (e: RemoteException) {
            Log.d(TAG, "Exception setTimeZone: ${e.message}")
            false
        }
    }

    override fun shutdownDevice(): Boolean {
        return try {
            val intent = Intent()
            intent.flags = Intent.FLAG_ACTIVITY_PREVIOUS_IS_TOP
            intent.action = "com.android.settings.action.SHUTDOWN"
            context.sendBroadcast(intent)
            true
        } catch (e: Exception) {
            println(e)
            false
        }
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