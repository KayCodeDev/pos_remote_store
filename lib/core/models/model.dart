// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

import '../../utils/enums.dart';

part 'model.freezed.dart';

part 'model.g.dart';

@freezed
class App with _$App {
  factory App({
    int? id,
    String? uuid,
    String? status,
    String? osType,
    String? name,
    String? packageName,
    String? icon,
    Developer? developer,
    Distributor? distributor,
    String? description,
    List<AppScreenShot>? screenShots,
    List<AppVersion>? versions,
    AppVersion? version,
    Category? category,
    String? appType,
    int? downloadCount,
    List<String?>? permissions,
    String? targetSdk,
    String? compileSdk,
    String? minSdk,
    String? maxSdk,
    DateTime? createdAt,
    DateTime? updatedAt,
    AppAction? action,
    String? oldVersion,
  }) = _App;

  factory App.fromJson(Map<String, dynamic> json) => _$AppFromJson(json);
}

@freezed
class AppInstalling with _$AppInstalling {
  factory AppInstalling({
    int? id,
    String? uuid,
    String? status,
    String? osType,
    String? name,
    String? packageName,
    String? icon,
    required Developer developer,
    Distributor? distributor,
    String? description,
    List<AppScreenShot>? screenShots,
    List<AppVersion>? versions,
    AppVersion? version,
    Category? category,
    String? appType,
    int? downloadCount,
    List<String?>? permissions,
    String? targetSdk,
    String? compileSdk,
    String? minSdk,
    String? maxSdk,
    DateTime? createdAt,
    DateTime? updatedAt,
    double? downloadProgress,
    bool? installed,
  }) = _AppInstalling;

  factory AppInstalling.fromJson(Map<String, dynamic> json) =>
      _$AppInstallingFromJson(json);
}

@freezed
class DeviceInfo with _$DeviceInfo {
  factory DeviceInfo({
    String? serialNumber,
    String? batteryLevel,
    String? imei,
    String? manufacturer,
    String? model,
    String? osVersion,
    String? sdkVersion,
    String? ram,
    String? rom,
    String? firmware,
    String? batteryTemp,
    String? networkType,
    String? longitude,
    String? latitude,
  }) = _DeviceInfo;

  factory DeviceInfo.fromJson(Map<String, dynamic> json) =>
      _$DeviceInfoFromJson(json);
}

@freezed
class Developer with _$Developer {
  factory Developer(
      {int? id,
      String? uuid,
      String? organizationName,
      Country? country,
      String? status,
      String? websiteUrl,
      String? supportEmail}) = _Developer;

  factory Developer.fromJson(Map<String, dynamic> json) =>
      _$DeveloperFromJson(json);
}

@freezed
class Country with _$Country {
  factory Country(
      {int? id,
        String? countryName,
        String? countryCode,
        String? status}) = _Country;

  factory Country.fromJson(Map<String, dynamic> json) =>
      _$CountryFromJson(json);
}

@freezed
class Distributor with _$Distributor {
  factory Distributor(
      {int? id,
      String? uuid,
      String? distributorName,
      String? contactName,
      Country? country,
      String? contactEmail,
      String? status,
      int? developerId}) = _Distributor;

  factory Distributor.fromJson(Map<String, dynamic> json) =>
      _$DistributorFromJson(json);
}

@freezed
class AppScreenShot with _$AppScreenShot {
  factory AppScreenShot(
      {int? id,
      String? uuid,
      String? imageUrl,
      int? appId,
      String? size}) = _AppScreenShot;

  factory AppScreenShot.fromJson(Map<String, dynamic> json) =>
      _$AppScreenShotFromJson(json);
}

@freezed
class AppVersion with _$AppVersion {
  factory AppVersion({
    int? id,
    String? uuid,
    String? status,
    String? version,
    String? versionCode,
    String? size,
    String? updateDescription,
    int? downloadCount,
    String? downloadUrl,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _AppVersion;

  factory AppVersion.fromJson(Map<String, dynamic> json) =>
      _$AppVersionFromJson(json);
}

@freezed
class Category with _$Category {
  factory Category({
    int? id,
    String? uuid,
    String? name,
    String? status,
  }) = _Category;

  factory Category.fromJson(Map<String, dynamic> json) =>
      _$CategoryFromJson(json);
}
