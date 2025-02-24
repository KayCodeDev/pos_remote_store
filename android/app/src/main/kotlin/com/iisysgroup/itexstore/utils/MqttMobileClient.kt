package com.iisysgroup.itexstore.utils

import android.content.Context
import androidx.lifecycle.LifecycleObserver
import android.util.Log
import com.iisysgroup.itexstore.StoreFunctions
import kotlinx.coroutines.*
import org.eclipse.paho.client.mqttv3.*
import java.util.concurrent.atomic.AtomicBoolean
import com.google.gson.Gson
import com.google.gson.reflect.TypeToken

class MqttMobileClient(
    private val storeFunctions: StoreFunctions,
    private val context: Context
): LifecycleObserver {
    private val scope = CoroutineScope(Dispatchers.IO + SupervisorJob())

    companion object {
        private const val TAG = "MqttClient"
        private const val MQTT_SERVER_URL = "tcp://store-smartpeak.itexapp.com:1883"
        private const val MQTT_CLIENTID = "ItexStoreAgentMQTTClient"
        private const val MQTT_USERNAME= "itex-mqtt-broker"
        private const val MQTT_PASSWORD= "0qf+8T5siJbBC1+UBICv8U13qPlxpPWxBAyY2xO5"
        private const val MQTT_CS = false
        private const val MQTT_CT = 10
        private const val MQTT_KAI = 3600
        private const val MQTT_MIF = 10
        private const val MQTT_IRDMs = 5000
        private const val MQTT_MRA: Int = 10
        private const val MQTT_SERVER_TOPIC = "itexstore-mqtt-server-prod"
    }

    @Volatile
    private var client: MqttClient? = null
    private val isConnecting = AtomicBoolean(false)
    private var retryAttempts = 0

    private val callback = object : MqttCallbackExtended {
        override fun connectComplete(reconnect: Boolean, serverURI: String?) {
            Log.d(TAG, "MQTT connection established. Reconnect: $reconnect, Server URI: $serverURI")
            retryAttempts = 0
        }

        override  fun connectionLost(cause: Throwable?) {
            Log.d(TAG, "MQTT connection lost: ${cause?.message}", cause)
            scheduleReconnect()
        }

        override fun messageArrived(topic: String?, message: MqttMessage?) {
//            Log.d(TAG, "Message arrived on topic [$topic]: ${message?.toString()}")
            try {
                val mapType = object : TypeToken<Map<String, Any>?>() {}.type
                val message: Map<String, Any> = Gson().fromJson(message?.toString(), mapType)
                val tasks = message["tasks"]
                if (tasks is List<*> && tasks.isNotEmpty() && tasks.all { it is Map<*, *> }) {
                    scope.launch {
                        try {
                            TaskHandler(storeFunctions, context, this@MqttMobileClient).handleServerTask(
                                tasks as List<Map<String, Any>>,
                                "mqtt"
                            )
                        } catch (e: Exception) {
                            Log.e(TAG, e.message!!)
                        }
                    }
                }
            }catch (e: Exception){
                e.printStackTrace()
            }
        }

        override fun deliveryComplete(token: IMqttDeliveryToken?) {
            Log.d(TAG, "MQTT message delivery complete. Token: ${token?.messageId}")
        }
    }

    init {
        connectWithRetry()
    }

    /**
     * Connect to MQTT broker with retry logic.
     */
    private  fun connectWithRetry() {
        if (isConnecting.getAndSet(true)) {
            return
        }

        scope.launch {
            var connected = false
            while (!connected && retryAttempts < MQTT_MRA) {
                try {
                    connect()
                    connected = true
                } catch (ex: MqttException) {
                    retryAttempts++
                    Log.e(TAG, "Failed to connect to MQTT broker (attempt $retryAttempts/${MQTT_MRA}): ${ex.message}", ex)
                    if (retryAttempts < MQTT_MRA) {
//                        delay(MQTT_IRDMs)
                        Thread.sleep(MQTT_IRDMs.toLong())
                    } else {
                        Log.e(TAG,"Max retry attempts reached. Could not connect to MQTT broker.")
                    }
                }
            }
            isConnecting.set(false)
        }
    }

    private  fun scheduleReconnect() {
        if (retryAttempts < MQTT_MRA) {
            retryAttempts++
            scope.launch {
//                delay(MQTT_IRDMs)
                Thread.sleep(MQTT_IRDMs.toLong())
                connectWithRetry()
            }
        } else {
            Log.e(TAG,"Max retry attempts reached. Connection permanently lost.")
        }
    }

    /**
     * Connect to MQTT broker (single attempt, no retry).
     */
    @Throws(MqttException::class)
    private fun connect() {
        if (client?.isConnected == true) {
            Log.e(TAG,"Already connected to MQTT broker.")
            return
        }

        val sn: String? = storeFunctions.getSN()

        if (sn == null) {
            Log.e(TAG,"Device not supported")
            return
        }

        client?.disconnect()
        client?.close()

        val newClient = MqttClient(MQTT_SERVER_URL, MQTT_CLIENTID+"_"+sn, null)
        client = newClient

        val options = MqttConnectOptions().apply {
            isAutomaticReconnect = false
            isCleanSession = MQTT_CS
            connectionTimeout = MQTT_CT
            keepAliveInterval = MQTT_KAI
            maxInflight = MQTT_MIF
            userName = MQTT_USERNAME
            password = MQTT_PASSWORD.toCharArray()
        }

        newClient.setCallback(callback)
        newClient.connect(options)
        Log.d(TAG, "Connected to MQTT broker: $MQTT_SERVER_URL")


        if (sn != null) {
            subscribe("itexstore/mqtt/terminal/$sn")
        } else {
            subscribe("itexstore/mqtt/terminal")
        }
    }

    /**
     * Publish a message asynchronously.
     */
    fun publish(payload: String) {
        scope.launch {
            if (!ensureConnected()) {
                Log.d(TAG,"Attempted to publish message but client is not connected.")
                return@launch
            }

            try {
                val message = MqttMessage(payload.toByteArray()).apply {
                    this.qos = 1
                    this.isRetained = false
                }
                client?.publish(MQTT_SERVER_TOPIC, message)
                Log.d(TAG,"Published message to $MQTT_SERVER_TOPIC")
            } catch (ex: MqttException) {
                Log.e(TAG, "Failed to publish message to $MQTT_SERVER_TOPIC: ${ex.message}", ex)
            }
        }
    }

    /**
     * Subscribe to a topic.
     */
    private fun subscribe(topic: String, qos: Int = 1) {
        scope.launch {
            if (!ensureConnected()) {
                Log.w(TAG,"Attempted to subscribe to $topic but client is not connected.")
                return@launch
            }

            try {
                client?.subscribe(topic, qos)
                Log.i(TAG, "Subscribed to topic: $topic")
            } catch (ex: MqttException) {
                Log.e(TAG,"Failed to subscribe to $topic: ${ex.message}", ex)
            }
        }
    }


    /**
     * Disconnect gracefully.
     */
    fun disconnect() {
        scope.launch {
            try {
                client?.disconnect()
                client?.close()
                Log.d(TAG, "MQTT client disconnected.")
            } catch (ex: MqttException) {
                Log.e(TAG, "Error while disconnecting MQTT client: ${ex.message}", ex)
            }
        }
    }

    /**
     * Ensures the client is connected. If not, tries to reconnect.
     */
    private suspend fun ensureConnected(): Boolean {
        if (client?.isConnected == true) {
            return true
        }

        Log.w(TAG, "MQTT client not connected, attempting reconnection.")
        connectWithRetry()

        var attempts = 0
        while (client?.isConnected == false && attempts < MQTT_MRA) {
            delay(1000)
            attempts++
        }

        return client?.isConnected == true
    }
}