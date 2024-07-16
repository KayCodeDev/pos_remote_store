import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../../core/providers/global_provider.dart';
import '../../utils/constant.dart';
import 'setting/setting_page.dart';
import 'store/list/store_list_page.dart';
import 'store/update/store_update_page.dart';

class StorePage extends StatefulWidget {
  final Map<String, dynamic>? extra;

  const StorePage({super.key, required this.extra});

  @override
  State<StorePage> createState() => _StorePageState();
}

class _StorePageState extends State<StorePage> {
  final List<Widget> _screens = [];

  @override
  void initState() {
    super.initState();
    _screens.addAll(<Widget>[
      const StoreListPage(),
      const StoreUpdatePage(),
      const SettingPage()
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<GlobalProvider>(
      builder: (_, gp, __) => PopScope(
        canPop: false,
        onPopInvoked: (bool popped) {},
        child: Scaffold(
          body: _screens.elementAt(gp.screen),
          bottomNavigationBar: NavigationBar(
            elevation: 5,
            selectedIndex: gp.screen,
            onDestinationSelected: (index) {
              gp.switchScreen(index);
            },
            destinations: [
              const NavigationDestination(
                tooltip: '',
                icon: Icon(
                  Icons.apps,
                  size: 28,
                ),
                label: 'Store',
                selectedIcon: Icon(
                  Icons.apps,
                  color: kBaseGreenColor,
                  size: 28,
                ),
              ),
              NavigationDestination(
                tooltip: '',
                icon: gp.updateCount > 0
                    ? Badge.count(
                        count: gp.updateCount,
                        child: const Icon(
                          Icons.cloud_done_rounded,
                          size: 28,
                        ))
                    : const Icon(
                        Icons.cloud_done_rounded,
                        size: 28,
                      ),
                label: 'Updates',
                selectedIcon: gp.updateCount > 0
                    ? Badge.count(
                        count: gp.updateCount,
                        child: const Icon(
                          Icons.cloud_done_rounded,
                          size: 28,
                          color: kBaseGreenColor,
                        ))
                    : const Icon(
                        Icons.cloud_done_rounded,
                        size: 28,
                        color: kBaseGreenColor,
                      ),
              ),
              const NavigationDestination(
                tooltip: '',
                icon: Icon(
                  Icons.settings,
                  size: 28,
                ),
                label: 'Settings',
                selectedIcon: Icon(
                  Icons.settings,
                  color: kBaseGreenColor,
                  size: 28,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
