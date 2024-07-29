package com.iisysgroup.itexstore.utils

import android.content.Context
import android.util.Log
import com.iisysgroup.itexstore.StoreFunctions
import io.netty.bootstrap.Bootstrap
import io.netty.channel.Channel
import io.netty.channel.ChannelInitializer
import io.netty.channel.ChannelOption
import io.netty.channel.EventLoopGroup
import io.netty.channel.nio.NioEventLoopGroup
import io.netty.channel.socket.SocketChannel
import io.netty.channel.socket.nio.NioSocketChannel
import io.netty.handler.codec.string.StringDecoder
import io.netty.handler.codec.string.StringEncoder
import kotlinx.coroutines.*

class NettyClient(
    private val storeFunctions: StoreFunctions,
    private val context: Context
) {
    companion object {
        private const val TAG = "NettyConnect"
        private const val TCP_SERVER_IP = HelperUtil.BaseUrl
        private const val TCP_SERVER_PORT = 9092
    }

    private val group: EventLoopGroup = NioEventLoopGroup()
    private var channel: Channel? = null

    fun start() {
        CoroutineScope(Dispatchers.IO).launch {
            val serialNumber: String? = storeFunctions.getSN()
            val joinMsg = """{"action":"joining", "serialNumber": "$serialNumber"}"""

            try {
                val bootstrap = Bootstrap()
                bootstrap.group(group)
                    .channel(NioSocketChannel::class.java)
                    .option(ChannelOption.CONNECT_TIMEOUT_MILLIS, 10000)
                    .handler(object : ChannelInitializer<SocketChannel>() {
                        override fun initChannel(ch: SocketChannel) {
                            val pipeline = ch.pipeline()
                            pipeline.addLast(StringDecoder(), StringEncoder())
                            pipeline.addLast(NettySocketHandler(joinMsg, storeFunctions, context))
                            channel = ch
                        }
                    })

                val channelFuture = bootstrap.connect(TCP_SERVER_IP, TCP_SERVER_PORT).await()
                channelFuture.channel().closeFuture().await()
            } catch (e: Exception) {
                Log.e(TAG, "Connection failed", e)
            } finally {
                stop()
            }
        }
    }

    fun stop() {
        channel?.close()
        group.shutdownGracefully()
    }
}
