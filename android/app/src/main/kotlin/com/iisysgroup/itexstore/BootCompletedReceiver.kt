package com.iisysgroup.itexstore

import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.os.Build

//import androidx.core.content.ContextCompat

class BootCompletedReceiver : BroadcastReceiver() {
    override fun onReceive(context: Context, intent: Intent) {
        val serviceIntent = Intent(context, BackgroundService::class.java)
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            context.startForegroundService(serviceIntent)
        } else {
            context.startService(serviceIntent)
        }
    }


    companion object {
        private const val ANDROID_ACTION_BOOT = "android.intent.action.BOOT_COMPLETED";
    }
}
