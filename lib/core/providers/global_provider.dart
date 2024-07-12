import 'dart:collection';
import 'dart:convert';
import 'dart:io';
// import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:itexstore_agent/utils/enums.dart';

import 'package:path_provider/path_provider.dart';
import 'package:stomp_dart_client/stomp.dart';
import 'package:stomp_dart_client/stomp_config.dart';
import 'package:stomp_dart_client/stomp_frame.dart';

import '../../pages/widgets/bottom_sheet/version_sheet.dart';
import '../../route/path.dart';
import '../../utils/constant.dart';
import '../../utils/plugin/store_method.dart';
import '../models/installed_app_info.dart';
import '../models/model.dart';
import '../repositories/api_repository.dart';
import '../repositories/db_repository.dart';
import '../services/navigation.dart';

class GlobalProvider extends ChangeNotifier {
  final ApiRepository? apiRepository;
  final DBRepository? dbRepository;

  GlobalProvider({required this.apiRepository, required this.dbRepository});

  // {
  //   // initState();
  // }

  StompClient? stompClient;

  Dio dio = Dio();

  bool _isLoading = true;

  bool get isLoading => _isLoading;

  String? _errorMessage;

  String? get errorMessage => _errorMessage;

  bool _isDownloading = false;

  bool get isDownloading => _isDownloading;

  bool _showInitErrorButton = false;

  bool get showInitErrorButton => _showInitErrorButton;

  bool _isInstalling = false;

  bool get isInstalling => _isInstalling;

  AppInstalling? _appInstalling;

  AppInstalling? get appInstalling => _appInstalling;

  final List<App> _storeList = <App>[];

  UnmodifiableListView<App> get storeList => UnmodifiableListView(_storeList);

  int _updateCount = 0;

  int get updateCount => _updateCount;

  final List<App> _searchableStoreList = <App>[];

  UnmodifiableListView<App> get searchableStoreList =>
      UnmodifiableListView(_searchableStoreList);

  DeviceInfo? _deviceInfo;

  DeviceInfo? get deviceInfo => _deviceInfo;

  final List<App> _installingList = <App>[];

  List<App>? get installingList => _installingList;

  List<InstalledAppInfo> _installedAppList = [];

  List<InstalledAppInfo> get installedAppList => _installedAppList;

  InstalledAppInfo? _storeInfo;

  InstalledAppInfo? get storeInfo => _storeInfo;

  Developer? _developer;

  Developer? get developer => _developer;

  int _screen = 0;

  int get screen => _screen;

  bool _disposed = false;

  bool get disposed => _disposed;

  CancelToken? _cancelToken;

  CancelToken? get cancelToken => _cancelToken;

  @override
  void dispose() {
    _disposed = true;
    if (stompClient != null) {
      stompClient!.deactivate();
    }
    super.dispose();
  }

  initState() async {
    await getData();
  }

  void switchScreen(int index) {
    _screen = index;
    notifyListeners();
  }

  void setLoading(bool val) {
    _isLoading = val;
    notifyListeners();
  }

  void setShowInitErrorButton(bool val) {
    _showInitErrorButton = val;
    notifyListeners();
  }

  void clearErrorMessage() {
    _errorMessage = null;
    notifyListeners();
  }

  Future<void> getData() async {
    await getSystemInfo();
    await getApps();
  }

  Future<void> getSystemInfo() async {
    _installedAppList = await StoreMethod.getInstalledApps();
    _deviceInfo = await StoreMethod.getDeviceInfo();
    _storeInfo = await StoreMethod.getAppInfo("com.iisysgroup.itexstore");
    notifyListeners();
  }

  Future<void> getApps() async {
    List<App> apps = await dbRepository!.getApps();
    if (apps.isNotEmpty) {
      await _sortApps(apps);
      _developer = await dbRepository!.getAccount();
      getAppsFromApi();
    } else {
      await getAppsFromApi();
    }
  }

