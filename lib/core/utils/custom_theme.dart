// import 'dart:io';

// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../utils/constant.dart';

class CustomTheme {
  static ThemeData get theme => _theme();

  static _theme([TextTheme? textTheme]) {
    textTheme ??= ThemeData.light().textTheme;
    // const textStyleFunction = GoogleFonts;

    return ThemeData(
      useMaterial3: true,
      primarySwatch: kBaseMaterialColor,
      scaffoldBackgroundColor: Colors.white,
      colorScheme: ColorScheme.fromSeed(
        seedColor: kBaseColor,
        brightness: Brightness.light,
      ),
      dividerTheme: DividerThemeData(
        thickness: 1,
        color: Colors.grey[300],
      ),
      appBarTheme: const AppBarTheme(
        systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: kBaseColor,
            statusBarBrightness: Brightness.light
        )
      ),
      navigationBarTheme: NavigationBarThemeData(
        // backgroundColor: const Color(kBaseColor),
        labelTextStyle: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.selected)) {
            return ThemeData.light()
                .textTheme
                .bodyMedium!
                .copyWith(fontWeight: FontWeight.w600);
          }

          return null;
        }),
        indicatorColor: Colors.transparent,
        elevation: 1,
      ),
      bottomSheetTheme: const BottomSheetThemeData(
          modalBarrierColor: Color.fromARGB(134, 41, 41, 41)),
      textTheme: const TextTheme().copyWith(
        displayLarge: ThemeData.light().textTheme.displayLarge!.copyWith(
          fontFamily: "SegoeUI",
          color: const Color(0xFF696772),
        ),
        displayMedium: ThemeData.light().textTheme.displayMedium!.copyWith(
          fontFamily: "SegoeUI",
          color: const Color(0xFF696772),
        ),
        displaySmall: ThemeData.light().textTheme.displaySmall!.copyWith(
          fontFamily: "SegoeUI",
          color: const Color(0xFF696772),
        ),
        headlineLarge: ThemeData.light().textTheme.headlineLarge!.copyWith(
          fontFamily: "SegoeUI",
          fontWeight: FontWeight.bold,
          color: const Color(0xFF15141F),
        ),
        headlineMedium: ThemeData.light().textTheme.headlineMedium!.copyWith(
          fontFamily: "SegoeUI",
          fontWeight: FontWeight.w600,
          color: const Color(0xFF15141F),
        ),
        headlineSmall: ThemeData.light().textTheme.headlineSmall!.copyWith(
          fontFamily: "SegoeUI",
          fontWeight: FontWeight.w400,
          color: const Color(0xFF15141F),
        ),
        titleLarge: ThemeData.light().textTheme.titleLarge!.copyWith(
          fontFamily: "SegoeUI",
          fontWeight: FontWeight.bold,
          color: const Color(0xFF15141F),
        ),
        titleMedium: ThemeData.light().textTheme.titleMedium!.copyWith(
          fontFamily: "SegoeUI",
          fontWeight: FontWeight.w600,
          color: const Color(0xFF15141F),
        ),
        titleSmall: ThemeData.light().textTheme.titleSmall!.copyWith(
          fontFamily: "SegoeUI",
          fontWeight: FontWeight.w400,
          color: const Color(0xFF15141F),
        ),
        bodyLarge: ThemeData.light().textTheme.bodyLarge!.copyWith(
          fontFamily: "SegoeUI",
          fontWeight: FontWeight.w500,
          color: const Color.fromARGB(255, 9, 8, 13),
        ),
        bodyMedium: ThemeData.light().textTheme.bodyMedium!.copyWith(
          fontFamily: "SegoeUI",
          fontWeight: FontWeight.w500,
          color: const Color(0xFF15141F),
        ),
        bodySmall: ThemeData.light().textTheme.bodySmall!.copyWith(
          fontFamily: "SegoeUI",
          fontWeight: FontWeight.w400,
          color: const Color(0xFF15141F),
        ),
        labelLarge: ThemeData.light().textTheme.labelLarge!.copyWith(
          fontFamily: "SegoeUI",
          color: const Color(0xFF696772),
        ),
        labelMedium: ThemeData.light().textTheme.labelMedium!.copyWith(
          fontFamily: "SegoeUI",
          color: const Color(0xFF696772),
        ),
        labelSmall: ThemeData.light().textTheme.labelSmall!.copyWith(
          fontFamily: "SegoeUI",
          color: const Color(0xFF696772),
        ),
      ),
    );
  }
}
