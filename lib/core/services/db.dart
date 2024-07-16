// ignore_for_file: depend_on_referenced_packages

import 'dart:async';

import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';
import 'package:path/path.dart';

import '../../utils/constant.dart';

class DB {
  static final DB _singleton = DB._();

  static DB get instance => _singleton;

  Completer<Database>? _db;

  DB._();

  Future<Database> get database async {
    if (_db == null) {
      _db = Completer();
      _openDatabase();
    }

    return _db!.future;
  }

  Future _openDatabase() async {
    final appDocumentDir = await getApplicationDocumentsDirectory();
    final dbPath = join(appDocumentDir.path, kDatabaseName);
    final database = await databaseFactoryIo.openDatabase(dbPath);

    _db!.complete(database);
  }
}
