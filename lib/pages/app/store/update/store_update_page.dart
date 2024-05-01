import 'package:flutter/material.dart';
import '../../../../core/models/model.dart';
import '../../../../core/providers/global_provider.dart';
import '../../../../core/providers/setup.dart';
import '../../../../core/services/navigation.dart';
import '../../../../route/path.dart';
import '../../../../utils/constant.dart';
import '../../../../utils/enums.dart';
import '../../../widgets/action_button.dart';
import '../../../widgets/reusable.dart';

class StoreUpdatePage extends StatefulWidget {
  const StoreUpdatePage({super.key});

  @override
  State<StoreUpdatePage> createState() => _StoreUpdatePageState();
}

class _StoreUpdatePageState extends State<StoreUpdatePage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<GlobalProvider>(
        builder: (_, gp, __) => Scaffold(
              appBar: _buildAppBar(gp),
              body: _buildBody(gp),
            ));
  }

  AppBar _buildAppBar(GlobalProvider gp) {
    return AppBar(
      backgroundColor: Colors.white,
      automaticallyImplyLeading: false,
      title: Text("${gp.updateCount} Update${gp.updateCount > 1 ? "s" : ""}  "),
    );
  }

  Widget _buildBody(GlobalProvider gp) {
    List<App> appstoUpdate =
        gp.storeList.where((a) => a.action == AppAction.update).toList();
    return appstoUpdate.isNotEmpty
        ? ListView.separated(
            itemBuilder: (context, index) {
              App app = appstoUpdate[index];
              return _buildAppTile(app, gp);
            },
            separatorBuilder: (context, index) {
              return const Divider();
            },
            itemCount: appstoUpdate.length)
        : emptyWidget(message: "No Updates Available");
  }

  Widget _buildAppTile(App app, GlobalProvider gp) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      child: Row(
        children: [
          InkWell(
              onTap: () {
                goto.push(RouterPaths.storeApp, args: app);
              },
              child: Hero(tag: app.packageName!, child: appIcon(app.icon))),
          const SizedBox(width: 10),
          Expanded(
              child: InkWell(
                  onTap: () {
                    goto.push(RouterPaths.storeApp, args: app);
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(app.name!,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 14)),
                      const SizedBox(height: 5),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          // Text(
                          //   "v${app.oldVersion}",
                          //   style:  Theme.of(context)
                          //       .textTheme
                          //       .labelMedium!.copyWith(fontSize: 11),
                          // ),
                          // const SizedBox(width: 4),
                          const Icon(Icons.cloud_download_rounded,
                              color: kBaseGreenColor, size: 18),
                          const SizedBox(width: 4),
                          Text(
                            "v${app.version!.version}",
                            style: Theme.of(context)
                                .textTheme
                                .labelMedium!
                                .copyWith(
                                    fontSize: 11, fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                      // const SizedBox(height: 3),
                      Text(
                        app.version!.size!,
                        style: Theme.of(context)
                            .textTheme
                            .labelMedium!
                            .copyWith(fontSize: 12),
                      ),
                    ],
                  ))),
          const SizedBox(width: 15),
          ActionButton(app: app)
        ],
      ),
    );
  }
}
