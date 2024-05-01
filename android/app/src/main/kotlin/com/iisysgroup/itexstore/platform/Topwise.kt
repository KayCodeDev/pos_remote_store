package com.iisysgroup.itexstore.platform

import android.content.ComponentName
import android.content.Context
import android.content.Intent
import android.content.ServiceConnection
import android.graphics.Bitmap
import android.os.Build
import android.os.IBinder
import android.os.RemoteException
import android.util.Log
import com.iisysgroup.itexstore.utils.HelperUtil
import com.topwise.cloudpos.aidl.AidlDeviceService
import com.topwise.cloudpos.aidl.system.AidlSystem
import com.topwise.cloudpos.aidl.system.InstallAppObserver
import com.topwise.cloudpos.aidl.system.UninstallAppObserver

import java.util.TimeZone

class Topwise(private val context: Context) : PlatformSdk {
    private val TAG = "Topwise"
    private val PACKAGE = "com.android.topwise.topusdkservice"
    private val CLASS_NAME = "com.android.topwise.topusdkservice.service.DeviceService"
    private val ACTION = "topwise_cloudpos_device_service"

    private var aidlDeviceService: AidlDeviceService? = null
    private var aidlSystem: AidlSystem? = null
    private var isServiceBound = false

    // private var serviceLatch = CountDownLatch(1)

    private val serviceConnection = object : ServiceConnection {
        override fun onServiceConnected(name: ComponentName?, service: IBinder?) {
            aidlDeviceService = AidlDeviceService.Stub.asInterface(service)
            aidlSystem = AidlSystem.Stub.asInterface(aidlDeviceService?.getSystemService())
            isServiceBound = true
            // serviceLatch.countDown()
        }

        override fun onServiceDisconnected(name: ComponentName?) {
            aidlDeviceService = null
            isServiceBound = false
        }
    }

//    init {
////        bindService()
//        // serviceLatch.await()
//    }

     fun bindService() {
        val intent = Intent()
        intent.action = ACTION;
        intent.setClassName(PACKAGE, CLASS_NAME);
        context.bindService(intent, serviceConnection, Context.BIND_AUTO_CREATE)
    }

    fun unbindService() {
        if (isServiceBound) {
            context.unbindService(serviceConnection)
            isServiceBound = false
        }
    }

    override fun getSerialNumber(): String? {
        return try {
            aidlSystem?.getSerialNo()
        } catch (e: RemoteException) {
            Log.d(TAG, "Exception getSerialNumber : ${e.message}")
            null
        }

    }

    override fun getTerminalInfo(): Map<String, String?> {

        return mapOf(
            "serialNumber" to aidlSystem?.getSerialNo(),
            "batteryLevel" to HelperUtil.getBatteryLevel(context).toString(),
            "imei" to aidlSystem?.getIMEI(1),
            "manufacturer" to aidlSystem?.getManufacture(),
            "model" to aidlSystem?.getModel(),
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
            val installAppObserver = object : InstallAppObserver.Stub() {
                override fun onInstallFinished() {
                    Log.d(TAG, "App installed successfully")
                }

                override fun onInstallError(errorCode: Int) {
                    Log.d(TAG, "Exception installing app $packageName : $errorCode")
                }
            }
            aidlSystem?.installApp(path, installAppObserver)
            true
        } catch (e: RemoteException) {
            Log.d(TAG, "Exception installApp : ${e.message}")
            false
        }
    }

    override fun rebootDevice(): Boolean {
        return try {
            aidlSystem?.reboot()
            true
        } catch (e: RemoteException) {
            Log.d(TAG, "Exception rebootDevice : ${e.message}")
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
        Log.d(TAG, "shutdownDevice not implemented")
        return false
    }

    override fun uninstallApp(packageName: String): Boolean {
        return try {
            val uninstallAppObserver = object : UninstallAppObserver.Stub() {
                override fun onUninstallFinished() {
                    Log.d(TAG, "App uninstalled successfully")
                }

                override fun onUninstallError(errorCode: Int) {
                    Log.d(TAG, "Exception uninstalling app $packageName : $errorCode")
                }
            }
            aidlSystem?.uninstallApp(packageName, uninstallAppObserver)
            true
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