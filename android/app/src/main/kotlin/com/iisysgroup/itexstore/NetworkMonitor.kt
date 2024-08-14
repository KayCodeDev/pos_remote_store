package com.iisysgroup.itexstore

import android.annotation.TargetApi
import android.content.Context
import android.content.Intent
import android.net.ConnectivityManager
import android.net.Network
import android.net.NetworkCapabilities
import android.net.NetworkRequest
import android.os.Build
import android.util.Log

@TargetApi(Build.VERSION_CODES.LOLLIPOP)
class NetworkMonitor(private val context: Context) {
    val TAG = "NetworkMonitor"
    private  var thereIsInternet : Boolean = true
    private val connectivityManager =
        context.getSystemService(Context.CONNECTIVITY_SERVICE) as ConnectivityManager
    private val networkCallback = object : ConnectivityManager.NetworkCallback() {
        override fun onAvailable(network: Network) {
            super.onAvailable(network)
            val networkCapabilities = connectivityManager.getNetworkCapabilities(network)
            val hasInternet =
                networkCapabilities?.hasCapability(NetworkCapabilities.NET_CAPABILITY_INTERNET) == true

            if (hasInternet) {
                Log.d(TAG, "Internet available")
//                if (!HelperUtil.isServiceRunning(BackgroundService::class.java, context) ) {
                if(!thereIsInternet){
                    Log.d(TAG, "Stop and starting a new instance of ITEXStore")
                    val serviceIntent = Intent(context, BackgroundService::class.java)
                    context.stopService(serviceIntent)
                    context.startService(serviceIntent)
                    thereIsInternet = true
                }
            }
        }

        override fun onLost(network: Network) {
            super.onLost(network)
            thereIsInternet = false
            Log.d(TAG, "Internet lost")
        }
    }

    fun register() {
        Log.d(TAG, "Registering network monitor")
        val networkRequest = NetworkRequest.Builder()
            .addCapability(NetworkCapabilities.NET_CAPABILITY_INTERNET)
            .build()
        connectivityManager.registerNetworkCallback(networkRequest, networkCallback)
    }

    fun unregister() {
        connectivityManager.unregisterNetworkCallback(networkCallback)
    }
}