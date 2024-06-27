package com.iisysgroup.itexstore.platform

import android.content.Context
import android.graphics.Bitmap
import android.os.Build
import android.os.RemoteException
import android.util.Log
import com.iisysgroup.itexstore.utils.HelperUtil
import com.nexgo.oaf.apiv3.APIProxy
import com.nexgo.oaf.apiv3.DeviceEngine
import com.nexgo.oaf.apiv3.DeviceInfo
import com.nexgo.oaf.apiv3.OnAppOperatListener
import com.nexgo.oaf.apiv3.platform.Platform
import java.util.TimeZone
import kotlinx.coroutines.suspendCancellableCoroutine
import kotlin.coroutines.resume


class Nexgo(private val context: Context) : PlatformSdk {
    private val TAG = "Nexgo"
    private var deviceEngine: DeviceEngine? = null
    private var platform: Platform? = null
    private var deviceInfo: DeviceInfo? = null

    fun setInstance() {
        try {
            deviceEngine = APIProxy.getDeviceEngine(context)
            platform = deviceEngine?.getPlatform()
            deviceInfo = deviceEngine?.getDeviceInfo()

        } catch (e: Exception) {
            Log.d(TAG, "Exception from setInstance: ${e.message}")
        }
    }

    override fun getSerialNumber(): String? {
        return try {
            deviceInfo?.getSn()
        } catch (e: RemoteException) {
            Log.d(TAG, "Exception: ${e.message}")
            null
        }
    }

    override fun getTerminalInfo(): Map<String, String?> {
        return mapOf(
            "serialNumber" to getSerialNumber(),
            "batteryLevel" to HelperUtil.getBatteryLevel(context).toString(),
            "imei" to deviceInfo?.getSn(),
            "manufacturer" to "Nexgo",
            "model" to deviceInfo?.getModel(),
            "osVersion" to "OS Version: ${Build.VERSION.SDK_INT} (API Level: ${Build.VERSION.RELEASE})",
            "sdkVersion" to Build.VERSION.SDK_INT.toString(),
            "ram" to HelperUtil.getAvailableRam(context).toString(),
            "rom" to HelperUtil.getAvailableRom().toString(),
            "firmware" to deviceInfo?.getFirmWareVer(),
            "batteryTemp" to HelperUtil.getBatteryTemperature(context).toString() + "°C",
            "networkType" to HelperUtil.getConnectionType(context)
        )
    }

    override suspend fun installApp(path: String, packageName: String): Boolean {
        return try {
            suspendCancellableCoroutine<Boolean> { continuation ->
                val installAppObserver = object : OnAppOperatListener {
                    override fun onOperatResult(result: Int) {
                        if (result == 0) {
                            continuation.resume(true)
                        } else {
                            continuation.resume(false)
                        }
                    }
                }

                platform?.installApp(path, installAppObserver)
            }
        } catch (e: RemoteException) {
            Log.d(TAG, "Exception installApp : ${e.message}")
            false
        }
    }

    override fun rebootDevice(): Boolean {
        return try {
            platform?.rebootDevice()
            true
        } catch (e: RemoteException) {
            Log.d(TAG, "Exception rebootDevice: ${e.message}")
            false
        }
    }

    override fun setTimeZone(tz: String): Boolean {
        return try {
            TimeZone.setDefault(TimeZone.getTimeZone(tz))
            true
        } catch (e: RemoteException) {
            Log.d(TAG, "Exception setTimeZone : ${e.message}")
            false
        }
    }

    override fun shutdownDevice(): Boolean {
        return try {
            platform?.shutDownDevice()
            true
        } catch (e: Exception) {
            Log.d(TAG, "Exception shutdownDevice: ${e.message}")
            false
        }
    }

    override suspend fun uninstallApp(packageName: String): Boolean {
        return try {
            suspendCancellableCoroutine<Boolean> { continuation ->
                val unInstallAppObserver = object : OnAppOperatListener {
                    override fun onOperatResult(result: Int) {
                        if (result == 0) {
                            continuation.resume(true)
                        } else {
                            continuation.resume(false)
                        }
                    }
                }

                platform?.uninstallApp(packageName, unInstallAppObserver)
            }
        } catch (e: RemoteException) {
            Log.d(TAG, "Exception uninstallApp : ${e.message}")
            false
        }
    }

    override fun captureScreen(): Bitmap? {
        Log.d(TAG, "captureScreen not implemented")
        return null
    }
}