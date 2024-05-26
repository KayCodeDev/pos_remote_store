#ddi
    -keep class com.xinguodu.ddiinterface.**{*;}
    #SmartPOSJni
        -keep class com.nexgo.oaf.smartpos.jni.SmartPOSJni{*;}
    #API
        -keep class com.nexgo.oaf.smartpos.CardAPI {*;}
        -keep class com.nexgo.oaf.smartpos.DeviceAPI {*;}
        -keep class com.nexgo.oaf.smartpos.KeyAPI {*;}
        -keep class com.nexgo.oaf.smartpos.OtherAPI {*;}
        -keep class com.nexgo.oaf.smartpos.PeripheralAPI {*;}
    #DeviceEngineImpl
        -keep class com.nexgo.oaf.smartpos.apiv3.DeviceEngineImpl {*;}
