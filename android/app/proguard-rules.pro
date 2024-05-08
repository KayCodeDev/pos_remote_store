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

#Nexgo Rules
#-keep class com.xinguodu.ddiinterface.**{*;}
#-keep class com.nexgo.oaf.smartpos.jni.SmartPOSJni{*;}
#-keep class com.nexgo.oaf.smartpos.DeviceAPI {*;}
#-keep class com.nexgo.oaf.smartpos.OtherAPI {*;}
#-keep class com.nexgo.oaf.smartpos.PeripheralAPI {*;}
#-keep class com.nexgo.oaf.smartpos.apiv3.DeviceEngineImpl {*;}