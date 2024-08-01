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