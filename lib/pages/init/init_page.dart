import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/providers/global_provider.dart';
import '../../utils/components/buttons.dart';
import '../../utils/components/loader.dart';
import '../../utils/constant.dart';
import '../widgets/base_provider_widget.dart';
import 'init_provider.dart';

class InitPage extends StatefulWidget {
  const InitPage({super.key});

  @override
  State<InitPage> createState() => _InitPageState();
}

class _InitPageState extends State<InitPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<GlobalProvider>(
        builder: (_, gp, __) => BaseProviderWidget<InitProvider>(
            model: InitProvider(
              global: gp,
            ),
            onModelReady: (model) => model.initState(),
            builder: (context, model, child) => Scaffold(
              body: _buildBody(model),
            )));
  }

  Widget _buildBody(InitProvider model) {
    return model.global.isLoading
        ? _buildLoadingScreen(model)
        : model.global.errorMessage != null
        ? _buildErrorScreen(model)
        : const Loader(size: 20, strokes: 2);
  }

  Widget _buildLoadingScreen(InitProvider model) {
    return Column(children: [
      Expanded(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset("assets/images/loader.png", height: 80),
                const SizedBox(height: 30),
                const Loader(
                  strokes: 4,
                  size: 25,
                ),
                const SizedBox(height: 10),
                const Text("Loading store. please wait")
              ])),
      model.global.storeInfo != null
          ? Container(
        padding: const EdgeInsets.symmetric(vertical: 15),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/images/loader.png", height: 20),
            const SizedBox(width: 10),
            Text(
              "${model.global.storeInfo!.name} v${model.global.storeInfo!.versionName}",
              style: const TextStyle(fontWeight: FontWeight.w600),
            )
          ],
        ),
      )
          : Container()
    ]);
  }

  Widget _buildErrorScreen(InitProvider model) {
    return Column(children: [
      Expanded(
          child: Center(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.info, color: Colors.red, size: 70),
                    const SizedBox(height: 20),
                    Container(
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        child: Text(
                          model.global.errorMessage!,
                          textAlign: TextAlign.center,
                        )),
                    const SizedBox(height: 10),
                    if (model.global.showInitErrorButton)
                      OutlinedButton(
                        onPressed: () {
                          model.initState();
                        },
                        style: outlinedButton,
                        child: const Text("Try Again"),
                      ),
                  ]))),
      Container(
        padding: const EdgeInsets.symmetric(vertical: 15),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/images/loader.png", height: 20),
            const SizedBox(width: 10),
            Text(
              model.global.storeInfo != null
                  ? "${model.global.storeInfo!.name} v${model.global.storeInfo!.versionName}"
                  : kAppName,
              style: const TextStyle(fontWeight: FontWeight.w600),
            )
          ],
        ),
      )
    ]);
  }
}
