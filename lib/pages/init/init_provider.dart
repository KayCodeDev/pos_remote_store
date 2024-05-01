import 'package:flutter/material.dart';
import '../../core/providers/global_provider.dart';
import '../../core/services/navigation.dart';
import '../../route/path.dart';
import '../../utils/plugin/store_method.dart';

class InitProvider extends ChangeNotifier {
  final GlobalProvider global;

  InitProvider({required this.global});

  initState() async {

    await StoreMethod.requestLocationPermission();
    await StoreMethod.initBackgroundService();

    startService();
  }
  startService() async {
    global.setLoading(true);
    await global.initState();

    global.setLoading(false);
    if (global.errorMessage == null) {
      Map<String, dynamic> storeExtra = {
        "sdk": global.deviceInfo!.sdkVersion,
        "canRemote": int.parse(global.deviceInfo!.sdkVersion!) >= 24
      };

      goto.go(RouterPaths.store, args: storeExtra);
      global.startWebsocket();
    }
  }
}
