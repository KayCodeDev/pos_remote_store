package com.iisysgroup.itexstore

import com.iisysgroup.itexstore.R
import android.annotation.TargetApi
import android.app.*
import android.content.Context
import android.content.Intent
import android.os.Build
import android.os.Handler
import android.os.IBinder
import android.os.Looper
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.GlobalScope
import kotlinx.coroutines.launch
import androidx.core.app.NotificationCompat
import com.iisysgroup.itexstore.utils.HelperUtil
import com.iisysgroup.itexstore.utils.MqttClient
import com.iisysgroup.itexstore.utils.NettyClient
import com.iisysgroup.itexstore.utils.TaskHandler
import kotlin.random.Random
import java.util.concurrent.TimeUnit
import kotlinx.coroutines.delay
import org.eclipse.paho.client.mqttv3.*
import kotlinx.coroutines.*

@TargetApi(Build.VERSION_CODES.O)
class BackgroundService : Service() {
    private val TAG = "ITEXStoreBGS"

    private val handler = Handler(Looper.getMainLooper())

    private lateinit var context: Context
    private lateinit var storeFunctions: StoreFunctions
    private lateinit var nettyClient: NettyClient
    private lateinit var mqttClient: MqttClient

    private val runnableForSync: Runnable by lazy {
        Runnable {
            GlobalScope.launch(Dispatchers.IO) {
                delay(TimeUnit.SECONDS.toMillis(20))
                val taskHandler = TaskHandler(storeFunctions, context)
                taskHandler.sendSyncRequest()
            }
            handler.postDelayed(runnableForSync, TimeUnit.MINUTES.toMillis(5))
        }
    }

    private val runnableForConnectivity: Runnable by lazy {
        Runnable {
            GlobalScope.launch(Dispatchers.IO) {
                delay(TimeUnit.SECONDS.toMillis(15))
//                nettyClient = NettyClient(storeFunctions, context)
                mqttClient = MqttClient(storeFunctions, context)

//                nettyClient.start()
                mqttClient.start()

            }
            handler.postDelayed(runnableForConnectivity, TimeUnit.MINUTES.toMillis(10))
        }
    }

    override fun onCreate() {
        super.onCreate()
        context = this
        storeFunctions = StoreFunctions(this)
    }

    override fun onBind(intent: Intent): IBinder? {
        return null
    }

    override fun onStartCommand(intent: Intent?, flags: Int, startId: Int): Int {
        HelperUtil.listenToLocation(context)
        handler.post(runnableForConnectivity)
        handler.post(runnableForSync)
        startForegroundService()
        return START_STICKY
    }

    private fun startForegroundService() {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            val channelName = "ITEX Store Notification"
            val notificationChannel = NotificationChannel(
                HelperUtil.ChannelID, channelName, NotificationManager.IMPORTANCE_NONE
            )
            val manager = getSystemService(NotificationManager::class.java)
            manager.createNotificationChannel(notificationChannel)

            val notificationId: Int = Random.nextInt(0, 1000)
            val notification =
                Notification.Builder(this, HelperUtil.ChannelID).setContentTitle("ITEX Store")
                    .setContentText("ITEX Store is running").setSmallIcon(R.drawable.logo).build()

            startForeground(notificationId, notification)
        } else {
            val notificationId: Int = Random.nextInt(0, 1000)
            val notification =
                NotificationCompat.Builder(this, HelperUtil.ChannelID).setContentTitle("ITEX Store")
                    .setContentText("ITEX Store is running").setSmallIcon(R.drawable.logo).build()

            startForeground(notificationId, notification)
        }
    }

    override fun onDestroy() {
        super.onDestroy()
        handler.removeCallbacks(runnableForSync)
        handler.removeCallbacks(runnableForConnectivity)
        storeFunctions.closeService()
//        nettyClient.stop()
        mqttClient.stop()
    }
}