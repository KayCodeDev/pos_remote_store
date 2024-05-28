// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AppImpl _$$AppImplFromJson(Map<String, dynamic> json) => _$AppImpl(
      id: json['id'] as int?,
      uuid: json['uuid'] as String?,
      status: json['status'] as String?,
      osType: json['osType'] as String?,
      name: json['name'] as String?,
      packageName: json['packageName'] as String?,
      icon: json['icon'] as String?,
      developer: json['developer'] == null
          ? null
          : Developer.fromJson(json['developer'] as Map<String, dynamic>),
      distributor: json['distributor'] == null
          ? null
          : Distributor.fromJson(json['distributor'] as Map<String, dynamic>),
      description: json['description'] as String?,
      screenShots: (json['screenShots'] as List<dynamic>?)
          ?.map((e) => AppScreenShot.fromJson(e as Map<String, dynamic>))
          .toList(),
      versions: (json['versions'] as List<dynamic>?)
          ?.map((e) => AppVersion.fromJson(e as Map<String, dynamic>))
          .toList(),
      version: json['version'] == null
          ? null
          : AppVersion.fromJson(json['version'] as Map<String, dynamic>),
      category: json['category'] == null
          ? null
          : Category.fromJson(json['category'] as Map<String, dynamic>),
      appType: json['appType'] as String?,
      downloadCount: json['downloadCount'] as int?,
      permissions: (json['permissions'] as List<dynamic>?)
          ?.map((e) => e as String?)
          .toList(),
      targetSdk: json['targetSdk'] as String?,
      compileSdk: json['compileSdk'] as String?,
      minSdk: json['minSdk'] as String?,
      maxSdk: json['maxSdk'] as String?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      action: $enumDecodeNullable(_$AppActionEnumMap, json['action']),
      oldVersion: json['oldVersion'] as String?,
    );

Map<String, dynamic> _$$AppImplToJson(_$AppImpl instance) => <String, dynamic>{
      'id': instance.id,
      'uuid': instance.uuid,
      'status': instance.status,
      'osType': instance.osType,
      'name': instance.name,
      'packageName': instance.packageName,
      'icon': instance.icon,
      'developer': instance.developer?.toJson(),
      'distributor': instance.distributor?.toJson(),
      'description': instance.description,
      'screenShots': instance.screenShots?.map((e) => e.toJson()).toList(),
      'versions': instance.versions?.map((e) => e.toJson()).toList(),
      'version': instance.version?.toJson(),
      'category': instance.category?.toJson(),
      'appType': instance.appType,
      'downloadCount': instance.downloadCount,
      'permissions': instance.permissions,
      'targetSdk': instance.targetSdk,
      'compileSdk': instance.compileSdk,
      'minSdk': instance.minSdk,
      'maxSdk': instance.maxSdk,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      'action': _$AppActionEnumMap[instance.action],
      'oldVersion': instance.oldVersion,
    };

const _$AppActionEnumMap = {
  AppAction.install: 'install',
  AppAction.update: 'update',
  AppAction.open: 'open',
};

_$AppInstallingImpl _$$AppInstallingImplFromJson(Map<String, dynamic> json) =>
    _$AppInstallingImpl(
      id: json['id'] as int?,
      uuid: json['uuid'] as String?,
      status: json['status'] as String?,
      osType: json['osType'] as String?,
      name: json['name'] as String?,
      packageName: json['packageName'] as String?,
      icon: json['icon'] as String?,
      developer: Developer.fromJson(json['developer'] as Map<String, dynamic>),
      distributor: json['distributor'] == null
          ? null
          : Distributor.fromJson(json['distributor'] as Map<String, dynamic>),
      description: json['description'] as String?,
      screenShots: (json['screenShots'] as List<dynamic>?)
          ?.map((e) => AppScreenShot.fromJson(e as Map<String, dynamic>))
          .toList(),
      versions: (json['versions'] as List<dynamic>?)
          ?.map((e) => AppVersion.fromJson(e as Map<String, dynamic>))
          .toList(),
      version: json['version'] == null
          ? null
          : AppVersion.fromJson(json['version'] as Map<String, dynamic>),
      category: json['category'] == null
          ? null
          : Category.fromJson(json['category'] as Map<String, dynamic>),
      appType: json['appType'] as String?,
      downloadCount: json['downloadCount'] as int?,
      permissions: (json['permissions'] as List<dynamic>?)
          ?.map((e) => e as String?)
          .toList(),
      targetSdk: json['targetSdk'] as String?,
      compileSdk: json['compileSdk'] as String?,
      minSdk: json['minSdk'] as String?,
      maxSdk: json['maxSdk'] as String?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      downloadProgress: (json['downloadProgress'] as num?)?.toDouble(),
      installed: json['installed'] as bool?,
    );

Map<String, dynamic> _$$AppInstallingImplToJson(_$AppInstallingImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'uuid': instance.uuid,
      'status': instance.status,
      'osType': instance.osType,
      'name': instance.name,
      'packageName': instance.packageName,
      'icon': instance.icon,
      'developer': instance.developer.toJson(),
      'distributor': instance.distributor?.toJson(),
      'description': instance.description,
      'screenShots': instance.screenShots?.map((e) => e.toJson()).toList(),
      'versions': instance.versions?.map((e) => e.toJson()).toList(),
      'version': instance.version?.toJson(),
      'category': instance.category?.toJson(),
      'appType': instance.appType,
      'downloadCount': instance.downloadCount,
      'permissions': instance.permissions,
      'targetSdk': instance.targetSdk,
      'compileSdk': instance.compileSdk,
      'minSdk': instance.minSdk,
      'maxSdk': instance.maxSdk,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      'downloadProgress': instance.downloadProgress,
      'installed': instance.installed,
    };

