package com.iisysgroup.itexstore.platform.subs

import android.Manifest;
import android.annotation.TargetApi
import android.content.Context
import android.content.pm.PackageManager
import android.os.Build
import androidx.core.content.ContextCompat

@TargetApi(Build.VERSION_CODES.DONUT)
class SmartPermission(private val context: Context) {

    fun checkPermission(): Boolean {
        return permissionList.all { p ->
            ContextCompat.checkSelfPermission(
                context,
                p
            ) == PackageManager.PERMISSION_GRANTED
        }
    }

    val permissionList = mutableListOf(
        Manifest.permission.WRITE_EXTERNAL_STORAGE,
        Manifest.permission.READ_EXTERNAL_STORAGE,
        Manifest.permission.ACCESS_FINE_LOCATION,
        Manifest.permission.ACCESS_COARSE_LOCATION,
        Manifest.permission.READ_PHONE_STATE,
        Manifest.permission.WAKE_LOCK,
        "com.pos.permission.SECURITY",
        "com.pos.permission.ACCESSORY_DATETIME",
        "com.pos.permission.ACCESSORY_LED",
        "com.pos.permission.ACCESSORY_BEEP",
        "com.pos.permission.ACCESSORY_RFREGISTER",
        "com.pos.permission.COMMUNICATION",
        "com.pos.permission.PRINTER",
        "com.pos.permission.CARD_READER_ICC",
        "com.pos.permission.CARD_READER_PICC",
        "com.pos.permission.CARD_READER_MAG",
        "com.pos.permission.EMVCORE"

    )
}
