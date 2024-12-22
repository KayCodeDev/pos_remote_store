## netty
#-keepclassmembernames class io.netty.buffer.AbstractByteBufAllocator {
#    *;
#}
#
#-keepclassmembernames class io.netty.buffer.AdvancedLeakAwareByteBuf {
#    *;
#}
#
#-keep public class io.netty.util.ReferenceCountUtil {
#    *;
#}

# Keep Paho MQTT v3 classes
-keep class org.eclipse.paho.client.mqttv3.** { *; }

# Keep Paho Android Service classes
-keep class org.eclipse.paho.android.service.** { *; }

-keep class org.eclipse.paho.** { *; }