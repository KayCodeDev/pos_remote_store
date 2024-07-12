package com.iisysgroup.itexstore

import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.os.Build
import android.util.Log

class BroadcastListener : BroadcastReceiver() {
    override fun onReceive(context: Context, intent: Intent) {
        val serviceIntent = Intent(context, BackgroundService::class.java)
        context.stopService(serviceIntent)
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            context.startForegroundService(serviceIntent)
        } else {
            context.startService(serviceIntent)
        }

        val networkMonitor = NetworkMonitor(context)
        networkMonitor.register()
    }

}
