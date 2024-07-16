import 'package:flutter/material.dart';

import 'core/providers/setup.dart';
import 'core/utils/custom_theme.dart';
import 'route/router.dart';

class AppMain extends StatelessWidget {
  const AppMain({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: providers,
        child: MaterialApp.router(
          title: "ITEX Store",
          theme: CustomTheme.theme,
          themeMode: ThemeMode.light,
          debugShowCheckedModeBanner: false,
          routerConfig: Routers().router,
        ));
  }
}
