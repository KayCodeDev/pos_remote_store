package com.iisysgroup.itexstore.utils

import android.util.Log
import kotlinx.coroutines.*
import android.app.*
import android.content.Context
import kotlinx.coroutines.launch
import com.google.gson.Gson
import com.google.gson.reflect.TypeToken
import com.iisysgroup.itexstore.StoreFunctions
import io.netty.channel.ChannelHandlerContext
import io.netty.channel.SimpleChannelInboundHandler

class NettySocketHandler(
    private val joinMsg: String,
    private val storeFunctions: StoreFunctions,
    private val context: Context
) : SimpleChannelInboundHandler<String>() {
    companion object {
        private const val TAG = "NettyClient"
    }

    private val coroutineScope = CoroutineScope(Dispatchers.IO + SupervisorJob())


    override fun channelActive(ctx: ChannelHandlerContext) {
        ctx.writeAndFlush(joinMsg)
    }

    override fun channelRead0(ctx: ChannelHandlerContext, msg: String) {
        try {
            Log.d("Message Receiveed", msg)
            val mapType = object : TypeToken<Map<String, Any>?>() {}.type
            val socketMessage: Map<String, Any> = Gson().fromJson(msg, mapType)
            val tasks = socketMessage["tasks"]
            if (tasks is List<*> && tasks.isNotEmpty() && tasks.all { it is Map<*, *> }) {
                coroutineScope.launch {
                    try {
                        TaskHandler(storeFunctions, context).handleServerTask(
                            tasks as List<Map<String, Any>>,
                            "socket"
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

    override fun exceptionCaught(ctx: ChannelHandlerContext, cause: Throwable) {
        cause.printStackTrace()
        ctx.close()
    }
}

//class TcpClient(
//    private val storeFunctions: StoreFunctions,
//    private val context: Context
//) {
//    companion object {
//        private const val TAG = "TcpClient"
//        private const val TCP_SERVER_IP = HelperUtil.BaseUrl
//        private const val TCP_SERVER_PORT = 9091
//    }
//
//    private var socket: Socket? = null
//    private var reader: BufferedReader? = null
//    private var writer: PrintWriter? = null
//    private var connected = false
//
//    private val coroutineScope = CoroutineScope(Dispatchers.IO + SupervisorJob())
//
//    fun start() {
//        coroutineScope.launch {
//            println("About to connect")
//            connectToSocket()
//        }
//    }
//
//    private suspend fun connectToSocket() {
//        println("Is SSOCKET connected: $connected")
//        while (!connected) {
//            try {
//                socket = Socket()
//                socket!!.connect(
//                    InetSocketAddress(TCP_SERVER_IP, TCP_SERVER_PORT),
//                    5000
//                )
//                reader = BufferedReader(InputStreamReader(socket!!.getInputStream()))
//                writer = PrintWriter(socket!!.getOutputStream(), true)
//
//                println("SSocket iss: ${socket!!.isConnected}")
//
//                val serialNumber :String? = storeFunctions.getSN()
//
//                sendJoiningMessage(serialNumber)
//                startHeartbeat(serialNumber)
//                listenForMessages()
//
//                connected = true
//            } catch (e: SocketTimeoutException) {
//                Log.e(TAG, "Connection attempt timed out: ${e.message}")
//                delay(5000) // Wait 5 seconds before retrying
//            } catch (e: Exception) {
//                Log.e(TAG, "Error connecting to server: ${e.message}")
//                delay(5000) // Wait 5 seconds before retrying
//            }
//        }
//    }
//
//    private fun sendJoiningMessage(serialNumber: String?) {
//        val message = """{"action":"joining", "serialNumber": "$serialNumber"}"""
//        sendMessageToServer(message)
//    }
//
//    private fun startHeartbeat(serialNumber: String?) {
//        coroutineScope.launch {
//            while (connected) {
//                delay(60000)
//                val heartbeatMessage = """{"action":"heartbeat", "serialNumber": "$serialNumber"}"""
//                sendMessageToServer(heartbeatMessage)
//            }
//        }
//    }
//
//    private fun listenForMessages() {
//        println("Listening for Socket messages")
//        coroutineScope.launch {
//            try {
//
//                while (connected && socket != null) {
//                    val message = reader?.readLine()
//                    if (message != null) {
//                        Log.d(TAG, "Received message: $message")
//                        val mapType = object : TypeToken<Map<String, Any>?>() {}.type
//                        val socketMessage: Map<String, Any> = Gson().fromJson(message, mapType)
//                        println(socketMessage)
//                        val tasks = socketMessage["tasks"]
//                        if (tasks is List<*> && tasks.isNotEmpty() && tasks.all { it is Map<*, *> }) {
//                            println(tasks)
//                            coroutineScope.launch {
//                                try {
//                                    println("Tryting to launch tassk")
//                                    TaskHandler(storeFunctions, context).handleServerTask(
//                                        tasks as List<Map<String, Any>>,
//                                        "socket"
//                                    )
//                                } catch (e: Exception) {
//                                    Log.e(TAG, e.message!!)
//                                }
//                            }
//                        }
//                    }
//                }
//            } catch (e: Exception) {
//                Log.e(TAG, "Error reading from server: ${e.message}")
//                connected = false
//                reconnect()
//            }
//        }
//    }
//
//    private fun sendMessageToServer(message: String) {
//        coroutineScope.launch {
//            try {
//                writer?.println(message)
//            } catch (e: Exception) {
//                Log.e(TAG, "Error sending message to server: ${e.message}")
//                connected = false
//                reconnect()
//            }
//        }
//    }
//
//    private fun reconnect() {
//        coroutineScope.launch {
//            delay(10000)
//            connectToSocket()
//        }
//    }
//
//    fun stop() {
//        coroutineScope.cancel()
//        socket?.close()
//    }
//
//
//}
