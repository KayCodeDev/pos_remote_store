#=== PAX Rules ===#
-keep class com.pax.dal.** {
    <fields>;
    <methods>;
}

-keep class com.pax.nep.** {
    <fields>;
    <methods>;
}

-keep class com.pax.neptunelite.** {
    <fields>;
    <methods>;
}

-keep class com.pax.neptuneliteapi.** {
    <fields>;
    <methods>;
}

# Keep Paho MQTT v3 classes
-keep class org.eclipse.paho.client.mqttv3.** { *; }

# Keep Paho Android Service classes
-keep class org.eclipse.paho.android.service.** { *; }

-keep class org.eclipse.paho.** { *; }