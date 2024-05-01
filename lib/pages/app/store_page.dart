import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../../core/providers/global_provider.dart';
import '../../utils/constant.dart';
import 'remote/remote_page.dart';
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
      // if (widget.extra!['canRemote']) const RemotePage(),
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
              // const NavigationDestination(
              //     tooltip: '',
              //     icon: ImageIcon(
              //       AssetImage('assets/images/loader.png'),
              //       size: 30,
              //     ),
              //     label: 'Store',
              //     selectedIcon: ImageIcon(
              //       AssetImage('assets/images/loader.png'),
              //       size: 30,
              //       color: kBaseGreenColor,
              //     )),
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
              // if (widget.extra!['canRemote'])
              //   const NavigationDestination(
              //     tooltip: '',
              //     icon: Icon(
              //       Icons.ads_click_outlined,
              //       size: 28,
              //     ),
              //     label: 'Remote',
              //     selectedIcon: Icon(
              //       Icons.ads_click_outlined,
              //       color: kBaseGreenColor,
              //       size: 28,
              //     ),
              //   ),
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
