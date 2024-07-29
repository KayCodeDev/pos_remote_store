//package com.iisysgroup.itexstore.utils
//
//
//import android.app.*
//import android.content.Context
//import android.util.Log
//import kotlinx.coroutines.Dispatchers
//import kotlinx.coroutines.launch
//import com.google.gson.Gson
//import com.google.gson.reflect.TypeToken
//import com.iisysgroup.itexstore.StoreFunctions
//import kotlinx.coroutines.delay
//import org.eclipse.paho.android.service.MqttAndroidClient
//import org.eclipse.paho.client.mqttv3.*
//import kotlinx.coroutines.*
//
//class MqttClient(
//    private val storeFunctions: StoreFunctions,
//    private val context: Context,
//) {
//    private lateinit var mqttClient: MqttAndroidClient
//    private val coroutineScope = CoroutineScope(Dispatchers.IO + SupervisorJob())
//
//    companion object {
//
//        private val MQTT_SERVER_URL = "tcp://${HelperUtil.BaseUrl}:1883"
//        private val MQTT_USERNAME = "itexstore_mqtt_broker"
//        private val MQTT_PASSWORD = "0qf+8T5siJbBC1+UBICv8U13qPlxpPWxBAyY2xO5"
//        private val MQTT_CLIENT_ID = "AndroidClient"
//        private const val TAG = "MqttClient"
//    }
//
//    fun start() {
//        coroutineScope.launch {
//            mqttClient = MqttAndroidClient(context, MQTT_SERVER_URL, MQTT_CLIENT_ID)
//            connectToMQTT()
//        }
//    }
//
//    private suspend fun connectToMQTT() {
//        val serialNumber: String? = storeFunctions.getSN()
//
//        if (mqttClient.isConnected) {
//            println("client is already connected")
//            return
//        }
//
//        val options = MqttConnectOptions()
//        options.userName = MQTT_USERNAME
//        options.password = MQTT_PASSWORD.toCharArray()
//        options.isAutomaticReconnect = true
//        options.isCleanSession = true
//        options.keepAliveInterval = 300
//
//        mqttClient.setCallback(object : MqttCallback {
//            override fun connectionLost(cause: Throwable?) {
//                println("Connection lost")
//                disconnectMQTT()
//                reconnectToMQTT()
//            }
//
//            override fun messageArrived(topic: String?, message: MqttMessage?) {
//                if (message != null) {
//                    val mapType = object : TypeToken<Map<String, Any>?>() {}.type
//                    val socketMessage: Map<String, Any> =
//                        Gson().fromJson(message.toString(), mapType)
//
//                    val tasks = socketMessage["tasks"]
//                    if (tasks is List<*> && tasks.isNotEmpty() && tasks.all { it is Map<*, *> }) {
//                        coroutineScope.launch {
//                            try {
//                                TaskHandler(storeFunctions, context).handleServerTask(
//                                    tasks as List<Map<String, Any>>, "MQTT"
//                                )
//                            } catch (e: Exception) {
//                                Log.e(TAG, e.message!!)
//                            }
//                        }
//                    }
//                }
//            }
//
//            override fun deliveryComplete(token: IMqttDeliveryToken?) {
//                println("Delivery complete")
//            }
//        })
//
//        coroutineScope.launch {
//            try {
//                mqttClient.connect(options, null, object : IMqttActionListener {
//                    override fun onSuccess(asyncActionToken: IMqttToken?) {
//                        println("Connected")
//                        subscribeToTopic("itx/terminal/$serialNumber")
//                    }
//
//                    override fun onFailure(asyncActionToken: IMqttToken?, exception: Throwable?) {
//                        println("Failed to connect MQTT: ${exception?.message}")
//                        reconnectToMQTT() // Attempt to reconnect
//                    }
//                }).waitForCompletion()
//            } catch (e: Exception) {
//                println("Connection exception: ${e.message}")
//                reconnectToMQTT() // Attempt to reconnect
//            }
//        }
//    }
//
//    private fun reconnectToMQTT() {
//        coroutineScope.launch {
//            delay(10000)
//            connectToMQTT()
//        }
//    }
//
//    private fun disconnectMQTT() {
////        coroutineScope.launch {
//        if (mqttClient.isConnected) {
//            println("Client is disconnected now")
//            mqttClient.disconnect()
//        }
////        }
//    }
//
//    private fun subscribeToTopic(topic: String) {
//        coroutineScope.launch {
//            try {
//                mqttClient.subscribe(topic, 1, null, object : IMqttActionListener {
//                    override fun onSuccess(asyncActionToken: IMqttToken?) {
//                        println("Subscribed to topic: $topic")
//                    }
//
//                    override fun onFailure(asyncActionToken: IMqttToken?, exception: Throwable?) {
//                        println("Failed to subscribe: ${exception?.message}")
//                    }
//                }).waitForCompletion()
//            } catch (e: Exception) {
//                println("Subscription exception: ${e.message}")
//            }
//        }
//    }
//
//    fun publishMessage(topic: String, payload: String) {
//        coroutineScope.launch {
//            try {
//                val mqttMessage = MqttMessage()
//                mqttMessage.payload = payload.toByteArray()
//                mqttClient.publish(topic, mqttMessage, null, object : IMqttActionListener {
//                    override fun onSuccess(asyncActionToken: IMqttToken?) {
//                        println("Message published to topic: $topic")
//                    }
//
//                    override fun onFailure(asyncActionToken: IMqttToken?, exception: Throwable?) {
//                        println("Failed to publish message: ${exception?.message}")
//                    }
//                }).waitForCompletion()
//            } catch (e: Exception) {
//                println("Publishing exception: ${e.message}")
//            }
//        }
//    }
//
//    fun stop() {
//        disconnectMQTT()
//        coroutineScope.cancel()
//    }
//
//
//}