import 'package:flutter/material.dart';
import 'package:itexstore_agent/pages/widgets/reusable.dart';
import 'package:provider/provider.dart';

import '../../core/models/model.dart';
import '../../core/providers/global_provider.dart';
import '../../utils/components/buttons.dart';
import '../../utils/components/loader.dart';
import '../../utils/constant.dart';
import '../../utils/enums.dart';

class ActionButton extends StatefulWidget {
  final App app;
  final bool? showOpen;

  const ActionButton({super.key, required this.app, this.showOpen = false});

  @override
  State<ActionButton> createState() => _ActionButtonState();
}

class _ActionButtonState extends State<ActionButton> {
  @override
  Widget build(BuildContext context) {
    return Consumer<GlobalProvider>(builder: (_, gp, __) {
      return SizedBox(
          width: 80,
          child: (gp.appInstalling != null &&
                  gp.appInstalling!.packageName == widget.app.packageName!)
              ? (gp.isDownloading
                  ?
                  // LinearProgressIndicator(
                  //             value:  double.parse(gp.appInstalling!.downloadProgress!.toStringAsFixed(2)),
                  //             color: kBaseGreenColor,
                  //             borderRadius: BorderRadius.circular(10),
                  //           )
                  downloadButton(gp)
                  : gp.isInstalling
                      ? const Loader(
                          size: 20, strokes: 2, color: kBaseGreenColor)
                      : const SizedBox())
              : (gp.installingList!.isNotEmpty &&
                      gp.installingList!.contains(widget.app))
                  ? const Loader(size: 20, strokes: 2)
                  : (widget.app.action == AppAction.install)
                      ? FilledButton(
                          style: filledButton,
                          onPressed: () {
                            gp.handleInstallApp(app: widget.app);
                          },
                          child: const Text("Install",
                              style: TextStyle(
                                  fontSize: 13, fontWeight: FontWeight.w600)))
                      : (widget.app.action == AppAction.update)
                          ? OutlinedButton(
                              style: outlinedButton,
                              onPressed: () {
                                gp.handleInstallApp(app: widget.app);
                              },
                              child: const Text("Update",
                                  style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600)))
                          : widget.showOpen!
                              ? OutlinedButton(
                                  style: outlinedButton,
                                  onPressed: () {
                                    gp.handleOpenApp(app: widget.app);
                                  },
                                  child: const Text("Open",
                                      style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w600)))
                              : const SizedBox());
    });
  }
}
