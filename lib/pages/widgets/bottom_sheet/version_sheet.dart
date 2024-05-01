import 'package:flutter/material.dart';

import '../../../core/models/model.dart';
import '../../../core/services/navigation.dart';
import '../../../utils/components/buttons.dart';
import '../../../utils/helper.dart';

class VersionSheet extends StatefulWidget {
  final App app;
  final String? installedVersion;

  const VersionSheet({super.key, required this.app, this.installedVersion});

  @override
  State<VersionSheet> createState() => _VersionSheetState();
}

class _VersionSheetState extends State<VersionSheet> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(),
        Expanded(
            child: ListView.separated(
                itemBuilder: (context, index) {
                  AppVersion version = widget.app.versions![index];
                  return _versionItem(version);
                },
                separatorBuilder: (context, index) {
                  return const Divider();
                },
                itemCount: widget.app.versions!.length))
      ],
    );
  }

  Widget _versionItem(AppVersion version) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      child: Row(
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(version.version!,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),

                Text("Size: ${version.size}",
                    textAlign: TextAlign.start,
                    style: const TextStyle(fontSize: 12)),
                Text(
                    "Released On: ${Helper.formatDateTime(version.createdAt!)}",
                    textAlign: TextAlign.start,
                    style: const TextStyle(fontSize: 12)),
                // const SizedBox(height: 10),
                // Text(version.updateDescription!,
                //     overflow: TextOverflow.ellipsis,
                //     maxLines: 3, style: const TextStyle(fontSize: 12))
              ],
            ),
          ),
          const SizedBox(width: 30),
          widget.installedVersion == null ||
                  widget.installedVersion != version.versionCode
              ? OutlinedButton(
                  style: outlinedButton,
                  onPressed: () {
                    goto.back(result: version);
                  },
                  child: const Text("Install",
                      style:
                          TextStyle(fontSize: 13, fontWeight: FontWeight.w600)))
              : const SizedBox()
        ],
      ),
    );
  }
}
