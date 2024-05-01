import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'app.dart';
import 'utils/constant.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
        statusBarColor: kBaseColor,
        statusBarBrightness: Brightness.light),
  );

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((value) {
    runApp(const AppMain());
  });
}
