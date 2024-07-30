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

#=== NETTY Rules ===#
-keepclassmembernames class io.netty.buffer.AbstractByteBufAllocator {
    *;
}

-keepclassmembernames class io.netty.buffer.AdvancedLeakAwareByteBuf {
    *;
}

-keep public class io.netty.util.ReferenceCountUtil {
    *;
}