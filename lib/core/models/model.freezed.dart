// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

App _$AppFromJson(Map<String, dynamic> json) {
  return _App.fromJson(json);
}

/// @nodoc
mixin _$App {
  int? get id => throw _privateConstructorUsedError;
  String? get uuid => throw _privateConstructorUsedError;
  String? get status => throw _privateConstructorUsedError;
  String? get osType => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;
  String? get packageName => throw _privateConstructorUsedError;
  String? get icon => throw _privateConstructorUsedError;
  Developer? get developer => throw _privateConstructorUsedError;
  Distributor? get distributor => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  List<AppScreenShot>? get screenShots => throw _privateConstructorUsedError;
  List<AppVersion>? get versions => throw _privateConstructorUsedError;
  AppVersion? get version => throw _privateConstructorUsedError;
  Category? get category => throw _privateConstructorUsedError;
  String? get appType => throw _privateConstructorUsedError;
  int? get downloadCount => throw _privateConstructorUsedError;
  List<String?>? get permissions => throw _privateConstructorUsedError;
  String? get targetSdk => throw _privateConstructorUsedError;
  String? get compileSdk => throw _privateConstructorUsedError;
  String? get minSdk => throw _privateConstructorUsedError;
  String? get maxSdk => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;
  DateTime? get updatedAt => throw _privateConstructorUsedError;
  AppAction? get action => throw _privateConstructorUsedError;
  String? get oldVersion => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AppCopyWith<App> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AppCopyWith<$Res> {
  factory $AppCopyWith(App value, $Res Function(App) then) =
      _$AppCopyWithImpl<$Res, App>;
  @useResult
  $Res call(
      {int? id,
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
      String? oldVersion});

  $DeveloperCopyWith<$Res>? get developer;
  $DistributorCopyWith<$Res>? get distributor;
  $AppVersionCopyWith<$Res>? get version;
  $CategoryCopyWith<$Res>? get category;
}

/// @nodoc
class _$AppCopyWithImpl<$Res, $Val extends App> implements $AppCopyWith<$Res> {
  _$AppCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? uuid = freezed,
    Object? status = freezed,
    Object? osType = freezed,
    Object? name = freezed,
    Object? packageName = freezed,
    Object? icon = freezed,
    Object? developer = freezed,
    Object? distributor = freezed,
    Object? description = freezed,
    Object? screenShots = freezed,
    Object? versions = freezed,
    Object? version = freezed,
    Object? category = freezed,
    Object? appType = freezed,
    Object? downloadCount = freezed,
    Object? permissions = freezed,
    Object? targetSdk = freezed,
    Object? compileSdk = freezed,
    Object? minSdk = freezed,
    Object? maxSdk = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? action = freezed,
    Object? oldVersion = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      uuid: freezed == uuid
          ? _value.uuid
          : uuid // ignore: cast_nullable_to_non_nullable
              as String?,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String?,
      osType: freezed == osType
          ? _value.osType
          : osType // ignore: cast_nullable_to_non_nullable
              as String?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      packageName: freezed == packageName
          ? _value.packageName
          : packageName // ignore: cast_nullable_to_non_nullable
              as String?,
      icon: freezed == icon
          ? _value.icon
          : icon // ignore: cast_nullable_to_non_nullable
              as String?,
      developer: freezed == developer
          ? _value.developer
          : developer // ignore: cast_nullable_to_non_nullable
              as Developer?,
      distributor: freezed == distributor
          ? _value.distributor
          : distributor // ignore: cast_nullable_to_non_nullable
              as Distributor?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      screenShots: freezed == screenShots
          ? _value.screenShots
          : screenShots // ignore: cast_nullable_to_non_nullable
              as List<AppScreenShot>?,
      versions: freezed == versions
          ? _value.versions
          : versions // ignore: cast_nullable_to_non_nullable
              as List<AppVersion>?,
      version: freezed == version
          ? _value.version
          : version // ignore: cast_nullable_to_non_nullable
              as AppVersion?,
      category: freezed == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as Category?,
      appType: freezed == appType
          ? _value.appType
          : appType // ignore: cast_nullable_to_non_nullable
              as String?,
      downloadCount: freezed == downloadCount
          ? _value.downloadCount
          : downloadCount // ignore: cast_nullable_to_non_nullable
              as int?,
      permissions: freezed == permissions
          ? _value.permissions
          : permissions // ignore: cast_nullable_to_non_nullable
              as List<String?>?,
      targetSdk: freezed == targetSdk
          ? _value.targetSdk
          : targetSdk // ignore: cast_nullable_to_non_nullable
              as String?,
      compileSdk: freezed == compileSdk
          ? _value.compileSdk
          : compileSdk // ignore: cast_nullable_to_non_nullable
              as String?,
      minSdk: freezed == minSdk
          ? _value.minSdk
          : minSdk // ignore: cast_nullable_to_non_nullable
              as String?,
      maxSdk: freezed == maxSdk
          ? _value.maxSdk
          : maxSdk // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      action: freezed == action
          ? _value.action
          : action // ignore: cast_nullable_to_non_nullable
              as AppAction?,
      oldVersion: freezed == oldVersion
          ? _value.oldVersion
          : oldVersion // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $DeveloperCopyWith<$Res>? get developer {
    if (_value.developer == null) {
      return null;
    }

    return $DeveloperCopyWith<$Res>(_value.developer!, (value) {
      return _then(_value.copyWith(developer: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $DistributorCopyWith<$Res>? get distributor {
    if (_value.distributor == null) {
      return null;
    }

    return $DistributorCopyWith<$Res>(_value.distributor!, (value) {
      return _then(_value.copyWith(distributor: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $AppVersionCopyWith<$Res>? get version {
    if (_value.version == null) {
      return null;
    }

    return $AppVersionCopyWith<$Res>(_value.version!, (value) {
      return _then(_value.copyWith(version: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $CategoryCopyWith<$Res>? get category {
    if (_value.category == null) {
      return null;
    }

    return $CategoryCopyWith<$Res>(_value.category!, (value) {
      return _then(_value.copyWith(category: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$AppImplCopyWith<$Res> implements $AppCopyWith<$Res> {
  factory _$$AppImplCopyWith(_$AppImpl value, $Res Function(_$AppImpl) then) =
      __$$AppImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int? id,
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
      String? oldVersion});

  @override
  $DeveloperCopyWith<$Res>? get developer;
  @override
  $DistributorCopyWith<$Res>? get distributor;
  @override
  $AppVersionCopyWith<$Res>? get version;
  @override
  $CategoryCopyWith<$Res>? get category;
}

/// @nodoc
class __$$AppImplCopyWithImpl<$Res> extends _$AppCopyWithImpl<$Res, _$AppImpl>
    implements _$$AppImplCopyWith<$Res> {
  __$$AppImplCopyWithImpl(_$AppImpl _value, $Res Function(_$AppImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? uuid = freezed,
    Object? status = freezed,
    Object? osType = freezed,
    Object? name = freezed,
    Object? packageName = freezed,
    Object? icon = freezed,
    Object? developer = freezed,
    Object? distributor = freezed,
    Object? description = freezed,
    Object? screenShots = freezed,
    Object? versions = freezed,
    Object? version = freezed,
    Object? category = freezed,
    Object? appType = freezed,
    Object? downloadCount = freezed,
    Object? permissions = freezed,
    Object? targetSdk = freezed,
    Object? compileSdk = freezed,
    Object? minSdk = freezed,
    Object? maxSdk = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? action = freezed,
    Object? oldVersion = freezed,
  }) {
    return _then(_$AppImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      uuid: freezed == uuid
          ? _value.uuid
          : uuid // ignore: cast_nullable_to_non_nullable
              as String?,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String?,
      osType: freezed == osType
          ? _value.osType
          : osType // ignore: cast_nullable_to_non_nullable
              as String?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      packageName: freezed == packageName
          ? _value.packageName
          : packageName // ignore: cast_nullable_to_non_nullable
              as String?,
      icon: freezed == icon
          ? _value.icon
          : icon // ignore: cast_nullable_to_non_nullable
              as String?,
      developer: freezed == developer
          ? _value.developer
          : developer // ignore: cast_nullable_to_non_nullable
              as Developer?,
      distributor: freezed == distributor
          ? _value.distributor
          : distributor // ignore: cast_nullable_to_non_nullable
              as Distributor?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      screenShots: freezed == screenShots
          ? _value._screenShots
          : screenShots // ignore: cast_nullable_to_non_nullable
              as List<AppScreenShot>?,
      versions: freezed == versions
          ? _value._versions
          : versions // ignore: cast_nullable_to_non_nullable
              as List<AppVersion>?,
      version: freezed == version
          ? _value.version
          : version // ignore: cast_nullable_to_non_nullable
              as AppVersion?,
      category: freezed == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as Category?,
      appType: freezed == appType
          ? _value.appType
          : appType // ignore: cast_nullable_to_non_nullable
              as String?,
      downloadCount: freezed == downloadCount
          ? _value.downloadCount
          : downloadCount // ignore: cast_nullable_to_non_nullable
              as int?,
      permissions: freezed == permissions
          ? _value._permissions
          : permissions // ignore: cast_nullable_to_non_nullable
              as List<String?>?,
      targetSdk: freezed == targetSdk
          ? _value.targetSdk
          : targetSdk // ignore: cast_nullable_to_non_nullable
              as String?,
      compileSdk: freezed == compileSdk
          ? _value.compileSdk
          : compileSdk // ignore: cast_nullable_to_non_nullable
              as String?,
      minSdk: freezed == minSdk
          ? _value.minSdk
          : minSdk // ignore: cast_nullable_to_non_nullable
              as String?,
      maxSdk: freezed == maxSdk
          ? _value.maxSdk
          : maxSdk // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      action: freezed == action
          ? _value.action
          : action // ignore: cast_nullable_to_non_nullable
              as AppAction?,
      oldVersion: freezed == oldVersion
          ? _value.oldVersion
          : oldVersion // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AppImpl with DiagnosticableTreeMixin implements _App {
  _$AppImpl(
      {this.id,
      this.uuid,
      this.status,
      this.osType,
      this.name,
      this.packageName,
      this.icon,
      this.developer,
      this.distributor,
      this.description,
      final List<AppScreenShot>? screenShots,
      final List<AppVersion>? versions,
      this.version,
      this.category,
      this.appType,
      this.downloadCount,
      final List<String?>? permissions,
      this.targetSdk,
      this.compileSdk,
      this.minSdk,
      this.maxSdk,
      this.createdAt,
      this.updatedAt,
      this.action,
      this.oldVersion})
      : _screenShots = screenShots,
        _versions = versions,
        _permissions = permissions;

  factory _$AppImpl.fromJson(Map<String, dynamic> json) =>
      _$$AppImplFromJson(json);

  @override
  final int? id;
  @override
  final String? uuid;
  @override
  final String? status;
  @override
  final String? osType;
  @override
  final String? name;
  @override
  final String? packageName;
  @override
  final String? icon;
  @override
  final Developer? developer;
  @override
  final Distributor? distributor;
  @override
  final String? description;
  final List<AppScreenShot>? _screenShots;
  @override
  List<AppScreenShot>? get screenShots {
    final value = _screenShots;
    if (value == null) return null;
    if (_screenShots is EqualUnmodifiableListView) return _screenShots;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<AppVersion>? _versions;
  @override
  List<AppVersion>? get versions {
    final value = _versions;
    if (value == null) return null;
    if (_versions is EqualUnmodifiableListView) return _versions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final AppVersion? version;
  @override
  final Category? category;
  @override
  final String? appType;
  @override
  final int? downloadCount;
  final List<String?>? _permissions;
  @override
  List<String?>? get permissions {
    final value = _permissions;
    if (value == null) return null;
    if (_permissions is EqualUnmodifiableListView) return _permissions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final String? targetSdk;
  @override
  final String? compileSdk;
  @override
  final String? minSdk;
  @override
  final String? maxSdk;
  @override
  final DateTime? createdAt;
  @override
  final DateTime? updatedAt;
  @override
  final AppAction? action;
  @override
  final String? oldVersion;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'App(id: $id, uuid: $uuid, status: $status, osType: $osType, name: $name, packageName: $packageName, icon: $icon, developer: $developer, distributor: $distributor, description: $description, screenShots: $screenShots, versions: $versions, version: $version, category: $category, appType: $appType, downloadCount: $downloadCount, permissions: $permissions, targetSdk: $targetSdk, compileSdk: $compileSdk, minSdk: $minSdk, maxSdk: $maxSdk, createdAt: $createdAt, updatedAt: $updatedAt, action: $action, oldVersion: $oldVersion)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'App'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('uuid', uuid))
      ..add(DiagnosticsProperty('status', status))
      ..add(DiagnosticsProperty('osType', osType))
      ..add(DiagnosticsProperty('name', name))
      ..add(DiagnosticsProperty('packageName', packageName))
      ..add(DiagnosticsProperty('icon', icon))
      ..add(DiagnosticsProperty('developer', developer))
      ..add(DiagnosticsProperty('distributor', distributor))
      ..add(DiagnosticsProperty('description', description))
      ..add(DiagnosticsProperty('screenShots', screenShots))
      ..add(DiagnosticsProperty('versions', versions))
      ..add(DiagnosticsProperty('version', version))
      ..add(DiagnosticsProperty('category', category))
      ..add(DiagnosticsProperty('appType', appType))
      ..add(DiagnosticsProperty('downloadCount', downloadCount))
      ..add(DiagnosticsProperty('permissions', permissions))
      ..add(DiagnosticsProperty('targetSdk', targetSdk))
      ..add(DiagnosticsProperty('compileSdk', compileSdk))
      ..add(DiagnosticsProperty('minSdk', minSdk))
      ..add(DiagnosticsProperty('maxSdk', maxSdk))
      ..add(DiagnosticsProperty('createdAt', createdAt))
      ..add(DiagnosticsProperty('updatedAt', updatedAt))
      ..add(DiagnosticsProperty('action', action))
      ..add(DiagnosticsProperty('oldVersion', oldVersion));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AppImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.uuid, uuid) || other.uuid == uuid) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.osType, osType) || other.osType == osType) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.packageName, packageName) ||
                other.packageName == packageName) &&
            (identical(other.icon, icon) || other.icon == icon) &&
            (identical(other.developer, developer) ||
                other.developer == developer) &&
            (identical(other.distributor, distributor) ||
                other.distributor == distributor) &&
            (identical(other.description, description) ||
                other.description == description) &&
            const DeepCollectionEquality()
                .equals(other._screenShots, _screenShots) &&
            const DeepCollectionEquality().equals(other._versions, _versions) &&
            (identical(other.version, version) || other.version == version) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.appType, appType) || other.appType == appType) &&
            (identical(other.downloadCount, downloadCount) ||
                other.downloadCount == downloadCount) &&
            const DeepCollectionEquality()
                .equals(other._permissions, _permissions) &&
            (identical(other.targetSdk, targetSdk) ||
                other.targetSdk == targetSdk) &&
            (identical(other.compileSdk, compileSdk) ||
                other.compileSdk == compileSdk) &&
            (identical(other.minSdk, minSdk) || other.minSdk == minSdk) &&
            (identical(other.maxSdk, maxSdk) || other.maxSdk == maxSdk) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.action, action) || other.action == action) &&
            (identical(other.oldVersion, oldVersion) ||
                other.oldVersion == oldVersion));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        id,
        uuid,
        status,
        osType,
        name,
        packageName,
        icon,
        developer,
        distributor,
        description,
        const DeepCollectionEquality().hash(_screenShots),
        const DeepCollectionEquality().hash(_versions),
        version,
        category,
        appType,
        downloadCount,
        const DeepCollectionEquality().hash(_permissions),
        targetSdk,
        compileSdk,
        minSdk,
        maxSdk,
        createdAt,
        updatedAt,
        action,
        oldVersion
      ]);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AppImplCopyWith<_$AppImpl> get copyWith =>
      __$$AppImplCopyWithImpl<_$AppImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AppImplToJson(
      this,
    );
  }
}

abstract class _App implements App {
  factory _App(
      {final int? id,
      final String? uuid,
      final String? status,
      final String? osType,
      final String? name,
      final String? packageName,
      final String? icon,
      final Developer? developer,
      final Distributor? distributor,
      final String? description,
      final List<AppScreenShot>? screenShots,
      final List<AppVersion>? versions,
      final AppVersion? version,
      final Category? category,
      final String? appType,
      final int? downloadCount,
      final List<String?>? permissions,
      final String? targetSdk,
      final String? compileSdk,
      final String? minSdk,
      final String? maxSdk,
      final DateTime? createdAt,
      final DateTime? updatedAt,
      final AppAction? action,
      final String? oldVersion}) = _$AppImpl;

  factory _App.fromJson(Map<String, dynamic> json) = _$AppImpl.fromJson;

  @override
  int? get id;
  @override
  String? get uuid;
  @override
  String? get status;
  @override
  String? get osType;
  @override
  String? get name;
  @override
  String? get packageName;
  @override
  String? get icon;
  @override
  Developer? get developer;
  @override
  Distributor? get distributor;
  @override
  String? get description;
  @override
  List<AppScreenShot>? get screenShots;
  @override
  List<AppVersion>? get versions;
  @override
  AppVersion? get version;
  @override
  Category? get category;
  @override
  String? get appType;
  @override
  int? get downloadCount;
  @override
  List<String?>? get permissions;
  @override
  String? get targetSdk;
  @override
  String? get compileSdk;
  @override
  String? get minSdk;
  @override
  String? get maxSdk;
  @override
  DateTime? get createdAt;
  @override
  DateTime? get updatedAt;
  @override
  AppAction? get action;
  @override
  String? get oldVersion;
  @override
  @JsonKey(ignore: true)
  _$$AppImplCopyWith<_$AppImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

AppInstalling _$AppInstallingFromJson(Map<String, dynamic> json) {
  return _AppInstalling.fromJson(json);
}

/// @nodoc
mixin _$AppInstalling {
  int? get id => throw _privateConstructorUsedError;
  String? get uuid => throw _privateConstructorUsedError;
  String? get status => throw _privateConstructorUsedError;
  String? get osType => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;
  String? get packageName => throw _privateConstructorUsedError;
  String? get icon => throw _privateConstructorUsedError;
  Developer get developer => throw _privateConstructorUsedError;
  Distributor? get distributor => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  List<AppScreenShot>? get screenShots => throw _privateConstructorUsedError;
  List<AppVersion>? get versions => throw _privateConstructorUsedError;
  AppVersion? get version => throw _privateConstructorUsedError;
  Category? get category => throw _privateConstructorUsedError;
  String? get appType => throw _privateConstructorUsedError;
  int? get downloadCount => throw _privateConstructorUsedError;
  List<String?>? get permissions => throw _privateConstructorUsedError;
  String? get targetSdk => throw _privateConstructorUsedError;
  String? get compileSdk => throw _privateConstructorUsedError;
  String? get minSdk => throw _privateConstructorUsedError;
  String? get maxSdk => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;
  DateTime? get updatedAt => throw _privateConstructorUsedError;
  double? get downloadProgress => throw _privateConstructorUsedError;
  bool? get installed => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AppInstallingCopyWith<AppInstalling> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AppInstallingCopyWith<$Res> {
  factory $AppInstallingCopyWith(
          AppInstalling value, $Res Function(AppInstalling) then) =
      _$AppInstallingCopyWithImpl<$Res, AppInstalling>;
  @useResult
  $Res call(
      {int? id,
      String? uuid,
      String? status,
      String? osType,
      String? name,
      String? packageName,
      String? icon,
      Developer developer,
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
      bool? installed});

  $DeveloperCopyWith<$Res> get developer;
  $DistributorCopyWith<$Res>? get distributor;
  $AppVersionCopyWith<$Res>? get version;
  $CategoryCopyWith<$Res>? get category;
}

/// @nodoc
class _$AppInstallingCopyWithImpl<$Res, $Val extends AppInstalling>
    implements $AppInstallingCopyWith<$Res> {
  _$AppInstallingCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? uuid = freezed,
    Object? status = freezed,
    Object? osType = freezed,
    Object? name = freezed,
    Object? packageName = freezed,
    Object? icon = freezed,
    Object? developer = null,
    Object? distributor = freezed,
    Object? description = freezed,
    Object? screenShots = freezed,
    Object? versions = freezed,
    Object? version = freezed,
    Object? category = freezed,
    Object? appType = freezed,
    Object? downloadCount = freezed,
    Object? permissions = freezed,
    Object? targetSdk = freezed,
    Object? compileSdk = freezed,
    Object? minSdk = freezed,
    Object? maxSdk = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? downloadProgress = freezed,
    Object? installed = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      uuid: freezed == uuid
          ? _value.uuid
          : uuid // ignore: cast_nullable_to_non_nullable
              as String?,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String?,
      osType: freezed == osType
          ? _value.osType
          : osType // ignore: cast_nullable_to_non_nullable
              as String?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      packageName: freezed == packageName
          ? _value.packageName
          : packageName // ignore: cast_nullable_to_non_nullable
              as String?,
      icon: freezed == icon
          ? _value.icon
          : icon // ignore: cast_nullable_to_non_nullable
              as String?,
      developer: null == developer
          ? _value.developer
          : developer // ignore: cast_nullable_to_non_nullable
              as Developer,
      distributor: freezed == distributor
          ? _value.distributor
          : distributor // ignore: cast_nullable_to_non_nullable
              as Distributor?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      screenShots: freezed == screenShots
          ? _value.screenShots
          : screenShots // ignore: cast_nullable_to_non_nullable
              as List<AppScreenShot>?,
      versions: freezed == versions
          ? _value.versions
          : versions // ignore: cast_nullable_to_non_nullable
              as List<AppVersion>?,
      version: freezed == version
          ? _value.version
          : version // ignore: cast_nullable_to_non_nullable
              as AppVersion?,
      category: freezed == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as Category?,
      appType: freezed == appType
          ? _value.appType
          : appType // ignore: cast_nullable_to_non_nullable
              as String?,
      downloadCount: freezed == downloadCount
          ? _value.downloadCount
          : downloadCount // ignore: cast_nullable_to_non_nullable
              as int?,
      permissions: freezed == permissions
          ? _value.permissions
          : permissions // ignore: cast_nullable_to_non_nullable
              as List<String?>?,
      targetSdk: freezed == targetSdk
          ? _value.targetSdk
          : targetSdk // ignore: cast_nullable_to_non_nullable
              as String?,
      compileSdk: freezed == compileSdk
          ? _value.compileSdk
          : compileSdk // ignore: cast_nullable_to_non_nullable
              as String?,
      minSdk: freezed == minSdk
          ? _value.minSdk
          : minSdk // ignore: cast_nullable_to_non_nullable
              as String?,
      maxSdk: freezed == maxSdk
          ? _value.maxSdk
          : maxSdk // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      downloadProgress: freezed == downloadProgress
          ? _value.downloadProgress
          : downloadProgress // ignore: cast_nullable_to_non_nullable
              as double?,
      installed: freezed == installed
          ? _value.installed
          : installed // ignore: cast_nullable_to_non_nullable
              as bool?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $DeveloperCopyWith<$Res> get developer {
    return $DeveloperCopyWith<$Res>(_value.developer, (value) {
      return _then(_value.copyWith(developer: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $DistributorCopyWith<$Res>? get distributor {
    if (_value.distributor == null) {
      return null;
    }

    return $DistributorCopyWith<$Res>(_value.distributor!, (value) {
      return _then(_value.copyWith(distributor: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $AppVersionCopyWith<$Res>? get version {
    if (_value.version == null) {
      return null;
    }

    return $AppVersionCopyWith<$Res>(_value.version!, (value) {
      return _then(_value.copyWith(version: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $CategoryCopyWith<$Res>? get category {
    if (_value.category == null) {
      return null;
    }

    return $CategoryCopyWith<$Res>(_value.category!, (value) {
      return _then(_value.copyWith(category: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$AppInstallingImplCopyWith<$Res>
    implements $AppInstallingCopyWith<$Res> {
  factory _$$AppInstallingImplCopyWith(
          _$AppInstallingImpl value, $Res Function(_$AppInstallingImpl) then) =
      __$$AppInstallingImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int? id,
      String? uuid,
      String? status,
      String? osType,
      String? name,
      String? packageName,
      String? icon,
      Developer developer,
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
      bool? installed});

  @override
  $DeveloperCopyWith<$Res> get developer;
  @override
  $DistributorCopyWith<$Res>? get distributor;
  @override
  $AppVersionCopyWith<$Res>? get version;
  @override
  $CategoryCopyWith<$Res>? get category;
}

/// @nodoc
class __$$AppInstallingImplCopyWithImpl<$Res>
    extends _$AppInstallingCopyWithImpl<$Res, _$AppInstallingImpl>
    implements _$$AppInstallingImplCopyWith<$Res> {
  __$$AppInstallingImplCopyWithImpl(
      _$AppInstallingImpl _value, $Res Function(_$AppInstallingImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? uuid = freezed,
    Object? status = freezed,
    Object? osType = freezed,
    Object? name = freezed,
    Object? packageName = freezed,
    Object? icon = freezed,
    Object? developer = null,
    Object? distributor = freezed,
    Object? description = freezed,
    Object? screenShots = freezed,
    Object? versions = freezed,
    Object? version = freezed,
    Object? category = freezed,
    Object? appType = freezed,
    Object? downloadCount = freezed,
    Object? permissions = freezed,
    Object? targetSdk = freezed,
    Object? compileSdk = freezed,
    Object? minSdk = freezed,
    Object? maxSdk = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? downloadProgress = freezed,
    Object? installed = freezed,
  }) {
    return _then(_$AppInstallingImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      uuid: freezed == uuid
          ? _value.uuid
          : uuid // ignore: cast_nullable_to_non_nullable
              as String?,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String?,
      osType: freezed == osType
          ? _value.osType
          : osType // ignore: cast_nullable_to_non_nullable
              as String?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      packageName: freezed == packageName
          ? _value.packageName
          : packageName // ignore: cast_nullable_to_non_nullable
              as String?,
      icon: freezed == icon
          ? _value.icon
          : icon // ignore: cast_nullable_to_non_nullable
              as String?,
      developer: null == developer
          ? _value.developer
          : developer // ignore: cast_nullable_to_non_nullable
              as Developer,
      distributor: freezed == distributor
          ? _value.distributor
          : distributor // ignore: cast_nullable_to_non_nullable
              as Distributor?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      screenShots: freezed == screenShots
          ? _value._screenShots
          : screenShots // ignore: cast_nullable_to_non_nullable
              as List<AppScreenShot>?,
      versions: freezed == versions
          ? _value._versions
          : versions // ignore: cast_nullable_to_non_nullable
              as List<AppVersion>?,
      version: freezed == version
          ? _value.version
          : version // ignore: cast_nullable_to_non_nullable
              as AppVersion?,
      category: freezed == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as Category?,
      appType: freezed == appType
          ? _value.appType
          : appType // ignore: cast_nullable_to_non_nullable
              as String?,
      downloadCount: freezed == downloadCount
          ? _value.downloadCount
          : downloadCount // ignore: cast_nullable_to_non_nullable
              as int?,
      permissions: freezed == permissions
          ? _value._permissions
          : permissions // ignore: cast_nullable_to_non_nullable
              as List<String?>?,
      targetSdk: freezed == targetSdk
          ? _value.targetSdk
          : targetSdk // ignore: cast_nullable_to_non_nullable
              as String?,
      compileSdk: freezed == compileSdk
          ? _value.compileSdk
          : compileSdk // ignore: cast_nullable_to_non_nullable
              as String?,
      minSdk: freezed == minSdk
          ? _value.minSdk
          : minSdk // ignore: cast_nullable_to_non_nullable
              as String?,
      maxSdk: freezed == maxSdk
          ? _value.maxSdk
          : maxSdk // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      downloadProgress: freezed == downloadProgress
          ? _value.downloadProgress
          : downloadProgress // ignore: cast_nullable_to_non_nullable
              as double?,
      installed: freezed == installed
          ? _value.installed
          : installed // ignore: cast_nullable_to_non_nullable
              as bool?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AppInstallingImpl
    with DiagnosticableTreeMixin
    implements _AppInstalling {
  _$AppInstallingImpl(
      {this.id,
      this.uuid,
      this.status,
      this.osType,
      this.name,
      this.packageName,
      this.icon,
      required this.developer,
      this.distributor,
      this.description,
      final List<AppScreenShot>? screenShots,
      final List<AppVersion>? versions,
      this.version,
      this.category,
      this.appType,
      this.downloadCount,
      final List<String?>? permissions,
      this.targetSdk,
      this.compileSdk,
      this.minSdk,
      this.maxSdk,
      this.createdAt,
      this.updatedAt,
      this.downloadProgress,
      this.installed})
      : _screenShots = screenShots,
        _versions = versions,
        _permissions = permissions;

  factory _$AppInstallingImpl.fromJson(Map<String, dynamic> json) =>
      _$$AppInstallingImplFromJson(json);

  @override
  final int? id;
  @override
  final String? uuid;
  @override
  final String? status;
  @override
  final String? osType;
  @override
  final String? name;
  @override
  final String? packageName;
  @override
  final String? icon;
  @override
  final Developer developer;
  @override
  final Distributor? distributor;
  @override
  final String? description;
  final List<AppScreenShot>? _screenShots;
  @override
  List<AppScreenShot>? get screenShots {
    final value = _screenShots;
    if (value == null) return null;
    if (_screenShots is EqualUnmodifiableListView) return _screenShots;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<AppVersion>? _versions;
  @override
  List<AppVersion>? get versions {
    final value = _versions;
    if (value == null) return null;
    if (_versions is EqualUnmodifiableListView) return _versions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final AppVersion? version;
  @override
  final Category? category;
  @override
  final String? appType;
  @override
  final int? downloadCount;
  final List<String?>? _permissions;
  @override
  List<String?>? get permissions {
    final value = _permissions;
    if (value == null) return null;
    if (_permissions is EqualUnmodifiableListView) return _permissions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final String? targetSdk;
  @override
  final String? compileSdk;
  @override
  final String? minSdk;
  @override
  final String? maxSdk;
  @override
  final DateTime? createdAt;
  @override
  final DateTime? updatedAt;
  @override
  final double? downloadProgress;
  @override
  final bool? installed;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'AppInstalling(id: $id, uuid: $uuid, status: $status, osType: $osType, name: $name, packageName: $packageName, icon: $icon, developer: $developer, distributor: $distributor, description: $description, screenShots: $screenShots, versions: $versions, version: $version, category: $category, appType: $appType, downloadCount: $downloadCount, permissions: $permissions, targetSdk: $targetSdk, compileSdk: $compileSdk, minSdk: $minSdk, maxSdk: $maxSdk, createdAt: $createdAt, updatedAt: $updatedAt, downloadProgress: $downloadProgress, installed: $installed)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'AppInstalling'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('uuid', uuid))
      ..add(DiagnosticsProperty('status', status))
      ..add(DiagnosticsProperty('osType', osType))
      ..add(DiagnosticsProperty('name', name))
      ..add(DiagnosticsProperty('packageName', packageName))
      ..add(DiagnosticsProperty('icon', icon))
      ..add(DiagnosticsProperty('developer', developer))
      ..add(DiagnosticsProperty('distributor', distributor))
      ..add(DiagnosticsProperty('description', description))
      ..add(DiagnosticsProperty('screenShots', screenShots))
      ..add(DiagnosticsProperty('versions', versions))
      ..add(DiagnosticsProperty('version', version))
      ..add(DiagnosticsProperty('category', category))
      ..add(DiagnosticsProperty('appType', appType))
      ..add(DiagnosticsProperty('downloadCount', downloadCount))
      ..add(DiagnosticsProperty('permissions', permissions))
      ..add(DiagnosticsProperty('targetSdk', targetSdk))
      ..add(DiagnosticsProperty('compileSdk', compileSdk))
      ..add(DiagnosticsProperty('minSdk', minSdk))
      ..add(DiagnosticsProperty('maxSdk', maxSdk))
      ..add(DiagnosticsProperty('createdAt', createdAt))
      ..add(DiagnosticsProperty('updatedAt', updatedAt))
      ..add(DiagnosticsProperty('downloadProgress', downloadProgress))
      ..add(DiagnosticsProperty('installed', installed));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AppInstallingImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.uuid, uuid) || other.uuid == uuid) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.osType, osType) || other.osType == osType) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.packageName, packageName) ||
                other.packageName == packageName) &&
            (identical(other.icon, icon) || other.icon == icon) &&
            (identical(other.developer, developer) ||
                other.developer == developer) &&
            (identical(other.distributor, distributor) ||
                other.distributor == distributor) &&
            (identical(other.description, description) ||
                other.description == description) &&
            const DeepCollectionEquality()
                .equals(other._screenShots, _screenShots) &&
            const DeepCollectionEquality().equals(other._versions, _versions) &&
            (identical(other.version, version) || other.version == version) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.appType, appType) || other.appType == appType) &&
            (identical(other.downloadCount, downloadCount) ||
                other.downloadCount == downloadCount) &&
            const DeepCollectionEquality()
                .equals(other._permissions, _permissions) &&
            (identical(other.targetSdk, targetSdk) ||
                other.targetSdk == targetSdk) &&
            (identical(other.compileSdk, compileSdk) ||
                other.compileSdk == compileSdk) &&
            (identical(other.minSdk, minSdk) || other.minSdk == minSdk) &&
            (identical(other.maxSdk, maxSdk) || other.maxSdk == maxSdk) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.downloadProgress, downloadProgress) ||
                other.downloadProgress == downloadProgress) &&
            (identical(other.installed, installed) ||
                other.installed == installed));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        id,
        uuid,
        status,
        osType,
        name,
        packageName,
        icon,
        developer,
        distributor,
        description,
        const DeepCollectionEquality().hash(_screenShots),
        const DeepCollectionEquality().hash(_versions),
        version,
        category,
        appType,
        downloadCount,
        const DeepCollectionEquality().hash(_permissions),
        targetSdk,
        compileSdk,
        minSdk,
        maxSdk,
        createdAt,
        updatedAt,
        downloadProgress,
        installed
      ]);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AppInstallingImplCopyWith<_$AppInstallingImpl> get copyWith =>
      __$$AppInstallingImplCopyWithImpl<_$AppInstallingImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AppInstallingImplToJson(
      this,
    );
  }
}

abstract class _AppInstalling implements AppInstalling {
  factory _AppInstalling(
      {final int? id,
      final String? uuid,
      final String? status,
      final String? osType,
      final String? name,
      final String? packageName,
      final String? icon,
      required final Developer developer,
      final Distributor? distributor,
      final String? description,
      final List<AppScreenShot>? screenShots,
      final List<AppVersion>? versions,
      final AppVersion? version,
      final Category? category,
      final String? appType,
      final int? downloadCount,
      final List<String?>? permissions,
      final String? targetSdk,
      final String? compileSdk,
      final String? minSdk,
      final String? maxSdk,
      final DateTime? createdAt,
      final DateTime? updatedAt,
      final double? downloadProgress,
      final bool? installed}) = _$AppInstallingImpl;

  factory _AppInstalling.fromJson(Map<String, dynamic> json) =
      _$AppInstallingImpl.fromJson;

  @override
  int? get id;
  @override
  String? get uuid;
  @override
  String? get status;
  @override
  String? get osType;
  @override
  String? get name;
  @override
  String? get packageName;
  @override
  String? get icon;
  @override
  Developer get developer;
  @override
  Distributor? get distributor;
  @override
  String? get description;
  @override
  List<AppScreenShot>? get screenShots;
  @override
  List<AppVersion>? get versions;
  @override
  AppVersion? get version;
  @override
  Category? get category;
  @override
  String? get appType;
  @override
  int? get downloadCount;
  @override
  List<String?>? get permissions;
  @override
  String? get targetSdk;
  @override
  String? get compileSdk;
  @override
  String? get minSdk;
  @override
  String? get maxSdk;
  @override
  DateTime? get createdAt;
  @override
  DateTime? get updatedAt;
  @override
  double? get downloadProgress;
  @override
  bool? get installed;
  @override
  @JsonKey(ignore: true)
  _$$AppInstallingImplCopyWith<_$AppInstallingImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

DeviceInfo _$DeviceInfoFromJson(Map<String, dynamic> json) {
  return _DeviceInfo.fromJson(json);
}

/// @nodoc
mixin _$DeviceInfo {
  String? get serialNumber => throw _privateConstructorUsedError;
  String? get batteryLevel => throw _privateConstructorUsedError;
  String? get imei => throw _privateConstructorUsedError;
  String? get manufacturer => throw _privateConstructorUsedError;
  String? get model => throw _privateConstructorUsedError;
  String? get osVersion => throw _privateConstructorUsedError;
  String? get sdkVersion => throw _privateConstructorUsedError;
  String? get ram => throw _privateConstructorUsedError;
  String? get rom => throw _privateConstructorUsedError;
  String? get firmware => throw _privateConstructorUsedError;
  String? get batteryTemp => throw _privateConstructorUsedError;
  String? get networkType => throw _privateConstructorUsedError;
  String? get longitude => throw _privateConstructorUsedError;
  String? get latitude => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $DeviceInfoCopyWith<DeviceInfo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DeviceInfoCopyWith<$Res> {
  factory $DeviceInfoCopyWith(
          DeviceInfo value, $Res Function(DeviceInfo) then) =
      _$DeviceInfoCopyWithImpl<$Res, DeviceInfo>;
  @useResult
  $Res call(
      {String? serialNumber,
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
      String? latitude});
}

/// @nodoc
class _$DeviceInfoCopyWithImpl<$Res, $Val extends DeviceInfo>
    implements $DeviceInfoCopyWith<$Res> {
  _$DeviceInfoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? serialNumber = freezed,
    Object? batteryLevel = freezed,
    Object? imei = freezed,
    Object? manufacturer = freezed,
    Object? model = freezed,
    Object? osVersion = freezed,
    Object? sdkVersion = freezed,
    Object? ram = freezed,
    Object? rom = freezed,
    Object? firmware = freezed,
    Object? batteryTemp = freezed,
    Object? networkType = freezed,
    Object? longitude = freezed,
    Object? latitude = freezed,
  }) {
    return _then(_value.copyWith(
      serialNumber: freezed == serialNumber
          ? _value.serialNumber
          : serialNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      batteryLevel: freezed == batteryLevel
          ? _value.batteryLevel
          : batteryLevel // ignore: cast_nullable_to_non_nullable
              as String?,
      imei: freezed == imei
          ? _value.imei
          : imei // ignore: cast_nullable_to_non_nullable
              as String?,
      manufacturer: freezed == manufacturer
          ? _value.manufacturer
          : manufacturer // ignore: cast_nullable_to_non_nullable
              as String?,
      model: freezed == model
          ? _value.model
          : model // ignore: cast_nullable_to_non_nullable
              as String?,
      osVersion: freezed == osVersion
          ? _value.osVersion
          : osVersion // ignore: cast_nullable_to_non_nullable
              as String?,
      sdkVersion: freezed == sdkVersion
          ? _value.sdkVersion
          : sdkVersion // ignore: cast_nullable_to_non_nullable
              as String?,
      ram: freezed == ram
          ? _value.ram
          : ram // ignore: cast_nullable_to_non_nullable
              as String?,
      rom: freezed == rom
          ? _value.rom
          : rom // ignore: cast_nullable_to_non_nullable
              as String?,
      firmware: freezed == firmware
          ? _value.firmware
          : firmware // ignore: cast_nullable_to_non_nullable
              as String?,
      batteryTemp: freezed == batteryTemp
          ? _value.batteryTemp
          : batteryTemp // ignore: cast_nullable_to_non_nullable
              as String?,
      networkType: freezed == networkType
          ? _value.networkType
          : networkType // ignore: cast_nullable_to_non_nullable
              as String?,
      longitude: freezed == longitude
          ? _value.longitude
          : longitude // ignore: cast_nullable_to_non_nullable
              as String?,
      latitude: freezed == latitude
          ? _value.latitude
          : latitude // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DeviceInfoImplCopyWith<$Res>
    implements $DeviceInfoCopyWith<$Res> {
  factory _$$DeviceInfoImplCopyWith(
          _$DeviceInfoImpl value, $Res Function(_$DeviceInfoImpl) then) =
      __$$DeviceInfoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? serialNumber,
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
      String? latitude});
}

/// @nodoc
class __$$DeviceInfoImplCopyWithImpl<$Res>
    extends _$DeviceInfoCopyWithImpl<$Res, _$DeviceInfoImpl>
    implements _$$DeviceInfoImplCopyWith<$Res> {
  __$$DeviceInfoImplCopyWithImpl(
      _$DeviceInfoImpl _value, $Res Function(_$DeviceInfoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? serialNumber = freezed,
    Object? batteryLevel = freezed,
    Object? imei = freezed,
    Object? manufacturer = freezed,
    Object? model = freezed,
    Object? osVersion = freezed,
    Object? sdkVersion = freezed,
    Object? ram = freezed,
    Object? rom = freezed,
    Object? firmware = freezed,
    Object? batteryTemp = freezed,
    Object? networkType = freezed,
    Object? longitude = freezed,
    Object? latitude = freezed,
  }) {
    return _then(_$DeviceInfoImpl(
      serialNumber: freezed == serialNumber
          ? _value.serialNumber
          : serialNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      batteryLevel: freezed == batteryLevel
          ? _value.batteryLevel
          : batteryLevel // ignore: cast_nullable_to_non_nullable
              as String?,
      imei: freezed == imei
          ? _value.imei
          : imei // ignore: cast_nullable_to_non_nullable
              as String?,
      manufacturer: freezed == manufacturer
          ? _value.manufacturer
          : manufacturer // ignore: cast_nullable_to_non_nullable
              as String?,
      model: freezed == model
          ? _value.model
          : model // ignore: cast_nullable_to_non_nullable
              as String?,
      osVersion: freezed == osVersion
          ? _value.osVersion
          : osVersion // ignore: cast_nullable_to_non_nullable
              as String?,
      sdkVersion: freezed == sdkVersion
          ? _value.sdkVersion
          : sdkVersion // ignore: cast_nullable_to_non_nullable
              as String?,
      ram: freezed == ram
          ? _value.ram
          : ram // ignore: cast_nullable_to_non_nullable
              as String?,
      rom: freezed == rom
          ? _value.rom
          : rom // ignore: cast_nullable_to_non_nullable
              as String?,
      firmware: freezed == firmware
          ? _value.firmware
          : firmware // ignore: cast_nullable_to_non_nullable
              as String?,
      batteryTemp: freezed == batteryTemp
          ? _value.batteryTemp
          : batteryTemp // ignore: cast_nullable_to_non_nullable
              as String?,
      networkType: freezed == networkType
          ? _value.networkType
          : networkType // ignore: cast_nullable_to_non_nullable
              as String?,
      longitude: freezed == longitude
          ? _value.longitude
          : longitude // ignore: cast_nullable_to_non_nullable
              as String?,
      latitude: freezed == latitude
          ? _value.latitude
          : latitude // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DeviceInfoImpl with DiagnosticableTreeMixin implements _DeviceInfo {
  _$DeviceInfoImpl(
      {this.serialNumber,
      this.batteryLevel,
      this.imei,
      this.manufacturer,
      this.model,
      this.osVersion,
      this.sdkVersion,
      this.ram,
      this.rom,
      this.firmware,
      this.batteryTemp,
      this.networkType,
      this.longitude,
      this.latitude});

  factory _$DeviceInfoImpl.fromJson(Map<String, dynamic> json) =>
      _$$DeviceInfoImplFromJson(json);

  @override
  final String? serialNumber;
  @override
  final String? batteryLevel;
  @override
  final String? imei;
  @override
  final String? manufacturer;
  @override
  final String? model;
  @override
  final String? osVersion;
  @override
  final String? sdkVersion;
  @override
  final String? ram;
  @override
  final String? rom;
  @override
  final String? firmware;
  @override
  final String? batteryTemp;
  @override
  final String? networkType;
  @override
  final String? longitude;
  @override
  final String? latitude;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'DeviceInfo(serialNumber: $serialNumber, batteryLevel: $batteryLevel, imei: $imei, manufacturer: $manufacturer, model: $model, osVersion: $osVersion, sdkVersion: $sdkVersion, ram: $ram, rom: $rom, firmware: $firmware, batteryTemp: $batteryTemp, networkType: $networkType, longitude: $longitude, latitude: $latitude)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'DeviceInfo'))
      ..add(DiagnosticsProperty('serialNumber', serialNumber))
      ..add(DiagnosticsProperty('batteryLevel', batteryLevel))
      ..add(DiagnosticsProperty('imei', imei))
      ..add(DiagnosticsProperty('manufacturer', manufacturer))
      ..add(DiagnosticsProperty('model', model))
      ..add(DiagnosticsProperty('osVersion', osVersion))
      ..add(DiagnosticsProperty('sdkVersion', sdkVersion))
      ..add(DiagnosticsProperty('ram', ram))
      ..add(DiagnosticsProperty('rom', rom))
      ..add(DiagnosticsProperty('firmware', firmware))
      ..add(DiagnosticsProperty('batteryTemp', batteryTemp))
      ..add(DiagnosticsProperty('networkType', networkType))
      ..add(DiagnosticsProperty('longitude', longitude))
      ..add(DiagnosticsProperty('latitude', latitude));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DeviceInfoImpl &&
            (identical(other.serialNumber, serialNumber) ||
                other.serialNumber == serialNumber) &&
            (identical(other.batteryLevel, batteryLevel) ||
                other.batteryLevel == batteryLevel) &&
            (identical(other.imei, imei) || other.imei == imei) &&
            (identical(other.manufacturer, manufacturer) ||
                other.manufacturer == manufacturer) &&
            (identical(other.model, model) || other.model == model) &&
            (identical(other.osVersion, osVersion) ||
                other.osVersion == osVersion) &&
            (identical(other.sdkVersion, sdkVersion) ||
                other.sdkVersion == sdkVersion) &&
            (identical(other.ram, ram) || other.ram == ram) &&
            (identical(other.rom, rom) || other.rom == rom) &&
            (identical(other.firmware, firmware) ||
                other.firmware == firmware) &&
            (identical(other.batteryTemp, batteryTemp) ||
                other.batteryTemp == batteryTemp) &&
            (identical(other.networkType, networkType) ||
                other.networkType == networkType) &&
            (identical(other.longitude, longitude) ||
                other.longitude == longitude) &&
            (identical(other.latitude, latitude) ||
                other.latitude == latitude));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      serialNumber,
      batteryLevel,
      imei,
      manufacturer,
      model,
      osVersion,
      sdkVersion,
      ram,
      rom,
      firmware,
      batteryTemp,
      networkType,
      longitude,
      latitude);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DeviceInfoImplCopyWith<_$DeviceInfoImpl> get copyWith =>
      __$$DeviceInfoImplCopyWithImpl<_$DeviceInfoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DeviceInfoImplToJson(
      this,
    );
  }
}

abstract class _DeviceInfo implements DeviceInfo {
  factory _DeviceInfo(
      {final String? serialNumber,
      final String? batteryLevel,
      final String? imei,
      final String? manufacturer,
      final String? model,
      final String? osVersion,
      final String? sdkVersion,
      final String? ram,
      final String? rom,
      final String? firmware,
      final String? batteryTemp,
      final String? networkType,
      final String? longitude,
      final String? latitude}) = _$DeviceInfoImpl;

  factory _DeviceInfo.fromJson(Map<String, dynamic> json) =
      _$DeviceInfoImpl.fromJson;

  @override
  String? get serialNumber;
  @override
  String? get batteryLevel;
  @override
  String? get imei;
  @override
  String? get manufacturer;
  @override
  String? get model;
  @override
  String? get osVersion;
  @override
  String? get sdkVersion;
  @override
  String? get ram;
  @override
  String? get rom;
  @override
  String? get firmware;
  @override
  String? get batteryTemp;
  @override
  String? get networkType;
  @override
  String? get longitude;
  @override
  String? get latitude;
  @override
  @JsonKey(ignore: true)
  _$$DeviceInfoImplCopyWith<_$DeviceInfoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Developer _$DeveloperFromJson(Map<String, dynamic> json) {
  return _Developer.fromJson(json);
}

/// @nodoc
mixin _$Developer {
  int? get id => throw _privateConstructorUsedError;
  String? get uuid => throw _privateConstructorUsedError;
  String? get organizationName => throw _privateConstructorUsedError;
  Country? get country => throw _privateConstructorUsedError;
  String? get status => throw _privateConstructorUsedError;
  String? get websiteUrl => throw _privateConstructorUsedError;
  String? get supportEmail => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $DeveloperCopyWith<Developer> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DeveloperCopyWith<$Res> {
  factory $DeveloperCopyWith(Developer value, $Res Function(Developer) then) =
      _$DeveloperCopyWithImpl<$Res, Developer>;
  @useResult
  $Res call(
      {int? id,
      String? uuid,
      String? organizationName,
      Country? country,
      String? status,
      String? websiteUrl,
      String? supportEmail});

  $CountryCopyWith<$Res>? get country;
}

/// @nodoc
class _$DeveloperCopyWithImpl<$Res, $Val extends Developer>
    implements $DeveloperCopyWith<$Res> {
  _$DeveloperCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? uuid = freezed,
    Object? organizationName = freezed,
    Object? country = freezed,
    Object? status = freezed,
    Object? websiteUrl = freezed,
    Object? supportEmail = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      uuid: freezed == uuid
          ? _value.uuid
          : uuid // ignore: cast_nullable_to_non_nullable
              as String?,
      organizationName: freezed == organizationName
          ? _value.organizationName
          : organizationName // ignore: cast_nullable_to_non_nullable
              as String?,
      country: freezed == country
          ? _value.country
          : country // ignore: cast_nullable_to_non_nullable
              as Country?,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String?,
      websiteUrl: freezed == websiteUrl
          ? _value.websiteUrl
          : websiteUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      supportEmail: freezed == supportEmail
          ? _value.supportEmail
          : supportEmail // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $CountryCopyWith<$Res>? get country {
    if (_value.country == null) {
      return null;
    }

    return $CountryCopyWith<$Res>(_value.country!, (value) {
      return _then(_value.copyWith(country: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$DeveloperImplCopyWith<$Res>
    implements $DeveloperCopyWith<$Res> {
  factory _$$DeveloperImplCopyWith(
          _$DeveloperImpl value, $Res Function(_$DeveloperImpl) then) =
      __$$DeveloperImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int? id,
      String? uuid,
      String? organizationName,
      Country? country,
      String? status,
      String? websiteUrl,
      String? supportEmail});

  @override
  $CountryCopyWith<$Res>? get country;
}

/// @nodoc
class __$$DeveloperImplCopyWithImpl<$Res>
    extends _$DeveloperCopyWithImpl<$Res, _$DeveloperImpl>
    implements _$$DeveloperImplCopyWith<$Res> {
  __$$DeveloperImplCopyWithImpl(
      _$DeveloperImpl _value, $Res Function(_$DeveloperImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? uuid = freezed,
    Object? organizationName = freezed,
    Object? country = freezed,
    Object? status = freezed,
    Object? websiteUrl = freezed,
    Object? supportEmail = freezed,
  }) {
    return _then(_$DeveloperImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      uuid: freezed == uuid
          ? _value.uuid
          : uuid // ignore: cast_nullable_to_non_nullable
              as String?,
      organizationName: freezed == organizationName
          ? _value.organizationName
          : organizationName // ignore: cast_nullable_to_non_nullable
              as String?,
      country: freezed == country
          ? _value.country
          : country // ignore: cast_nullable_to_non_nullable
              as Country?,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String?,
      websiteUrl: freezed == websiteUrl
          ? _value.websiteUrl
          : websiteUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      supportEmail: freezed == supportEmail
          ? _value.supportEmail
          : supportEmail // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DeveloperImpl with DiagnosticableTreeMixin implements _Developer {
  _$DeveloperImpl(
      {this.id,
      this.uuid,
      this.organizationName,
      this.country,
      this.status,
      this.websiteUrl,
      this.supportEmail});

  factory _$DeveloperImpl.fromJson(Map<String, dynamic> json) =>
      _$$DeveloperImplFromJson(json);

  @override
  final int? id;
  @override
  final String? uuid;
  @override
  final String? organizationName;
  @override
  final Country? country;
  @override
  final String? status;
  @override
  final String? websiteUrl;
  @override
  final String? supportEmail;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Developer(id: $id, uuid: $uuid, organizationName: $organizationName, country: $country, status: $status, websiteUrl: $websiteUrl, supportEmail: $supportEmail)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Developer'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('uuid', uuid))
      ..add(DiagnosticsProperty('organizationName', organizationName))
      ..add(DiagnosticsProperty('country', country))
      ..add(DiagnosticsProperty('status', status))
      ..add(DiagnosticsProperty('websiteUrl', websiteUrl))
      ..add(DiagnosticsProperty('supportEmail', supportEmail));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DeveloperImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.uuid, uuid) || other.uuid == uuid) &&
            (identical(other.organizationName, organizationName) ||
                other.organizationName == organizationName) &&
            (identical(other.country, country) || other.country == country) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.websiteUrl, websiteUrl) ||
                other.websiteUrl == websiteUrl) &&
            (identical(other.supportEmail, supportEmail) ||
                other.supportEmail == supportEmail));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, uuid, organizationName,
      country, status, websiteUrl, supportEmail);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DeveloperImplCopyWith<_$DeveloperImpl> get copyWith =>
      __$$DeveloperImplCopyWithImpl<_$DeveloperImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DeveloperImplToJson(
      this,
    );
  }
}

abstract class _Developer implements Developer {
  factory _Developer(
      {final int? id,
      final String? uuid,
      final String? organizationName,
      final Country? country,
      final String? status,
      final String? websiteUrl,
      final String? supportEmail}) = _$DeveloperImpl;

  factory _Developer.fromJson(Map<String, dynamic> json) =
      _$DeveloperImpl.fromJson;

  @override
  int? get id;
  @override
  String? get uuid;
  @override
  String? get organizationName;
  @override
  Country? get country;
  @override
  String? get status;
  @override
  String? get websiteUrl;
  @override
  String? get supportEmail;
  @override
  @JsonKey(ignore: true)
  _$$DeveloperImplCopyWith<_$DeveloperImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Country _$CountryFromJson(Map<String, dynamic> json) {
  return _Country.fromJson(json);
}

/// @nodoc
mixin _$Country {
  int? get id => throw _privateConstructorUsedError;
  String? get countryName => throw _privateConstructorUsedError;
  String? get countryCode => throw _privateConstructorUsedError;
  String? get status => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CountryCopyWith<Country> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CountryCopyWith<$Res> {
  factory $CountryCopyWith(Country value, $Res Function(Country) then) =
      _$CountryCopyWithImpl<$Res, Country>;
  @useResult
  $Res call(
      {int? id, String? countryName, String? countryCode, String? status});
}

/// @nodoc
class _$CountryCopyWithImpl<$Res, $Val extends Country>
    implements $CountryCopyWith<$Res> {
  _$CountryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? countryName = freezed,
    Object? countryCode = freezed,
    Object? status = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      countryName: freezed == countryName
          ? _value.countryName
          : countryName // ignore: cast_nullable_to_non_nullable
              as String?,
      countryCode: freezed == countryCode
          ? _value.countryCode
          : countryCode // ignore: cast_nullable_to_non_nullable
              as String?,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CountryImplCopyWith<$Res> implements $CountryCopyWith<$Res> {
  factory _$$CountryImplCopyWith(
          _$CountryImpl value, $Res Function(_$CountryImpl) then) =
      __$$CountryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int? id, String? countryName, String? countryCode, String? status});
}

/// @nodoc
class __$$CountryImplCopyWithImpl<$Res>
    extends _$CountryCopyWithImpl<$Res, _$CountryImpl>
    implements _$$CountryImplCopyWith<$Res> {
  __$$CountryImplCopyWithImpl(
      _$CountryImpl _value, $Res Function(_$CountryImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? countryName = freezed,
    Object? countryCode = freezed,
    Object? status = freezed,
  }) {
    return _then(_$CountryImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      countryName: freezed == countryName
          ? _value.countryName
          : countryName // ignore: cast_nullable_to_non_nullable
              as String?,
      countryCode: freezed == countryCode
          ? _value.countryCode
          : countryCode // ignore: cast_nullable_to_non_nullable
              as String?,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CountryImpl with DiagnosticableTreeMixin implements _Country {
  _$CountryImpl({this.id, this.countryName, this.countryCode, this.status});

  factory _$CountryImpl.fromJson(Map<String, dynamic> json) =>
      _$$CountryImplFromJson(json);

  @override
  final int? id;
  @override
  final String? countryName;
  @override
  final String? countryCode;
  @override
  final String? status;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Country(id: $id, countryName: $countryName, countryCode: $countryCode, status: $status)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Country'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('countryName', countryName))
      ..add(DiagnosticsProperty('countryCode', countryCode))
      ..add(DiagnosticsProperty('status', status));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CountryImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.countryName, countryName) ||
                other.countryName == countryName) &&
            (identical(other.countryCode, countryCode) ||
                other.countryCode == countryCode) &&
            (identical(other.status, status) || other.status == status));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, countryName, countryCode, status);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CountryImplCopyWith<_$CountryImpl> get copyWith =>
      __$$CountryImplCopyWithImpl<_$CountryImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CountryImplToJson(
      this,
    );
  }
}

abstract class _Country implements Country {
  factory _Country(
      {final int? id,
      final String? countryName,
      final String? countryCode,
      final String? status}) = _$CountryImpl;

  factory _Country.fromJson(Map<String, dynamic> json) = _$CountryImpl.fromJson;

  @override
  int? get id;
  @override
  String? get countryName;
  @override
  String? get countryCode;
  @override
  String? get status;
  @override
  @JsonKey(ignore: true)
  _$$CountryImplCopyWith<_$CountryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Distributor _$DistributorFromJson(Map<String, dynamic> json) {
  return _Distributor.fromJson(json);
}

/// @nodoc
mixin _$Distributor {
  int? get id => throw _privateConstructorUsedError;
  String? get uuid => throw _privateConstructorUsedError;
  String? get distributorName => throw _privateConstructorUsedError;
  Country? get country => throw _privateConstructorUsedError;
  String? get contactName => throw _privateConstructorUsedError;
  String? get contactEmail => throw _privateConstructorUsedError;
  String? get status => throw _privateConstructorUsedError;
  int? get developerId => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $DistributorCopyWith<Distributor> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DistributorCopyWith<$Res> {
  factory $DistributorCopyWith(
          Distributor value, $Res Function(Distributor) then) =
      _$DistributorCopyWithImpl<$Res, Distributor>;
  @useResult
  $Res call(
      {int? id,
      String? uuid,
      String? distributorName,
      Country? country,
      String? contactName,
      String? contactEmail,
      String? status,
      int? developerId});

  $CountryCopyWith<$Res>? get country;
}

/// @nodoc
class _$DistributorCopyWithImpl<$Res, $Val extends Distributor>
    implements $DistributorCopyWith<$Res> {
  _$DistributorCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? uuid = freezed,
    Object? distributorName = freezed,
    Object? country = freezed,
    Object? contactName = freezed,
    Object? contactEmail = freezed,
    Object? status = freezed,
    Object? developerId = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      uuid: freezed == uuid
          ? _value.uuid
          : uuid // ignore: cast_nullable_to_non_nullable
              as String?,
      distributorName: freezed == distributorName
          ? _value.distributorName
          : distributorName // ignore: cast_nullable_to_non_nullable
              as String?,
      country: freezed == country
          ? _value.country
          : country // ignore: cast_nullable_to_non_nullable
              as Country?,
      contactName: freezed == contactName
          ? _value.contactName
          : contactName // ignore: cast_nullable_to_non_nullable
              as String?,
      contactEmail: freezed == contactEmail
          ? _value.contactEmail
          : contactEmail // ignore: cast_nullable_to_non_nullable
              as String?,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String?,
      developerId: freezed == developerId
          ? _value.developerId
          : developerId // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $CountryCopyWith<$Res>? get country {
    if (_value.country == null) {
      return null;
    }

    return $CountryCopyWith<$Res>(_value.country!, (value) {
      return _then(_value.copyWith(country: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$DistributorImplCopyWith<$Res>
    implements $DistributorCopyWith<$Res> {
  factory _$$DistributorImplCopyWith(
          _$DistributorImpl value, $Res Function(_$DistributorImpl) then) =
      __$$DistributorImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int? id,
      String? uuid,
      String? distributorName,
      Country? country,
      String? contactName,
      String? contactEmail,
      String? status,
      int? developerId});

  @override
  $CountryCopyWith<$Res>? get country;
}

/// @nodoc
class __$$DistributorImplCopyWithImpl<$Res>
    extends _$DistributorCopyWithImpl<$Res, _$DistributorImpl>
    implements _$$DistributorImplCopyWith<$Res> {
  __$$DistributorImplCopyWithImpl(
      _$DistributorImpl _value, $Res Function(_$DistributorImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? uuid = freezed,
    Object? distributorName = freezed,
    Object? country = freezed,
    Object? contactName = freezed,
    Object? contactEmail = freezed,
    Object? status = freezed,
    Object? developerId = freezed,
  }) {
    return _then(_$DistributorImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      uuid: freezed == uuid
          ? _value.uuid
          : uuid // ignore: cast_nullable_to_non_nullable
              as String?,
      distributorName: freezed == distributorName
          ? _value.distributorName
          : distributorName // ignore: cast_nullable_to_non_nullable
              as String?,
      country: freezed == country
          ? _value.country
          : country // ignore: cast_nullable_to_non_nullable
              as Country?,
      contactName: freezed == contactName
          ? _value.contactName
          : contactName // ignore: cast_nullable_to_non_nullable
              as String?,
      contactEmail: freezed == contactEmail
          ? _value.contactEmail
          : contactEmail // ignore: cast_nullable_to_non_nullable
              as String?,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String?,
      developerId: freezed == developerId
          ? _value.developerId
          : developerId // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DistributorImpl with DiagnosticableTreeMixin implements _Distributor {
  _$DistributorImpl(
      {this.id,
      this.uuid,
      this.distributorName,
      this.country,
      this.contactName,
      this.contactEmail,
      this.status,
      this.developerId});

  factory _$DistributorImpl.fromJson(Map<String, dynamic> json) =>
      _$$DistributorImplFromJson(json);

  @override
  final int? id;
  @override
  final String? uuid;
  @override
  final String? distributorName;
  @override
  final Country? country;
  @override
  final String? contactName;
  @override
  final String? contactEmail;
  @override
  final String? status;
  @override
  final int? developerId;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Distributor(id: $id, uuid: $uuid, distributorName: $distributorName, country: $country, contactName: $contactName, contactEmail: $contactEmail, status: $status, developerId: $developerId)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Distributor'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('uuid', uuid))
      ..add(DiagnosticsProperty('distributorName', distributorName))
      ..add(DiagnosticsProperty('country', country))
      ..add(DiagnosticsProperty('contactName', contactName))
      ..add(DiagnosticsProperty('contactEmail', contactEmail))
      ..add(DiagnosticsProperty('status', status))
      ..add(DiagnosticsProperty('developerId', developerId));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DistributorImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.uuid, uuid) || other.uuid == uuid) &&
            (identical(other.distributorName, distributorName) ||
                other.distributorName == distributorName) &&
            (identical(other.country, country) || other.country == country) &&
            (identical(other.contactName, contactName) ||
                other.contactName == contactName) &&
            (identical(other.contactEmail, contactEmail) ||
                other.contactEmail == contactEmail) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.developerId, developerId) ||
                other.developerId == developerId));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, uuid, distributorName,
      country, contactName, contactEmail, status, developerId);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DistributorImplCopyWith<_$DistributorImpl> get copyWith =>
      __$$DistributorImplCopyWithImpl<_$DistributorImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DistributorImplToJson(
      this,
    );
  }
}

abstract class _Distributor implements Distributor {
  factory _Distributor(
      {final int? id,
      final String? uuid,
      final String? distributorName,
      final Country? country,
      final String? contactName,
      final String? contactEmail,
      final String? status,
      final int? developerId}) = _$DistributorImpl;

  factory _Distributor.fromJson(Map<String, dynamic> json) =
      _$DistributorImpl.fromJson;

  @override
  int? get id;
  @override
  String? get uuid;
  @override
  String? get distributorName;
  @override
  Country? get country;
  @override
  String? get contactName;
  @override
  String? get contactEmail;
  @override
  String? get status;
  @override
  int? get developerId;
  @override
  @JsonKey(ignore: true)
  _$$DistributorImplCopyWith<_$DistributorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

AppScreenShot _$AppScreenShotFromJson(Map<String, dynamic> json) {
  return _AppScreenShot.fromJson(json);
}

/// @nodoc
mixin _$AppScreenShot {
  int? get id => throw _privateConstructorUsedError;
  String? get uuid => throw _privateConstructorUsedError;
  String? get imageUrl => throw _privateConstructorUsedError;
  int? get appId => throw _privateConstructorUsedError;
  String? get size => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AppScreenShotCopyWith<AppScreenShot> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AppScreenShotCopyWith<$Res> {
  factory $AppScreenShotCopyWith(
          AppScreenShot value, $Res Function(AppScreenShot) then) =
      _$AppScreenShotCopyWithImpl<$Res, AppScreenShot>;
  @useResult
  $Res call(
      {int? id, String? uuid, String? imageUrl, int? appId, String? size});
}

/// @nodoc
class _$AppScreenShotCopyWithImpl<$Res, $Val extends AppScreenShot>
    implements $AppScreenShotCopyWith<$Res> {
  _$AppScreenShotCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? uuid = freezed,
    Object? imageUrl = freezed,
    Object? appId = freezed,
    Object? size = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      uuid: freezed == uuid
          ? _value.uuid
          : uuid // ignore: cast_nullable_to_non_nullable
              as String?,
      imageUrl: freezed == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      appId: freezed == appId
          ? _value.appId
          : appId // ignore: cast_nullable_to_non_nullable
              as int?,
      size: freezed == size
          ? _value.size
          : size // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AppScreenShotImplCopyWith<$Res>
    implements $AppScreenShotCopyWith<$Res> {
  factory _$$AppScreenShotImplCopyWith(
          _$AppScreenShotImpl value, $Res Function(_$AppScreenShotImpl) then) =
      __$$AppScreenShotImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int? id, String? uuid, String? imageUrl, int? appId, String? size});
}

/// @nodoc
class __$$AppScreenShotImplCopyWithImpl<$Res>
    extends _$AppScreenShotCopyWithImpl<$Res, _$AppScreenShotImpl>
    implements _$$AppScreenShotImplCopyWith<$Res> {
  __$$AppScreenShotImplCopyWithImpl(
      _$AppScreenShotImpl _value, $Res Function(_$AppScreenShotImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? uuid = freezed,
    Object? imageUrl = freezed,
    Object? appId = freezed,
    Object? size = freezed,
  }) {
    return _then(_$AppScreenShotImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      uuid: freezed == uuid
          ? _value.uuid
          : uuid // ignore: cast_nullable_to_non_nullable
              as String?,
      imageUrl: freezed == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      appId: freezed == appId
          ? _value.appId
          : appId // ignore: cast_nullable_to_non_nullable
              as int?,
      size: freezed == size
          ? _value.size
          : size // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AppScreenShotImpl
    with DiagnosticableTreeMixin
    implements _AppScreenShot {
  _$AppScreenShotImpl(
      {this.id, this.uuid, this.imageUrl, this.appId, this.size});

  factory _$AppScreenShotImpl.fromJson(Map<String, dynamic> json) =>
      _$$AppScreenShotImplFromJson(json);

  @override
  final int? id;
  @override
  final String? uuid;
  @override
  final String? imageUrl;
  @override
  final int? appId;
  @override
  final String? size;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'AppScreenShot(id: $id, uuid: $uuid, imageUrl: $imageUrl, appId: $appId, size: $size)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'AppScreenShot'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('uuid', uuid))
      ..add(DiagnosticsProperty('imageUrl', imageUrl))
      ..add(DiagnosticsProperty('appId', appId))
      ..add(DiagnosticsProperty('size', size));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AppScreenShotImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.uuid, uuid) || other.uuid == uuid) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            (identical(other.appId, appId) || other.appId == appId) &&
            (identical(other.size, size) || other.size == size));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, uuid, imageUrl, appId, size);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AppScreenShotImplCopyWith<_$AppScreenShotImpl> get copyWith =>
      __$$AppScreenShotImplCopyWithImpl<_$AppScreenShotImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AppScreenShotImplToJson(
      this,
    );
  }
}

abstract class _AppScreenShot implements AppScreenShot {
  factory _AppScreenShot(
      {final int? id,
      final String? uuid,
      final String? imageUrl,
      final int? appId,
      final String? size}) = _$AppScreenShotImpl;

  factory _AppScreenShot.fromJson(Map<String, dynamic> json) =
      _$AppScreenShotImpl.fromJson;

  @override
  int? get id;
  @override
  String? get uuid;
  @override
  String? get imageUrl;
  @override
  int? get appId;
  @override
  String? get size;
  @override
  @JsonKey(ignore: true)
  _$$AppScreenShotImplCopyWith<_$AppScreenShotImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

AppVersion _$AppVersionFromJson(Map<String, dynamic> json) {
  return _AppVersion.fromJson(json);
}

/// @nodoc
mixin _$AppVersion {
  int? get id => throw _privateConstructorUsedError;
  String? get uuid => throw _privateConstructorUsedError;
  String? get status => throw _privateConstructorUsedError;
  String? get version => throw _privateConstructorUsedError;
  String? get versionCode => throw _privateConstructorUsedError;
  String? get size => throw _privateConstructorUsedError;
  String? get updateDescription => throw _privateConstructorUsedError;
  int? get downloadCount => throw _privateConstructorUsedError;
  String? get downloadUrl => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;
  DateTime? get updatedAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AppVersionCopyWith<AppVersion> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AppVersionCopyWith<$Res> {
  factory $AppVersionCopyWith(
          AppVersion value, $Res Function(AppVersion) then) =
      _$AppVersionCopyWithImpl<$Res, AppVersion>;
  @useResult
  $Res call(
      {int? id,
      String? uuid,
      String? status,
      String? version,
      String? versionCode,
      String? size,
      String? updateDescription,
      int? downloadCount,
      String? downloadUrl,
      DateTime? createdAt,
      DateTime? updatedAt});
}

/// @nodoc
class _$AppVersionCopyWithImpl<$Res, $Val extends AppVersion>
    implements $AppVersionCopyWith<$Res> {
  _$AppVersionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? uuid = freezed,
    Object? status = freezed,
    Object? version = freezed,
    Object? versionCode = freezed,
    Object? size = freezed,
    Object? updateDescription = freezed,
    Object? downloadCount = freezed,
    Object? downloadUrl = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      uuid: freezed == uuid
          ? _value.uuid
          : uuid // ignore: cast_nullable_to_non_nullable
              as String?,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String?,
      version: freezed == version
          ? _value.version
          : version // ignore: cast_nullable_to_non_nullable
              as String?,
      versionCode: freezed == versionCode
          ? _value.versionCode
          : versionCode // ignore: cast_nullable_to_non_nullable
              as String?,
      size: freezed == size
          ? _value.size
          : size // ignore: cast_nullable_to_non_nullable
              as String?,
      updateDescription: freezed == updateDescription
          ? _value.updateDescription
          : updateDescription // ignore: cast_nullable_to_non_nullable
              as String?,
      downloadCount: freezed == downloadCount
          ? _value.downloadCount
          : downloadCount // ignore: cast_nullable_to_non_nullable
              as int?,
      downloadUrl: freezed == downloadUrl
          ? _value.downloadUrl
          : downloadUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AppVersionImplCopyWith<$Res>
    implements $AppVersionCopyWith<$Res> {
  factory _$$AppVersionImplCopyWith(
          _$AppVersionImpl value, $Res Function(_$AppVersionImpl) then) =
      __$$AppVersionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int? id,
      String? uuid,
      String? status,
      String? version,
      String? versionCode,
      String? size,
      String? updateDescription,
      int? downloadCount,
      String? downloadUrl,
      DateTime? createdAt,
      DateTime? updatedAt});
}

/// @nodoc
class __$$AppVersionImplCopyWithImpl<$Res>
    extends _$AppVersionCopyWithImpl<$Res, _$AppVersionImpl>
    implements _$$AppVersionImplCopyWith<$Res> {
  __$$AppVersionImplCopyWithImpl(
      _$AppVersionImpl _value, $Res Function(_$AppVersionImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? uuid = freezed,
    Object? status = freezed,
    Object? version = freezed,
    Object? versionCode = freezed,
    Object? size = freezed,
    Object? updateDescription = freezed,
    Object? downloadCount = freezed,
    Object? downloadUrl = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_$AppVersionImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      uuid: freezed == uuid
          ? _value.uuid
          : uuid // ignore: cast_nullable_to_non_nullable
              as String?,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String?,
      version: freezed == version
          ? _value.version
          : version // ignore: cast_nullable_to_non_nullable
              as String?,
      versionCode: freezed == versionCode
          ? _value.versionCode
          : versionCode // ignore: cast_nullable_to_non_nullable
              as String?,
      size: freezed == size
          ? _value.size
          : size // ignore: cast_nullable_to_non_nullable
              as String?,
      updateDescription: freezed == updateDescription
          ? _value.updateDescription
          : updateDescription // ignore: cast_nullable_to_non_nullable
              as String?,
      downloadCount: freezed == downloadCount
          ? _value.downloadCount
          : downloadCount // ignore: cast_nullable_to_non_nullable
              as int?,
      downloadUrl: freezed == downloadUrl
          ? _value.downloadUrl
          : downloadUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AppVersionImpl with DiagnosticableTreeMixin implements _AppVersion {
  _$AppVersionImpl(
      {this.id,
      this.uuid,
      this.status,
      this.version,
      this.versionCode,
      this.size,
      this.updateDescription,
      this.downloadCount,
      this.downloadUrl,
      this.createdAt,
      this.updatedAt});

  factory _$AppVersionImpl.fromJson(Map<String, dynamic> json) =>
      _$$AppVersionImplFromJson(json);

  @override
  final int? id;
  @override
  final String? uuid;
  @override
  final String? status;
  @override
  final String? version;
  @override
  final String? versionCode;
  @override
  final String? size;
  @override
  final String? updateDescription;
  @override
  final int? downloadCount;
  @override
  final String? downloadUrl;
  @override
  final DateTime? createdAt;
  @override
  final DateTime? updatedAt;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'AppVersion(id: $id, uuid: $uuid, status: $status, version: $version, versionCode: $versionCode, size: $size, updateDescription: $updateDescription, downloadCount: $downloadCount, downloadUrl: $downloadUrl, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'AppVersion'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('uuid', uuid))
      ..add(DiagnosticsProperty('status', status))
      ..add(DiagnosticsProperty('version', version))
      ..add(DiagnosticsProperty('versionCode', versionCode))
      ..add(DiagnosticsProperty('size', size))
      ..add(DiagnosticsProperty('updateDescription', updateDescription))
      ..add(DiagnosticsProperty('downloadCount', downloadCount))
      ..add(DiagnosticsProperty('downloadUrl', downloadUrl))
      ..add(DiagnosticsProperty('createdAt', createdAt))
      ..add(DiagnosticsProperty('updatedAt', updatedAt));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AppVersionImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.uuid, uuid) || other.uuid == uuid) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.version, version) || other.version == version) &&
            (identical(other.versionCode, versionCode) ||
                other.versionCode == versionCode) &&
            (identical(other.size, size) || other.size == size) &&
            (identical(other.updateDescription, updateDescription) ||
                other.updateDescription == updateDescription) &&
            (identical(other.downloadCount, downloadCount) ||
                other.downloadCount == downloadCount) &&
            (identical(other.downloadUrl, downloadUrl) ||
                other.downloadUrl == downloadUrl) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      uuid,
      status,
      version,
      versionCode,
      size,
      updateDescription,
      downloadCount,
      downloadUrl,
      createdAt,
      updatedAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AppVersionImplCopyWith<_$AppVersionImpl> get copyWith =>
      __$$AppVersionImplCopyWithImpl<_$AppVersionImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AppVersionImplToJson(
      this,
    );
  }
}

abstract class _AppVersion implements AppVersion {
  factory _AppVersion(
      {final int? id,
      final String? uuid,
      final String? status,
      final String? version,
      final String? versionCode,
      final String? size,
      final String? updateDescription,
      final int? downloadCount,
      final String? downloadUrl,
      final DateTime? createdAt,
      final DateTime? updatedAt}) = _$AppVersionImpl;

  factory _AppVersion.fromJson(Map<String, dynamic> json) =
      _$AppVersionImpl.fromJson;

  @override
  int? get id;
  @override
  String? get uuid;
  @override
  String? get status;
  @override
  String? get version;
  @override
  String? get versionCode;
  @override
  String? get size;
  @override
  String? get updateDescription;
  @override
  int? get downloadCount;
  @override
  String? get downloadUrl;
  @override
  DateTime? get createdAt;
  @override
  DateTime? get updatedAt;
  @override
  @JsonKey(ignore: true)
  _$$AppVersionImplCopyWith<_$AppVersionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Category _$CategoryFromJson(Map<String, dynamic> json) {
  return _Category.fromJson(json);
}

/// @nodoc
mixin _$Category {
  int? get id => throw _privateConstructorUsedError;
  String? get uuid => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;
  String? get status => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CategoryCopyWith<Category> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CategoryCopyWith<$Res> {
  factory $CategoryCopyWith(Category value, $Res Function(Category) then) =
      _$CategoryCopyWithImpl<$Res, Category>;
  @useResult
  $Res call({int? id, String? uuid, String? name, String? status});
}

/// @nodoc
class _$CategoryCopyWithImpl<$Res, $Val extends Category>
    implements $CategoryCopyWith<$Res> {
  _$CategoryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? uuid = freezed,
    Object? name = freezed,
    Object? status = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      uuid: freezed == uuid
          ? _value.uuid
          : uuid // ignore: cast_nullable_to_non_nullable
              as String?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CategoryImplCopyWith<$Res>
    implements $CategoryCopyWith<$Res> {
  factory _$$CategoryImplCopyWith(
          _$CategoryImpl value, $Res Function(_$CategoryImpl) then) =
      __$$CategoryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int? id, String? uuid, String? name, String? status});
}

/// @nodoc
class __$$CategoryImplCopyWithImpl<$Res>
    extends _$CategoryCopyWithImpl<$Res, _$CategoryImpl>
    implements _$$CategoryImplCopyWith<$Res> {
  __$$CategoryImplCopyWithImpl(
      _$CategoryImpl _value, $Res Function(_$CategoryImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? uuid = freezed,
    Object? name = freezed,
    Object? status = freezed,
  }) {
    return _then(_$CategoryImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      uuid: freezed == uuid
          ? _value.uuid
          : uuid // ignore: cast_nullable_to_non_nullable
              as String?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CategoryImpl with DiagnosticableTreeMixin implements _Category {
  _$CategoryImpl({this.id, this.uuid, this.name, this.status});

  factory _$CategoryImpl.fromJson(Map<String, dynamic> json) =>
      _$$CategoryImplFromJson(json);

  @override
  final int? id;
  @override
  final String? uuid;
  @override
  final String? name;
  @override
  final String? status;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Category(id: $id, uuid: $uuid, name: $name, status: $status)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Category'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('uuid', uuid))
      ..add(DiagnosticsProperty('name', name))
      ..add(DiagnosticsProperty('status', status));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CategoryImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.uuid, uuid) || other.uuid == uuid) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.status, status) || other.status == status));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, uuid, name, status);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CategoryImplCopyWith<_$CategoryImpl> get copyWith =>
      __$$CategoryImplCopyWithImpl<_$CategoryImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CategoryImplToJson(
      this,
    );
  }
}

abstract class _Category implements Category {
  factory _Category(
      {final int? id,
      final String? uuid,
      final String? name,
      final String? status}) = _$CategoryImpl;

  factory _Category.fromJson(Map<String, dynamic> json) =
      _$CategoryImpl.fromJson;

  @override
  int? get id;
  @override
  String? get uuid;
  @override
  String? get name;
  @override
  String? get status;
  @override
  @JsonKey(ignore: true)
  _$$CategoryImplCopyWith<_$CategoryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
