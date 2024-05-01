import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../../../core/providers/global_provider.dart';
import '../../../core/services/navigation.dart';
import '../../widgets/bottom_sheet/about_sheet.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<GlobalProvider>(
        builder: (_, gp, __) => Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            automaticallyImplyLeading: false,
            title: const Text("Setting"
          ),
          ),
          body: _buildBody(gp),
        ));
  }

  Widget _buildBody(GlobalProvider gp){
    return ListView(children: [
      ListTile(
        onTap: (){
          goto.openBottomSheet(const AboutSheet(), height: 500);
        },
        title: const Text("About Store"),
        trailing: const Icon(Icons.arrow_forward_ios_outlined, size: 15),
      )
    ],);
  }
}
