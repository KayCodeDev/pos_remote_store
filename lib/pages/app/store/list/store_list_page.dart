import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/models/model.dart';
import '../../../../core/providers/global_provider.dart';
import '../../../../core/services/navigation.dart';
import '../../../../route/path.dart';
import '../../../../utils/components/search_bar.dart';
import '../../../widgets/action_button.dart';
import '../../../widgets/reusable.dart';

class StoreListPage extends StatefulWidget {
  const StoreListPage({super.key});

  @override
  State<StoreListPage> createState() => _StoreListPageState();
}

class _StoreListPageState extends State<StoreListPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<GlobalProvider>(
        builder: (_, gp, __) => RefreshIndicator(
              onRefresh: () => gp.getData(),
              child: Scaffold(appBar: _buildAppBar(gp), body: _buildBody(gp)),
            ));
  }

  AppBar _buildAppBar(GlobalProvider gp) {
    return AppBar(
      backgroundColor: Colors.white,
      automaticallyImplyLeading: false,
      leading: Container(
          padding: const EdgeInsets.only(left: 15, top: 12, bottom: 12),
          child: Image.asset("assets/images/loader.png")),
      title: Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: CustomSearchBar(
            onChange: (String query) => gp.searchApp(query),
            title: "Search apps in store",
          )),
    );
  }

  Widget _buildBody(GlobalProvider gp) {
    return gp.searchableStoreList.isNotEmpty
        ? ListView.separated(
            padding: const EdgeInsets.only(top: 20),
            itemBuilder: (context, index) {
              App app = gp.searchableStoreList[index];

              return _buildAppTile(app, gp);
            },
            separatorBuilder: (context, index) {
              return const Divider();
            },
            itemCount: gp.searchableStoreList.length)
        : emptyWidget(message: "No App Found");
  }

  Widget _buildAppTile(App app, GlobalProvider gp) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 15),
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
                      const SizedBox(height: 0),
                      Text(app.category!.name!,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(fontSize: 12)),
                      const SizedBox(height: 2),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "v${app.version!.version}",
                            style: Theme.of(context)
                                .textTheme
                                .labelMedium!
                                .copyWith(fontSize: 12),
                          ),
                          const SizedBox(width: 10),
                          vDivider(),
                          const SizedBox(width: 10),
                          Text(
                            app.version!.size!,
                            style: Theme.of(context)
                                .textTheme
                                .labelMedium!
                                .copyWith(fontSize: 12),
                          ),
                        ],
                      )
                    ],
                  ))),
          const SizedBox(width: 15),
          ActionButton(app: app)
        ],
      ),
    );
  }
}