  Future<void> getAppsFromApi() async {
    if (_deviceInfo!.serialNumber != null) {
      Map<String, dynamic>? response =
      await apiRepository?.getApps(_deviceInfo!.serialNumber!);
      if (response!['status'] == "success") {
        _updateCount = 0;
        List<App> apps =
        response['data']['apps'].map<App>((a) => App.fromJson(a)).toList();

        await _sortApps(apps);

        dbRepository!.saveApps(_storeList);
        if (response['data']['developer'] != null) {
          _developer = Developer.fromJson(response['data']['developer']);
          dbRepository!.saveAccount(developer);
        }
        _errorMessage = null;
        setLoading(false);
      } else if (response['status'] == "unsynced") {
        syncTerminal();
      } else {
        handleError(response);
      }
    } else {
      handleError({"message": "Terminal not supported"});
    }
  }

  Future<void> _sortApps(List<App> apps) async {
    List<App> updatedApps = [];
    for (App app in apps) {
      InstalledAppInfo? exist;
      try {
        exist = _installedAppList.firstWhere(
              (a) => a.packageName == app.packageName,
        );
      } catch (e) {
        exist = null;
      }

      if (exist == null) {
        app = app.copyWith(action: AppAction.install);
      } else if (int.parse(app.version!.versionCode!) > exist.versionCode) {
        app = app.copyWith(
            action: AppAction.update, oldVersion: exist.versionName);
        _updateCount = _updateCount + 1;
      } else {
        app = app.copyWith(action: AppAction.open);
      }
      updatedApps.add(app);
    }

    _storeList.clear();
    _storeList.addAll(updatedApps);

    _searchableStoreList.clear();
    _searchableStoreList.addAll(updatedApps);
  }

  void searchApp(String query) async {
    if (query == "") {
      _searchableStoreList.clear();
      _searchableStoreList.addAll(_storeList);
      notifyListeners();
    } else {
      _searchableStoreList.clear();
      _searchableStoreList.addAll(_storeList
          .where((b) =>
      b.name!.toLowerCase().contains(query) ||
          b.packageName!.toLowerCase().contains(query))
          .toList());
      notifyListeners();
    }
  }

  void syncTerminal() {
    Map<String, dynamic> request = {
      "deviceInfo": deviceInfo?.toJson(),
      "installedApp": installedAppList
    };
    apiRepository?.syncTerminal(request).then((response) {
      if (response['status'] == "success") {
        getAppsFromApi();
      } else {
        handleError(response);
      }
    });
  }

  void handleOpenApp({App? app}) {
    StoreMethod.startApp(app!.packageName!);
  }

  void handleInstallApp({App? app, AppVersion? version}) async {
    if (app != null) {
      if (version != null) {
        _installingList.add(app.copyWith(version: version));
      } else {
        _installingList.add(app);
      }
      notifyListeners();
    }

    if (!_isInstalling &&
        !_isDownloading &&
        _appInstalling == null &&
        _installingList.isNotEmpty) {
      _isDownloading = true;
      _appInstalling = AppInstalling.fromJson(_installingList.first.toJson());
      _appInstalling =
          _appInstalling!.copyWith(downloadProgress: 0.0, installed: false);
      _installingList.removeAt(0);
      notifyListeners();

      _cancelToken = CancelToken();
      String? apkPath = await _downloadApp(
          _appInstalling!.version!.downloadUrl!, _appInstalling!.packageName!);

      if (apkPath != null) {
        _isDownloading = false;
        _isInstalling = true;
        notifyListeners();
        await Future.delayed(const Duration(seconds: 3));
        await StoreMethod.installApp(apkPath, _appInstalling!.packageName!);

        await Future.delayed(const Duration(seconds: 3));
        _installedAppList = await StoreMethod.getInstalledApps();
        notifyListeners();

        InstalledAppInfo? installed;
        try {
          installed = _installedAppList.firstWhere(
                (a) {
              return a.packageName == _appInstalling!.packageName!;
            },
          );
        } catch (e) {
          installed = null;
        }

        if (installed != null) {
          List<App> updatedApp = _storeList.map((e) {
            if (e.packageName == app!.packageName) {
              if (installed!.versionCode ==
                  int.parse(app.version!.versionCode!)) {
                App updateApp = app.copyWith(action: AppAction.open);
                return updateApp;
              }
              if (int.parse(e.version!.versionCode!) > installed.versionCode) {
                App updateApp = app.copyWith(action: AppAction.update);
                return updateApp;
              }
            }
            return e;
          }).toList();

          _storeList.clear();
          _storeList.addAll(updatedApp);

          _searchableStoreList.clear();
          _searchableStoreList.addAll(updatedApp);

          _updateCount = updatedApp
              .where((a) => a.action == AppAction.update)
              .toList()
              .length;

          notifyListeners();

          goto.openSnackBar(
              "${_appInstalling!.name!} ${_appInstalling!.version!.version} installed successfully");
          apiRepository!.notifyDownload(
              _appInstalling!.uuid!, _appInstalling!.version!.uuid!);
        } else {
          goto.openSnackBar(
              "${_appInstalling!.name!} ${_appInstalling!.version!.version} installation failed");
        }
        try {
          File(apkPath).delete();
        } catch (e) {
          print(e);
        }
      }

      _cancelToken = null;
      _isDownloading = false;
      _isInstalling = false;
      _appInstalling = null;
      notifyListeners();
      handleInstallApp();
    }
  }