_$DeviceInfoImpl _$$DeviceInfoImplFromJson(Map<String, dynamic> json) =>
    _$DeviceInfoImpl(
      serialNumber: json['serialNumber'] as String?,
      batteryLevel: json['batteryLevel'] as String?,
      imei: json['imei'] as String?,
      manufacturer: json['manufacturer'] as String?,
      model: json['model'] as String?,
      osVersion: json['osVersion'] as String?,
      sdkVersion: json['sdkVersion'] as String?,
      ram: json['ram'] as String?,
      rom: json['rom'] as String?,
      firmware: json['firmware'] as String?,
      batteryTemp: json['batteryTemp'] as String?,
      networkType: json['networkType'] as String?,
      longitude: json['longitude'] as String?,
      latitude: json['latitude'] as String?,
    );

Map<String, dynamic> _$$DeviceInfoImplToJson(_$DeviceInfoImpl instance) =>
    <String, dynamic>{
      'serialNumber': instance.serialNumber,
      'batteryLevel': instance.batteryLevel,
      'imei': instance.imei,
      'manufacturer': instance.manufacturer,
      'model': instance.model,
      'osVersion': instance.osVersion,
      'sdkVersion': instance.sdkVersion,
      'ram': instance.ram,
      'rom': instance.rom,
      'firmware': instance.firmware,
      'batteryTemp': instance.batteryTemp,
      'networkType': instance.networkType,
      'longitude': instance.longitude,
      'latitude': instance.latitude,
    };

_$DeveloperImpl _$$DeveloperImplFromJson(Map<String, dynamic> json) =>
    _$DeveloperImpl(
      id: json['id'] as int?,
      uuid: json['uuid'] as String?,
      organizationName: json['organizationName'] as String?,
      country: json['country'] == null
          ? null
          : Country.fromJson(json['country'] as Map<String, dynamic>),
      status: json['status'] as String?,
      websiteUrl: json['websiteUrl'] as String?,
      supportEmail: json['supportEmail'] as String?,
    );

Map<String, dynamic> _$$DeveloperImplToJson(_$DeveloperImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'uuid': instance.uuid,
      'organizationName': instance.organizationName,
      'country': instance.country?.toJson(),
      'status': instance.status,
      'websiteUrl': instance.websiteUrl,
      'supportEmail': instance.supportEmail,
    };

_$CountryImpl _$$CountryImplFromJson(Map<String, dynamic> json) =>
    _$CountryImpl(
      id: json['id'] as int?,
      countryName: json['countryName'] as String?,
      countryCode: json['countryCode'] as String?,
      status: json['status'] as String?,
    );

Map<String, dynamic> _$$CountryImplToJson(_$CountryImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'countryName': instance.countryName,
      'countryCode': instance.countryCode,
      'status': instance.status,
    };

_$DistributorImpl _$$DistributorImplFromJson(Map<String, dynamic> json) =>
    _$DistributorImpl(
      id: json['id'] as int?,
      uuid: json['uuid'] as String?,
      distributorName: json['distributorName'] as String?,
      contactName: json['contactName'] as String?,
      contactEmail: json['contactEmail'] as String?,
      country: json['country'] == null
          ? null
          : Country.fromJson(json['country'] as Map<String, dynamic>),
      status: json['status'] as String?,
      developerId: json['developerId'] as int?,
    );

Map<String, dynamic> _$$DistributorImplToJson(_$DistributorImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'uuid': instance.uuid,
      'distributorName': instance.distributorName,
      'contactName': instance.contactName,
      'contactEmail': instance.contactEmail,
      'country': instance.country?.toJson(),
      'status': instance.status,
      'developerId': instance.developerId,
    };

_$AppScreenShotImpl _$$AppScreenShotImplFromJson(Map<String, dynamic> json) =>
    _$AppScreenShotImpl(
      id: json['id'] as int?,
      uuid: json['uuid'] as String?,
      imageUrl: json['imageUrl'] as String?,
      appId: json['appId'] as int?,
      size: json['size'] as String?,
    );

Map<String, dynamic> _$$AppScreenShotImplToJson(_$AppScreenShotImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'uuid': instance.uuid,
      'imageUrl': instance.imageUrl,
      'appId': instance.appId,
      'size': instance.size,
    };

_$AppVersionImpl _$$AppVersionImplFromJson(Map<String, dynamic> json) =>
    _$AppVersionImpl(
      id: json['id'] as int?,
      uuid: json['uuid'] as String?,
      status: json['status'] as String?,
      version: json['version'] as String?,
      versionCode: json['versionCode'] as String?,
      size: json['size'] as String?,
      updateDescription: json['updateDescription'] as String?,
      downloadCount: json['downloadCount'] as int?,
      downloadUrl: json['downloadUrl'] as String?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$$AppVersionImplToJson(_$AppVersionImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'uuid': instance.uuid,
      'status': instance.status,
      'version': instance.version,
      'versionCode': instance.versionCode,
      'size': instance.size,
      'updateDescription': instance.updateDescription,
      'downloadCount': instance.downloadCount,
      'downloadUrl': instance.downloadUrl,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };

_$CategoryImpl _$$CategoryImplFromJson(Map<String, dynamic> json) =>
    _$CategoryImpl(
      id: json['id'] as int?,
      uuid: json['uuid'] as String?,
      name: json['name'] as String?,
      status: json['status'] as String?,
    );

Map<String, dynamic> _$$CategoryImplToJson(_$CategoryImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'uuid': instance.uuid,
      'name': instance.name,
      'status': instance.status,
    };
