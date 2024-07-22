package com.iisysgroup.itexstore.platform

import android.graphics.Bitmap

interface PlatformSdk {
    fun getSerialNumber() : String?

    fun getTerminalInfo(): Map<String, String?>

    fun installApp(path:String, packageName : String ) : Boolean

    fun rebootDevice(): Boolean

    fun setTimeZone(tz: String) : Boolean

    fun shutdownDevice(): Boolean

    fun uninstallApp(packageName: String) : Boolean

    fun captureScreen () : Bitmap?
}