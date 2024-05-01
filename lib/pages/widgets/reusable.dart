// import 'package:cached_network_image/cached_network_image.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:itexstore_agent/core/providers/global_provider.dart';
import 'package:itexstore_agent/utils/constant.dart';

import 'dart:ui' as ui;

import '../../core/models/model.dart';

// import '../../core/providers/global_provider.dart';
import '../../core/services/navigation.dart';

// import '../../utils/components/buttons.dart';
import '../../utils/components/loader.dart';

// import '../../utils/constant.dart';
// import '../../utils/enums.dart';

Widget appIcon(String? appIconUrl,
    {double height = 50,
    double width = 50,
    double elevation = 1,
      double padding = 3,
    BoxFit fit = BoxFit.cover,
    double borderRadius = 8,
    Color color = CupertinoColors.tertiarySystemFill}) {
  return Card(
      margin: const EdgeInsets.all(2),
      elevation: elevation,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius)),
      // color: CupertinoColors.tertiarySystemFill,
      child: _placeholder(
        height: height,
        width: width,
        color: color,
        padding: padding,
        borderRadius: borderRadius,
        child:
            // Image.network(
            //   appIconUrl!,
            //   height: height,
            //   width: width,
            //   fit: fit,
            //   errorBuilder: (context, _, __) {
            //     return const Icon(Icons.error, color: Colors.redAccent, size: 20);
            //   },
            // ),

            CachedNetworkImage(
          imageUrl: appIconUrl!,
          height: height,
          width: width,
          fit: BoxFit.cover,
          placeholder: (context, url) => const Loader(size: 20, strokes: 2),
          errorWidget: (context, url, error) =>
              const Icon(Icons.error, color: Colors.redAccent, size: 20),
        ),
      ));
}

Widget downloadButton(GlobalProvider gp) {
  return Container(
    margin: const EdgeInsets.only(top: 4, bottom: 3),
    height: 40,
    width: 40,
    child: Stack(
      alignment: Alignment.center,
      children: [
        CircularProgressIndicator(
          strokeWidth: 2,
          color: kBaseGreenColor,
          // value:  0.7,
          value: double.parse(
                  gp.appInstalling!.downloadProgress!.toStringAsFixed(2)) /
              100,
        ),
        IconButton(
            onPressed: () => gp.cancelDownload(),
            padding: EdgeInsets.zero,
            icon: const Icon(
              Icons.stop_rounded,
              color: Color(0xFF1B1573),
              size: 25,
            ))
      ],
    ),
  );
}

Widget fullScreenShoot(List<AppScreenShot> screenShots, BuildContext context) {
  Size screenSize = ui.window.physicalSize / ui.window.devicePixelRatio;
  double screenWidth = screenSize.width;
  double screenHeight = screenSize.height;
  return Column(children: [
    AppBar(),
    Expanded(
        child: GestureDetector(
      onTap: () {
        goto.back();
      },
      child: SizedBox(
          height: screenHeight - 60,
          width: screenWidth,
          // padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 50),
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, i) {
              AppScreenShot shot = screenShots[i];

              return Container(
                  color: Colors.black87,
                  height: screenHeight,
                  width: screenWidth,
                  padding:
                      const EdgeInsets.only(left: 50, right: 50, bottom: 50),
                  child: CachedNetworkImage(
                    imageUrl: shot.imageUrl!,
                    // height: height,
                    // width: width,
                    fit: BoxFit.cover,
                    placeholder: (context, url) =>
                        const Loader(size: 20, strokes: 2),
                    errorWidget: (context, url, error) => const Icon(
                        Icons.error,
                        color: Colors.redAccent,
                        size: 20),
                  ));
              // Image.network(
              //   shot.imageUrl!,
              //
              //   fit: BoxFit.cover,
              //   // loadingBuilder: (),
              // ));
            },
            itemCount: screenShots.length,
          )

          // CachedNetworkImage(
          //   imageUrl: imgUrl,
          //   height: screenHeight - 100,
          //   width: screenWidth - 100,
          //   fit: BoxFit.cover,
          //   placeholder: (context, url) => _placeholder(
          //     child: const Loader(size: 20, strokes: 2),
          //     height: screenHeight - 100,
          //     width: screenWidth - 100,
          //   ),
          //   errorWidget: (context, url, error) => _placeholder(
          //     child: const Icon(Icons.error, color: Colors.redAccent, size: 20),
          //     height: screenHeight - 100,
          //     width: screenWidth - 100,
          //   ),
          // ),
          ),
    )),
  ]);
}

Widget _placeholder(
    {required Widget? child,
    double height = 70,
      double padding =3,
    double width = 70,
    double borderRadius = 8,
    Color color = CupertinoColors.tertiarySystemFill}) {
  return Container(
    height: height,
    width: width,
    padding:   EdgeInsets.all(padding),
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius), color: color),
    child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius), child: child),
  );
}

Widget emptyWidget({String message = "No Item Found"}) {
  return Center(
      child: Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Icon(Icons.widgets,
          color: CupertinoColors.tertiarySystemFill.withOpacity(0.6), size: 70),
      const SizedBox(height: 10),
      Text(
        message,
        style: TextStyle(
            color: CupertinoColors.tertiarySystemFill.withOpacity(0.8),
            fontWeight: FontWeight.w600),
      )
    ],
  ));
}

Widget vDivider({double height = 10}) {
  return Container(
    height: height,
    width: 1,
    color: CupertinoColors.tertiarySystemFill.withOpacity(0.7),
  );
}
