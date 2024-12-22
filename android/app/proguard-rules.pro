-keep class com.sunyard.**{*;}
-keep class com.socsi.**{*;}
-keep class android.serialport.**{*;}
-keep class com.google.zxing.**{*;}
-keep class socsi.middleware.**{*;}
# Keep Paho MQTT v3 classes
-keep class org.eclipse.paho.client.mqttv3.** { *; }

# Keep Paho Android Service classes
-keep class org.eclipse.paho.android.service.** { *; }

-keep class org.eclipse.paho.** { *; }