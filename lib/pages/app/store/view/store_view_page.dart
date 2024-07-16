import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../core/models/model.dart';
import '../../../../core/providers/global_provider.dart';
import '../../../../core/providers/setup.dart';
import '../../../../core/services/navigation.dart';
import '../../../../utils/constant.dart';
import '../../../widgets/action_button.dart';
import '../../../widgets/reusable.dart';

class StoreViewPage extends StatefulWidget {
  final App app;

  const StoreViewPage({super.key, required this.app});

  @override
  State<StoreViewPage> createState() => _StoreViewPageState();
}

class _StoreViewPageState extends State<StoreViewPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<GlobalProvider>(
        builder: (_, gp, __) => Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.white,
                elevation: 0,
                surfaceTintColor: Colors.white,
              ),
              body: _buildBody(gp),
            ));
  }

  Widget _buildBody(gp) {
    return Stack(children: [
      Column(children: [
        _buildTopHeader(gp, widget.app),
        Expanded(child: _buildScrollablePage(gp, widget.app))
      ]),
      Positioned(
          bottom: 0,
          right: 0,
          left: 0,
          child: _buildVersionHistoryCard(gp, widget.app))
    ]);
  }

  Widget _buildVersionHistoryCard(GlobalProvider gp, App app) {
    return GestureDetector(
        onTap: () {
          gp.showVersions(app);
        },
        child: Card(
            margin: EdgeInsets.zero,
            shape:
                const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
              child: const Row(
                children: [
                  Expanded(
                      child: Text(
                    "Version History",
                    style: TextStyle(
                        fontWeight: FontWeight.w600, color: kBaseColor),
                  )),
                  Icon(
                    Icons.arrow_forward_ios_outlined,
                    size: 20,
                  )
                ],
              ),
            )));
  }

  Widget _buildTopHeader(GlobalProvider gp, App app) {
    return Card(
        elevation: 1,
        margin: EdgeInsets.zero,
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
        child: Container(
          color: Colors.white,
          child: Column(children: [
            _buildAppInfoName(app),
            Divider(
              color: Colors.grey[300],
            ),
            _buildAppDownload(gp, app),
          ]),
        ));
  }

  Widget _buildScrollablePage(GlobalProvider gp, App app) {
    return CustomScrollView(
      slivers: [
        _buildScreenShots(app),
        _buildAppDetails(app),
        // _buildVersionHistories(app)
      ],
    );
  }

  Widget _buildAppInfoName(App app) {
    return Container(
        padding: const EdgeInsets.only(left: 15, right: 15, bottom: 15, top: 0),
        child: Row(
          children: [
            Hero(
                tag: app.packageName!,
                child: appIcon(app.icon, height: 60, width: 60)),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      app.name!,
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      app.category!.name!,
                      style: const TextStyle(
                          fontSize: 13, fontWeight: FontWeight.w600),
                    ),
                    Text(
                      app.developer?.organizationName ?? "ITEX Integrated",
                      style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: kBaseGreenColor),
                    )
                  ]),
            )
          ],
        ));
  }

  Widget _buildAppDownload(GlobalProvider gp, App app) {
    return Container(
        padding: const EdgeInsets.only(left: 15, right: 15, bottom: 10),
        child: Row(
          children: [
            Expanded(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _downloadInfo("Version", "${app.version!.version}"),
                vDivider(),
                _downloadInfo("Size", "${app.version!.size}"),
              ],
            )),
            const SizedBox(
              width: 15,
            ),
            SizedBox(width: 100, child: ActionButton(app: app, showOpen: true))
          ],
        ));
  }

  Widget _downloadInfo(String key, String value) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(key,
              style: Theme.of(context)
                  .textTheme
                  .labelMedium!
                  .copyWith(fontSize: 11)),
          Text(value,
              style:
                  const TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
        ]);
  }

  Widget _buildScreenShots(App app) {
    return SliverToBoxAdapter(
        child: app.screenShots!.isNotEmpty
            ? Container(
                height: 200.0,
                color: CupertinoColors.tertiarySystemFill.withOpacity(0.2),
                padding: const EdgeInsets.symmetric(vertical: 15),
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: app.screenShots!.length,
                  itemBuilder: (context, index) {
                    AppScreenShot shot = app.screenShots![index];
                    return Container(
                        margin: EdgeInsets.only(
                            left: index == 0 ? 15 : 0, right: 10),
                        child: GestureDetector(
                          onTap: () {
                            goto.openFullDialog(
                                "", fullScreenShoot(app.screenShots!, context),
                                barrierDismiss: true);
                          },
                          child: appIcon(shot.imageUrl,
                              height: 170,
                              width: 90,
                              padding: 0,
                              elevation: 5,
                              borderRadius: 4,
                              fit: BoxFit.fill,
                              color: Colors.white),
                        ));
                  },
                ),
              )
            : const SizedBox());
  }

  Widget _buildAppDetails(App app) {
    return SliverList(
        delegate: SliverChildListDelegate([
      Divider(
        color: Colors.grey[800],
        height: 0,
      ),
      _buildAppDetailItem("About this app", app.description!),
      if (app.versions!.length > 1)
        _buildAppDetailItem("What's new", app.description!),
      _buildAppDetailItem(
          "Developer", app.developer?.organizationName ?? "ITEX Integrated"),
      if (app.distributor != null)
        _buildAppDetailItem("Distributor", app.distributor!.distributorName!),
      const SizedBox(
        height: 100,
      )
    ]));
  }

  Widget _buildAppDetailItem(String key, String value) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(key,
                style:
                    const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            Text(value, style: const TextStyle(fontSize: 13))
          ],
        ));
  }

// Widget _buildVersionHistories(App app) {
//   return SliverStickyHeader.builder(
//     builder: (context, state) => Card(
//         elevation: state.isPinned ? 1 : 0,
//         child: Container(
//           color: Colors.white,
//           padding: const EdgeInsets.symmetric(
//             horizontal: 15.0,
//             vertical: 10,
//           ),
//           child: Row(
//             children: [Expanded(), Icon],
//           ),
//         )),
//     sliver: SliverList(
//       delegate: SliverChildBuilderDelegate(
//         (context, i) => ListTile(
//           leading: CircleAvatar(
//             child: Text('0'),
//           ),
//           title: Text('List tile #$i'),
//         ),
//         childCount: 4,
//       ),
//     ),
//   );
// }
}
