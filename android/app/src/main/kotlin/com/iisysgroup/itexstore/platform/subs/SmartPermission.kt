package com.iisysgroup.itexstore.platform.subs

import android.Manifest;
import android.annotation.TargetApi
import android.content.Context
import android.content.pm.PackageManager
import android.os.Build
import androidx.core.content.ContextCompat

@TargetApi(Build.VERSION_CODES.DONUT)
class SmartPermission(private val context: Context) {

//    fun checkPermission(): Boolean {
//        return permissionList.all { p ->
//            ContextCompat.checkSelfPermission(
//                context,
//                p
//            ) == PackageManager.PERMISSION_GRANTED
//        }
//    }

    val permissionList = arrayOf(
        "android.permission.ACCESS_COARSE_LOCATION",
        "android.permission.ACCESS_FINE_LOCATION",
        "android.permission.FOREGROUND_SERVICE",
//        "android.permission.FOREGROUND_SERVICE_LOCATION",
        "android.permission.RECEIVE_BOOT_COMPLETED",
        "android.permission.INTERNET",
        "android.permission.READ_PHONE_STATE",
        "android.permission.READ_PHONE_NUMBERS",
        "android.permission.WRITE_EXTERNAL_STORAGE",
        "android.permission.READ_EXTERNAL_STORAGE",
//        "android.permission.REQUEST_INSTALL_PACKAGES",
        "android.permission.REQUEST_DELETE_PACKAGES",
        "android.permission.ACCESS_NETWORK_STATE",
    )
}
