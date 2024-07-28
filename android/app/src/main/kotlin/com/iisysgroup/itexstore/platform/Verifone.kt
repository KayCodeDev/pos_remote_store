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
import com.vfi.smartpos.deviceservice.aidl.IDeviceInfo
import com.vfi.smartpos.deviceservice.aidl.IPrinter
import com.vfi.smartpos.deviceservice.aidl.IDeviceService
import com.vfi.smartpos.system_service.aidl.IAppDeleteObserver
import com.vfi.smartpos.system_service.aidl.IAppInstallObserver
import com.vfi.smartpos.system_service.aidl.ISystemManager
import com.vfi.smartpos.system_service.aidl.settings.ISettingsManager;
import kotlinx.coroutines.suspendCancellableCoroutine
import kotlin.coroutines.resume


class Verifone(private val context: Context) : PlatformSdk {
    private val TAG = "Verifone"
    private var systemManager: ISystemManager? = null
    private var settingsManager: ISettingsManager? = null
    private var deviceService: IDeviceService? = null
    private var deviceInfo: IDeviceInfo? = null
    private var printer: IPrinter? = null

    private var isBoundDS = false
    private var isBoundSM = false

    private val ACTION = "com.vfi.smartpos.system_service"
    private val PACKAGE = "com.vfi.smartpos.system_service"
    private val CLASSNAME = "com.vfi.smartpos.system_service.SystemService"
    val ACTION_X9SERVICE = "com.vfi.smartpos.device_service"
    val PACKAGE_X9SERVICE = "com.vfi.smartpos.deviceservice"
    val CLASSNAME_X9SERVICE = "com.verifone.smartpos.service.VerifoneDeviceService"

    private val serviceConnectionDS = object : ServiceConnection {
        override fun onServiceConnected(name: ComponentName?, service: IBinder?) {
            deviceService = IDeviceService.Stub.asInterface(service)
            try {
                deviceService?.let {
                    isBoundDS = true
                    deviceInfo = it.getDeviceInfo()
                    printer = it.getPrinter()
                }
            } catch (e: RemoteException) {
                e.printStackTrace()
            }


        }

        override fun onServiceDisconnected(name: ComponentName?) {
            deviceService = null
            Log.d(TAG, "device service disconnected.");
        }
    }

    private val serviceConnectionSM = object : ServiceConnection {
        override fun onServiceConnected(name: ComponentName?, service: IBinder?) {
            systemManager = ISystemManager.Stub.asInterface(service)
            try {
                systemManager?.let {
                    isBoundSM = true
                    settingsManager = it.getSettingsManager()
                }

            } catch (e: RemoteException) {
                e.printStackTrace()
            }
        }

        override fun onServiceDisconnected(name: ComponentName?) {
            systemManager = null
            Log.d(TAG, "system service disconnected.")
        }
    }

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
        val intent = Intent()
        intent.action = action;
        intent.setClassName(packageName, className);

        context.bindService(intent, serviceConnection, Context.BIND_AUTO_CREATE)
    }

    fun unbindServices() {
//        if (isBoundDS) {
        context.unbindService(serviceConnectionDS)
//        }
//        if (isBoundSM) {
        context.unbindService(serviceConnectionSM)
//        }
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
            "osVersion" to "OS Version: ${Build.VERSION.RELEASE} (API Level: ${Build.VERSION.SDK_INT})",
            "sdkVersion" to Build.VERSION.SDK_INT.toString(),
            "ram" to deviceService?.getDeviceInfo()?.getRamAvailable(),
            "rom" to deviceService?.getDeviceInfo()?.getRomAvailable(),
            "firmware" to deviceService?.getDeviceInfo()?.getFirmwareVersion(),
            "batteryTemp" to "$batteryTemp°C",
            "networkType" to HelperUtil.getConnectionType(context),
            "printer" to getPrinterStatus()
        )
    }

    override suspend fun installApp(path: String, packageName: String): Boolean {
        return try {
            suspendCancellableCoroutine<Boolean> { continuation ->
                val installAppObserver = object : IAppInstallObserver.Stub() {
                    override fun onInstallFinished(packageName: String?, returnCode: Int) {
                        if (returnCode == 0) {
                            continuation.resume(true)
                        } else {
                            continuation.resume(false)
                        }
                    }
                }

                systemManager?.installApp(path, installAppObserver, packageName)
            }
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
            settingsManager?.setTimeZone(tz)
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

    override suspend fun uninstallApp(packageName: String): Boolean {
        return try {
            suspendCancellableCoroutine<Boolean> { continuation ->
                val uninstallAppObserver = object : IAppDeleteObserver.Stub() {

                    override fun onDeleteFinished(packageName: String?, returnCode: Int) {
                        if (returnCode == 0) {
                            continuation.resume(true)
                        } else {
                            continuation.resume(false)
                        }
                    }
                }

                systemManager?.uninstallApp(packageName, uninstallAppObserver)
            }
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

    private fun getPrinterStatus(): String {
        val status: Int? = printer?.getStatus()
        var result = "N/A"
        when (status!!) {
            0x00 -> {
                result = "Printer OK"
            }

            0xF0 -> {
                result = "Paper out"
            }

            0xF1 -> {
                result = "No Content"
            }

            0xF2 -> {
                result = "Printer Error"
            }

            0xF3 -> {
                result = "Over Heat"
            }

            0xF6 -> {
                result = "No Black Mark"
            }

            0xF7 -> {
                result = "Printer Busy"
            }

            0xFB -> {
                result = "Moto Error"
            }

            0xE1 -> {
                result = "Printer Battery Low"
            }

            0xE2 -> {
                result = "No TTF"
            }
        }

        return result
    }
}