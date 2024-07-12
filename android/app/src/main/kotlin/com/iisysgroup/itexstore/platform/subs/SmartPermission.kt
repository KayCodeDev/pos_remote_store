package com.iisysgroup.itexstore.platform.subs

import android.Manifest;
import android.annotation.TargetApi
import android.content.Context
import android.os.Build

@TargetApi(Build.VERSION_CODES.DONUT)
class SmartPermission(private val context: Context) {

    val permissionList = mutableListOf(
        Manifest.permission.ACCESS_FINE_LOCATION,
        Manifest.permission.ACCESS_COARSE_LOCATION,
        Manifest.permission.RECEIVE_BOOT_COMPLETED,
        Manifest.permission.READ_PHONE_STATE,
        Manifest.permission.WRITE_EXTERNAL_STORAGE,
        Manifest.permission.READ_EXTERNAL_STORAGE,
        "android.permission.ACCESS_NETWORK_STATE",
    )

}
