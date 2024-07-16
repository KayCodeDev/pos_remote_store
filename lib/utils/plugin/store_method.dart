import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../core/models/installed_app_info.dart';
import '../../core/models/model.dart';


class StoreMethod {
  static const MethodChannel _channel = MethodChannel('itexstore_methods');

  static Future<bool> initBackgroundService() async {
    try {
      return await _channel.invokeMethod('initBackgroundService');
    } catch (e) {
      debugPrint('Error initBackgroundService: $e');
      return false;
    }
  }

  static Future<String?> getSerialNumber() async {
    return await _channel.invokeMethod('getSerialNumber');
  }

  static Future<DeviceInfo?> getDeviceInfo() async {
    var info = await _channel.invokeMethod('getDeviceInfo');
    if (info == null) {
      return null;
    } else {
      Map<String, dynamic> convertedInfo = Map<String, dynamic>.from(info);
      return DeviceInfo.fromJson(convertedInfo);
    }
  }

  static Future<bool> isNetworkConnected() async {
    return await _channel.invokeMethod("isNetworkConnected");
  }

  static Future<bool> pushMessage(String message) async {
    return await _channel.invokeMethod("pushMessage", {'message': message});
  }

  static Future<List<InstalledAppInfo>> getInstalledApps([
    bool excludeSystemApps = true,
    bool withIcon = false,
    String packageNamePrefix = "",
  ]) async {
    dynamic apps = await _channel.invokeMethod(
      "getInstalledApps",
      {
        "exclude_system_apps": excludeSystemApps,
        "with_icon": withIcon,
        "package_name_prefix": packageNamePrefix,
      },
    );
    return InstalledAppInfo.parseList(apps);
  }

  static Future<bool> startApp(String packageName) async {
    try {
      return await _channel
          .invokeMethod('startApp', {'packageName': packageName});
    } catch (e) {
      debugPrint('Error startApp: $e');
      return false;
    }
  }

  static Future<void> openSettings(String packageName) async {
    try {
      await _channel.invokeMethod('openSettings', {'packageName': packageName});
    } catch (e) {
      debugPrint('Error openSettings: $e');
    }
  }

  static Future<InstalledAppInfo?> getAppInfo(String packageName) async {
    var app = await _channel.invokeMethod(
      "getAppInfo",
      {"packageName": packageName},
    );
    if (app == null) {
      return null;
    } else {
      return InstalledAppInfo.create(app);
    }
  }

  static Future<bool> installApp(String path, String packageName) async {
    try {
      return await _channel.invokeMethod(
          'installApp', {'path': path, 'packageName': packageName});
    } catch (e) {
      debugPrint('Error installApp: $e');
      return false;
    }
  }

  static Future<bool> uninstallApp(String packageName) async {
    try {
      return await _channel
          .invokeMethod('uninstallApp', {'packageName': packageName});
    } catch (e) {
      debugPrint('Error uninstallApp: $e');
      return false;
    }
  }

  static Future<String?> requestSmartPermissions() async {
    try {
      return await _channel.invokeMethod('requestSmartPermissions');
    } catch (e) {
      debugPrint('Error requestSmartPermissions: $e');
      return "";
    }
  }
}
