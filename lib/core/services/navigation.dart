import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final Navigation goto = Navigation();

class Navigation<T, U> {
  static GlobalKey<NavigatorState> navigationKey = GlobalKey<NavigatorState>();

  void go(String path, {Object? args}) async =>
      navigationKey.currentContext?.go(path, extra: args);

  void refresh() async {
    GoRouter.of(navigationKey.currentContext!).refresh();
  }

  void goNamed(String name,
      {Map<String, String> pathParameters = const <String, String>{},
        Map<String, dynamic> queryParameters =
        const <String, dynamic>{}}) async =>
      navigationKey.currentContext?.goNamed(
        name,
        pathParameters: pathParameters,
        queryParameters: queryParameters,
      );

  String? namedLocation(String name,
      {Map<String, String> pathParameters = const <String, String>{},
        Map<String, dynamic> queryParameters = const <String, dynamic>{}}) {
    return navigationKey.currentContext?.namedLocation(
      name,
      pathParameters: pathParameters,
      queryParameters: queryParameters,
    );
  }

  Future<dynamic> push(String path, {Object? args}) async =>
      navigationKey.currentContext?.push(path, extra: args);

  Future<dynamic> pushWidget(Widget route) async =>
      navigationKey.currentState?.push<T>(
        MaterialPageRoute<T>(
          builder: (BuildContext context) => route,
        ),
      );

  Future<dynamic> pushNamed(String name,
      {Map<String, String> pathParameters = const <String, String>{},
        Map<String, dynamic> queryParameters =
        const <String, dynamic>{}}) async =>
      navigationKey.currentContext?.pushNamed(
        name,
        pathParameters: pathParameters,
        queryParameters: queryParameters,
      );

  Future<dynamic> pushReplacement(String name, {Object? args}) async =>
      navigationKey.currentContext?.pushReplacement(name, extra: args);

  Future<dynamic> pushReplacementNamed(String routeName,
      {Map<String, String> pathParameters = const <String, String>{},
        Map<String, dynamic> queryParameters =
        const <String, dynamic>{}}) async =>
      navigationKey.currentContext?.pushReplacementNamed(
        routeName,
        pathParameters: pathParameters,
        queryParameters: queryParameters,
      );

  Future<dynamic> replace(String name, {Object? args}) async =>
      navigationKey.currentContext?.replace(name, extra: args);

  Future<dynamic> replaceNamed(String routeName,
      {Map<String, String> pathParameters = const <String, String>{},
        Map<String, dynamic> queryParameters =
        const <String, dynamic>{}}) async =>
      navigationKey.currentContext?.replaceNamed(
        routeName,
        pathParameters: pathParameters,
        queryParameters: queryParameters,
      );

  bool canPop() => navigationKey.currentContext!.canPop();

  void back({dynamic result}) => navigationKey.currentContext?.pop(result);

  void openDialog(
      {String? title,
        String? message,
        List<Widget>? actions,
        bool barrierDismiss = false}) {
    showDialog<void>(
        context: navigationKey.currentContext!,
        builder: (_) => AlertDialog(
          contentPadding:
          const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          title: Text(
            title!,
            style: Theme.of(navigationKey.currentContext!)
                .textTheme
                .titleMedium,
          ),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10)),
          content: Text(message!),
          actions: actions ??
              <Widget>[
                TextButton(
                    onPressed: () {
                      this.back();
                    },
                    child: const Text("Close"))
              ],
        ),
        barrierDismissible: barrierDismiss);
  }

  void openFullDialog(String title, Widget content,
      {bool barrierDismiss = false}) {
    showDialog<void>(
        context: navigationKey.currentContext!,
        builder: (_) => Dialog.fullscreen(
          child: Scaffold(

            // extendBody: false,
            // appBar: AppBar(
            //   title: Text(title),
            //   centerTitle: false,
            //   leading: IconButton(
            //     icon: const Icon(Icons.arrow_back),
            //     onPressed: () => navigationKey.currentContext?.pop(),
            //   ),
            // ),
            body: content,
          ),
        ),
        barrierDismissible: barrierDismiss);
  }

  void openSnackBar(String? message) {
    final snackBar = SnackBar(
      behavior: SnackBarBehavior.floating,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.zero)),
      // width: MediaQuery.sizeOf(navigationKey.currentContext!).width,
      margin: EdgeInsets.zero,
      content: Text(message!),
      // margin: EdgeInsets.zero,
      action: SnackBarAction(
        label: 'Close',
        onPressed: () {},
      ),
    );

    ScaffoldMessenger.of(navigationKey.currentContext!).hideCurrentSnackBar();
    ScaffoldMessenger.of(navigationKey.currentContext!).showSnackBar(snackBar);
  }

  openBottomSheet(Widget bottomSheet,
      {bool isDismissible = true,
        bool enableDrag = true,
        double height = 300}) {
    return showModalBottomSheet<void>(
      showDragHandle: true,
      barrierColor: const Color.fromARGB(135, 57, 57, 57),
      isScrollControlled: true,
      isDismissible: isDismissible,
      enableDrag: enableDrag,
      backgroundColor: Colors.white,
      context: navigationKey.currentContext!,
      builder: (_) {
        return SizedBox(height: height, child: bottomSheet);
      },
      elevation: 2,
    );
  }
}
