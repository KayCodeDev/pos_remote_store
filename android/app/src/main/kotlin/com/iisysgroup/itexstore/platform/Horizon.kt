package com.iisysgroup.itexstore.platform

import android.annotation.SuppressLint
import android.content.Context
import android.graphics.Bitmap
import android.os.Build
import android.os.IBinder.DeathRecipient
import android.os.RemoteException
import android.util.Log
import com.horizonpay.smartpossdk.PosAidlDeviceServiceUtil
import com.horizonpay.smartpossdk.aidl.IAidlDevice
import com.horizonpay.smartpossdk.aidl.printer.IAidlPrinter
import com.horizonpay.smartpossdk.data.PrinterConst.State
import com.iisysgroup.itexstore.utils.HelperUtil

class Horizon(private val context: Context) : PlatformSdk {
    private val TAG = "Horizon"
    private var aidlDevice: IAidlDevice? = null
    private var printer: IAidlPrinter? = null

    fun bindService() {
        PosAidlDeviceServiceUtil.connectDeviceService(
            context,
            object : PosAidlDeviceServiceUtil.DeviceServiceListen {
                override fun onConnected(device: IAidlDevice) {
                    aidlDevice = device
                    printer = device.getPrinter()
                    Log.e(TAG, "connected")
                    try {
                        aidlDevice?.asBinder()?.linkToDeath(deathRecipient, 0)
                    } catch (e: RemoteException) {
                        e.printStackTrace()
                    }
                    // serviceLatch.countDown()
                }

                override fun error(errorcode: Int) {
                    Log.e(TAG, "Service Connection Error : $errorcode")
                }

                override fun onDisconnected() {
                    Log.e(TAG, "Service Disconnected")
                }

                override fun onUnCompatibleDevice() {
                }
            })
    }

    private val deathRecipient: DeathRecipient = object : DeathRecipient {
        override fun binderDied() {
            if (aidlDevice == null) {
                return
            }
            aidlDevice?.asBinder()?.unlinkToDeath(this, 0)
            aidlDevice = null

            bindService()
        }
    }
    fun unbindService()
    {

    }

    override fun getSerialNumber(): String? {
        return try {
            aidlDevice?.getSysHandler()?.getSn()
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
            "manufacturer" to "HorizonPay",
            "model" to aidlDevice?.getSysHandler()?.getModel(),
            "osVersion" to "OS Version: ${Build.VERSION.RELEASE} (API Level: ${Build.VERSION.SDK_INT})",
            "sdkVersion" to Build.VERSION.SDK_INT.toString(),
            "ram" to HelperUtil.getAvailableRam(context).toString(),
            "rom" to HelperUtil.getAvailableRom().toString(),
            "firmware" to aidlDevice?.getSysHandler()?.getFiremware()!!,
            "batteryTemp" to HelperUtil.getBatteryTemperature(context).toString() + "°C",
            "networkType" to HelperUtil.getConnectionType(context),
            "printer" to getPrinterStatus()
        )
    }

    override fun installApp(path: String, packageName: String): Boolean {
        return try {
            val status: String? = aidlDevice?.getSysHandler()?.installApp(path)
            Log.d(TAG, "Status of installation : $status")
            true
        } catch (e: RemoteException) {
            Log.d(TAG, "Exception installApp: ${e.message}")
            false
        }
    }

    override fun rebootDevice(): Boolean {
        return try {
            aidlDevice?.getSysHandler()?.reboot()
            true
        } catch (e: RemoteException) {
            Log.d(TAG, "Exception rebootDevice: ${e.message}")
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
        Log.d(TAG, "shutdownDevice not implemented")
        return rebootDevice()
    }

    override fun uninstallApp(packageName: String): Boolean {
        return try {
            aidlDevice?.getSysHandler()?.unInstallApp(packageName)
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

    private fun getPrinterStatus(): String {
        var result = "N/A"

        try {
            val status: Int? = printer?.getPrinterState()
            when (status!!) {
                State.PRINTER_STATE_NORMAL -> {
                    result = "Printer OK"
                }

                State.PRINTER_STATE_NOPAPER -> {
                    result = "Paper out"
                }

                State.PRINTER_STATE_DEV_ERROR -> {
                    result = "Printer Error"
                }

                State.PRINTER_STATE_HIGHTEMP -> {
                    result = "Over Heat"
                }

                State.PRINTER_STATE_BUSY -> {
                    result = "Printer Busy"
                }

                State.PRINTER_STATE_NOT_OPEN -> {
                    result = "Moto Error"
                }
            }
        } catch (e: RemoteException) {
            result = "Unknown"
        }

        return result

    }
}