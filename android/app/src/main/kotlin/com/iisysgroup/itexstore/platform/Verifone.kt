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
import com.vfi.smartpos.deviceservice.aidl.IDeviceService
import com.vfi.smartpos.system_service.aidl.IAppDeleteObserver
import com.vfi.smartpos.system_service.aidl.IAppInstallObserver
import com.vfi.smartpos.system_service.aidl.ISystemManager
import java.util.TimeZone


class Verifone(private val context: Context) : PlatformSdk {
    private val TAG = "Verifone"
    private var deviceService: IDeviceService? = null
    private var systemManager: ISystemManager? = null
    private var isBoundDS = false
    private var isBoundSM = false

    private val ACTION = "com.vfi.smartpos.system_service"
    private val PACKAGE = "com.vfi.smartpos.system_service"
    private val CLASSNAME = "com.vfi.smartpos.system_service.SystemService"
    private val ACTION_X9SERVICE = "com.vfi.smartpos.device_service"
    private val PACKAGE_X9SERVICE = "com.vfi.smartpos.deviceservice"
    private val CLASSNAME_X9SERVICE = "com.verifone.smartpos.service.VerifoneDeviceService"

    // private var serviceLatch = CountDownLatch(2)

    private val serviceConnectionDS = object : ServiceConnection {
        override fun onServiceConnected(name: ComponentName?, service: IBinder?) {
            deviceService = IDeviceService.Stub.asInterface(service)
            isBoundDS = true
            // serviceLatch.countDown()
        }

        override fun onServiceDisconnected(name: ComponentName?) {
            deviceService = null
        }
    }

    private val serviceConnectionSM = object : ServiceConnection {
        override fun onServiceConnected(name: ComponentName?, service: IBinder?) {
            systemManager = ISystemManager.Stub.asInterface(service)
            isBoundSM = true
            // serviceLatch.countDown()
        }

        override fun onServiceDisconnected(name: ComponentName?) {
            systemManager = null
        }
    }

//    init {
//
//        // serviceLatch.await()
//    }

    fun bindAllServices() {
        bindService(ACTION, PACKAGE_X9SERVICE, CLASSNAME_X9SERVICE, serviceConnectionDS)
        bindService(ACTION_X9SERVICE, PACKAGE, CLASSNAME, serviceConnectionSM)
    }

    private fun bindService(
        action: String,
        packageName: String,
        className: String,
        serviceConnection: ServiceConnection
    ) {
        Log.d(TAG, "Binding $action $packageName")
        val intent = Intent()
        intent.action = action;
        intent.setClassName(packageName, className);

        context.bindService(intent, serviceConnection, Context.BIND_AUTO_CREATE)
    }

    fun unbindServices() {
        if (isBoundDS) {
            context.unbindService(serviceConnectionDS)
            isBoundDS = false
        }
        if (isBoundSM) {
            context.unbindService(serviceConnectionSM)
            isBoundSM = false
        }
    }

    override fun getSerialNumber(): String? {
        return try {
            deviceService?.getDeviceInfo()?.getSerialNo()
        } catch (e: Exception) {
            Log.d(TAG, "Exception getSerialNumber : ${e.message}")
            null
        }

    }

    override fun getTerminalInfo(): Map<String, String?> {
        val temp = deviceService?.getDeviceInfo()?.getBatteryTemperature()?.toDoubleOrNull()

        var batteryTemp = "0"
        if (temp != null) {
            batteryTemp = (temp / 10).toString()
        }
        return mapOf(
            "serialNumber" to deviceService?.getDeviceInfo()?.getSerialNo(),
            "batteryLevel" to deviceService?.getDeviceInfo()?.getBatteryLevel(),
            "imei" to deviceService?.getDeviceInfo()?.getIMEI(),
            "manufacturer" to "Verifone",
            "model" to deviceService?.getDeviceInfo()?.getModel(),
            "osVersion" to "OS Version: ${Build.VERSION.SDK_INT} (API Level: ${Build.VERSION.RELEASE})",
            "sdkVersion" to Build.VERSION.SDK_INT.toString(),
            "ram" to deviceService?.getDeviceInfo()?.getRamAvailable(),
            "rom" to deviceService?.getDeviceInfo()?.getRomAvailable(),
            "firmware" to deviceService?.getDeviceInfo()?.getFirmwareVersion(),
            "batteryTemp" to "$batteryTemp°C",
            "networkType" to HelperUtil.getConnectionType(context)
        )
    }

    override fun installApp(path: String, packageName: String): Boolean {
        return try {
            val installAppObserver = object : IAppInstallObserver.Stub() {
                override fun onInstallFinished(packageName: String?, returnCode: Int) {
                    Log.d(
                        TAG,
                        "App installed ${if (returnCode == 0) "Successfully" else "Failed"} : $packageName"
                    )
                }
            }
            systemManager?.installApp(path, installAppObserver, packageName)
            true
        } catch (e: Exception) {
            Log.d(TAG, "Exception installApp : ${e.message}")
            false
        }
    }

    override fun rebootDevice(): Boolean {
        return try {
            systemManager?.reboot()
            true
        } catch (e: Exception) {
            Log.d(TAG, "Exception rebootDevice : ${e.message}")
            false
        }
    }

    override fun setTimeZone(tz: String): Boolean {
        return try {
            TimeZone.setDefault(TimeZone.getTimeZone(tz))
            true
        } catch (e: Exception) {
            Log.d(TAG, "Exception setTimeZone : ${e.message}")
            false
        }
    }

    override fun shutdownDevice(): Boolean {
        return try {
            systemManager?.shutdownDevice()
            true
        } catch (e: Exception) {
            Log.d(TAG, "Exception shutdownDevice : ${e.message}")
            false
        }

    }

    override fun uninstallApp(packageName: String): Boolean {
        return try {
            val uninstallAppObserver = object : IAppDeleteObserver.Stub() {
                override fun onDeleteFinished(packageName: String, returnCode: Int) {
                    Log.d(
                        TAG,
                        "App uninstalled ${if (returnCode == 0) "Successfully" else "Failed"} : $packageName"
                    )

                }
            }
            systemManager?.uninstallApp(packageName, uninstallAppObserver)
            true
        } catch (e: RemoteException) {
            false
        }
    }

    override fun captureScreen(): Bitmap? {
        return try {
            systemManager?.takeCapture()
        } catch (e: Exception) {
            Log.d(TAG, "Exception captureScreen : ${e.message}")
            null
        }
    }
}