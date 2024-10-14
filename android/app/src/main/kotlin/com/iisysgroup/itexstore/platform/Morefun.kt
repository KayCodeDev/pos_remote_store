package com.iisysgroup.itexstore.platform

import android.annotation.TargetApi
import android.content.ComponentName
import android.content.Context
import android.content.Intent
import android.content.ServiceConnection
import android.graphics.Bitmap
import android.os.Build
import android.os.Bundle
import android.os.IBinder
import android.os.RemoteException
import android.util.Log
import com.iisysgroup.itexstore.utils.HelperUtil
import com.morefun.yapi.engine.DeviceInfoConstrants
import com.morefun.yapi.engine.DeviceServiceEngine
import com.morefun.yapi.engine.OnUninstallAppListener
import kotlinx.coroutines.suspendCancellableCoroutine
import kotlin.coroutines.resume

class Morefun(private val context: Context) : PlatformSdk {
    private val TAG = "Morefun"
    private val SERVICE_ACTION = "com.morefun.ysdk.service"
    private val SERVICE_PACKAGE = "com.morefun.ysdk"
    private var deviceServiceEngine: DeviceServiceEngine? = null
    private var isServiceBound = false


    private val serviceConnection = object : ServiceConnection {

        override fun onServiceDisconnected(name: ComponentName?) {
            deviceServiceEngine = null
            Log.e(TAG, "======onServiceDisconnected======")
        }

        override fun onServiceConnected(name: ComponentName?, service: IBinder) {
            deviceServiceEngine = DeviceServiceEngine.Stub.asInterface(service)
            Log.d(TAG, "======onServiceConnected======")
            linkToDeath(service)
        }

        private fun linkToDeath(service: IBinder) {
            try {
                service.linkToDeath({
                    Log.d(TAG, "======binderDied======")
                    deviceServiceEngine = null
                    bindService()
                }, 0)
            } catch (e: RemoteException) {
                e.printStackTrace()
            }
        }
    }

    @TargetApi(Build.VERSION_CODES.DONUT)
    fun bindService() {
        val intent = Intent()
        intent.action = SERVICE_ACTION
        intent.setPackage(SERVICE_PACKAGE)
        Log.d(TAG, "Binding the MoreFun Service")
        val bind: Boolean = context.bindService(intent, serviceConnection, Context.BIND_AUTO_CREATE)
        Log.d(TAG, "Morefun bind is $bind")
    }

    fun unbindService() {
//        if (isServiceBound) {
        Log.d(TAG, "Unbinding Morefun service")
        context.unbindService(serviceConnection)

//            isServiceBound = false
//        }
    }

    private fun devInfo(): Bundle? {
        return deviceServiceEngine?.getDevInfo()
    }

    override fun getSerialNumber(): String? {
        return try {
            devInfo()?.getString(DeviceInfoConstrants.COMMOM_SN)
        } catch (e: Exception) {
            Log.d(TAG, "Exception getSerialNumber : ${e.message}")
            null
        }
    }

    override fun getTerminalInfo(): Map<String, String?> {
        Log.d(TAG, devInfo()?.getString(DeviceInfoConstrants.COMMOM_SN).toString())
        return mapOf(
            "serialNumber" to devInfo()?.getString(DeviceInfoConstrants.COMMOM_SN),
            "batteryLevel" to HelperUtil.getBatteryLevel(context).toString(),
            "imei" to devInfo()?.getString(DeviceInfoConstrants.IMEI),
            "manufacturer" to "MoreFun",
            "model" to devInfo()?.getString(DeviceInfoConstrants.COMMOM_MODEL),
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
            deviceServiceEngine?.installApp(path, "", "")
            true
        } catch (e: Exception) {
            Log.d(TAG, "Exception installApp : ${e.message}")
            false
        }
    }

    override fun rebootDevice(): Boolean {
        return try {
            val bundle = Bundle()
            bundle.putBoolean(DeviceInfoConstrants.REBOOT, true)
            deviceServiceEngine?.setProperties(bundle)
            true
        } catch (e: Exception) {
            Log.d(TAG, "Exception rebootDevice : ${e.message}")
            false
        }
    }

    override fun setTimeZone(tz: String): Boolean {
        return try {
            false
        } catch (e: RemoteException) {
            Log.d(TAG, "Exception setTimeZone: ${e.message}")
            false
        }
    }

    override fun shutdownDevice(): Boolean {
        return try {
            val bundle = Bundle()
            bundle.putBoolean(DeviceInfoConstrants.POWER_OFF, true)
            deviceServiceEngine?.setProperties(bundle)
            true
        } catch (e: Exception) {
            Log.d(TAG, "Exception rebootDevice : ${e.message}")
            false
        }
    }

    override suspend fun uninstallApp(packageName: String): Boolean {
        return try {
            suspendCancellableCoroutine<Boolean> { continuation ->

                val onUninstallAppListener = object : OnUninstallAppListener.Stub() {
                    override fun onUninstallAppResult(code: Int) {
                        Log.d(TAG, "App uninstalled with code: $code")
                        if (code == 0) {
                            continuation.resume(true)
                        } else {
                            continuation.resume(false)
                        }
                    }
                }
                deviceServiceEngine?.uninstallApp(packageName, onUninstallAppListener)
            }
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