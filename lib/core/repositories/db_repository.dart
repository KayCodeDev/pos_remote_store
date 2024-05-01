import 'package:flutter/foundation.dart';
import 'package:sembast/sembast.dart';

import '../models/model.dart';
import '../services/db.dart';

class DBRepository {
  final DB? _db;

  DBRepository({@required DB? db}) : _db = db;

  final _appStore = intMapStoreFactory.store('app_store');
  final _accountStore = intMapStoreFactory.store('accountStore');

  deleteAll() async {
    final dbInt = await _db!.database;
    await dbInt.transaction((txn) async {
      await _appStore.delete(txn);
      await _accountStore.delete(txn);
    });
  }

  saveApps(List<App> apps) async {
    List<Map<String, dynamic>> appList = [];

    for (App app in apps) {
      appList.add(app.toJson());
    }

    final dbInit = await _db!.database;
    await dbInit.transaction((txn) async {
      await _appStore.delete(txn);
      await _appStore.addAll(txn, appList);
    });
  }

  Future<List<App>> getApps() async {
    final dbInit = await _db!.database;
    final data = await _appStore.find(dbInit);

    return data.map((snapshot) {
      return App.fromJson(snapshot.value);
    }).toList();
  }

  saveAccount(Developer? developer) async {
    final dbInt = await _db!.database;
    await dbInt.transaction((txn) async {
      await _accountStore.delete(txn);
      await _accountStore.add(txn, developer!.toJson());
    });
  }

  Future<Developer?> getAccount() async {
    final dbInt = await _db!.database;

    final data = await _accountStore.findFirst(dbInt);
    if (data != null) {
      return Developer.fromJson(data.value);
    } else {
      return null;
    }
  }
}