  void cancelDownload() {
    if (_cancelToken != null) {
      _cancelToken!.cancel("Download canceled by device user");
    }
  }

  Future<String?> _downloadApp(String url, String packageName) async {
    print("About to prrint download");
    String tempDir = (await getExternalStorageDirectory())!.uri.toFilePath();
    String savePath =
        "$tempDir/app_${packageName}_${DateTime.now().millisecondsSinceEpoch}.apk";
    try {
      Response response = await dio.download(
        url,
        savePath,
        cancelToken: _cancelToken,
        onReceiveProgress: (received, total) {
          _appInstalling = _appInstalling!
              .copyWith(downloadProgress: ((received / total) * 100));
          notifyListeners();
        },
      );
      print(response);
      if (response.statusCode == 200 &&
          _appInstalling!.downloadProgress == 100) {
        return savePath;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  void handleError(Map<String, dynamic> response, {bool notify = false}) {
    if (notify) {
      goto.openSnackBar(response['message']);
    } else {
      _errorMessage = response['message'];
      if(response['message'].toString().toLowerCase() == "no internet connection"){
        _showInitErrorButton = true;
      }
    }
    setLoading(false);
  }

  void showVersions(App app) async {
    if (app.versions!.length > 1) {
      String? installedVersion;
      if (app.action != null && app.action != AppAction.install) {
        try {
          InstalledAppInfo found = _installedAppList
              .firstWhere((e) => e.packageName == app.packageName);

          installedVersion = found.versionCode.toString();
        } catch (e) {}
      }

      AppVersion? version = await goto.openBottomSheet(
          VersionSheet(
            app: app,
            installedVersion: installedVersion,
          ),
          height: 420);
      if (version != null) {
        handleInstallApp(app: app, version: version);
      }
    } else {
      goto.openSnackBar("No available version history");
    }
  }

  void startWebsocket() {
    try {
      if (stompClient == null) {
        stompClient = StompClient(
            config: StompConfig(
                url: kWSBaseEndpoint,
                onConnect: _onConnect,
                onWebSocketError: (dynamic error) =>
                    debugPrint(error.toString()),
                webSocketConnectHeaders: {
                  'Connection': 'Upgrade',
                  'Upgrade': 'websocket',
                  // 'Host': 'localhost:8090'
                }));

        stompClient!.activate();
      }
    } catch (e) {
      print(e);
    }
  }

  void _onConnect(StompFrame frame) {
    // debugPrint('Connected: ${frame.headers}');
    if (_developer != null) {
      stompClient!.subscribe(
          destination: '/topic/notify_developer_${_developer!.uuid}',
          callback: (StompFrame frame) {
            if (frame.body != null) {
              Map<String, dynamic> wsMessage = json.decode(frame.body!);
              // debugPrint(wsMessage.toString());
              _wsActionHandler(wsMessage);
            }
          });
    }
  }

  void _wsActionHandler(Map<String, dynamic> socketMessage) {
    String action = socketMessage['action'];
    switch (action) {
      case "new_event":
        getData();
        break;
      default:
        null;
    }
  }
}
