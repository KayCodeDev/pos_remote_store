# Add project specific ProGuard rules here.
# By default, the flags in this file are appended to flags specified
# in F:\android\android-sdk/tools/proguard/proguard-android.txt
# You can edit the include path and order by changing the proguardFiles
# directive in build.gradle.
#
# For more details, see
#   http://developer.android.com/guide/developing/tools/proguard.html

# Add any project specific keep options here:

# If your project uses WebView with JS, uncomment the following
# and specify the fully qualified class name to the JavaScript interface
# class:
#-keepclassmembers class fqcn.of.javascript.interface.for.webview {
#   public *;
#}

# Uncomment this to preserve the line number information for
# debugging stack traces.
#-keepattributes SourceFile,LineNumberTable

# If you keep the line number information, uncomment this to
# hide the original source file name.
#-renamesourcefileattribute SourceFile

# 保持 Parcelable 不被混淆
-keep class * implements android.os.Parcelable {*;}
# 保持枚举 enum 类不被混淆
-keepclassmembers enum * {
    public static **[] values();
    public static ** valueOf(java.lang.String);
}
# 保持 native 方法不被混淆
-keepclasseswithmembernames class * {
    native <methods>;
}
# 保持自定义控件类不被混淆
-keepclasseswithmembers class * {
    public <init>(android.content.Context, android.util.AttributeSet);
}
 # 保持自定义控件类不被混淆
-keepclasseswithmembers class * {
    public <init>(android.content.Context, android.util.AttributeSet, int);
}
 # 保持自定义控件类不被混淆
-keepclassmembers class * extends android.app.Activity {
    public void *(android.view.View);
}
# 过滤注解
-keepattributes *Annotation*
-keep class * extends java.lang.annotation.Annotation {*;}
-keep interface * extends java.lang.annotation.Annotation {*;}
# 过滤泛型
-keepattributes Signature

-keep class com.whty.smartpos.tysmartposapi.* {*;}
-keep class com.whty.smartpos.tysmartposapi.ccid.listener.* {*;}
-keep class com.whty.smartpos.tysmartposapi.inner.model.* {*;}
-keep class com.whty.smartpos.tysmartposapi.modules.** {*;}
-keep class com.whty.smartpos.tysmartposapi.utils.** {*;}
-keep class com.whty.smartpos.emv.function.* {*;}

##=== NETTY Rules ===#
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