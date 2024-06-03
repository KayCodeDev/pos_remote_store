package com.iisysgroup.itexstore

import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.os.Build
import android.util.Log

//import androidx.core.content.ContextCompat

class BootCompletedReceiver : BroadcastReceiver() {
    private val TAG = "BootCompletedReceiver"
    override fun onReceive(context: Context, intent: Intent) {
        Log.d(TAG, "we are at the BootCompletedReceiver now")
        val serviceIntent = Intent(context, BackgroundService::class.java)
        Log.d(TAG, "About to start service")
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            context.startForegroundService(serviceIntent)
        } else {
            context.startService(serviceIntent)
        }
    }

//    companion object {
//        private const val ANDROID_ACTION_BOOT = "android.intent.action.BOOT_COMPLETED";
//        private const val PAX_ACTION_BOOT = "paydroid.intent.action.BOOT_COMPLETED"
//    }
}
