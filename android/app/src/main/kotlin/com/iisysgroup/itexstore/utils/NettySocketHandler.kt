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
