import 'package:flutter/material.dart';

class AboutSheet extends StatefulWidget {
  const AboutSheet({super.key});

  @override
  State<AboutSheet> createState() => _AboutSheetState();
}

class _AboutSheetState extends State<AboutSheet> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      children: [
        const SizedBox(height: 20),
        Image.asset("assets/images/loader.png", height: 100),
        const SizedBox(height: 15),
        const Text(
          "ITEX Store",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        const Text(
          "ITEX Store is a proprietary POS terminal and app management platform by ITEX Integrated Services.\n\nApps distributed on this store are properties of Organization, Banks, Developers and Distributors who have listed their apps on the store for distribution on Android and Linux POS terminals.\n\nDownloading apps from this store is absolutely free and data collected are only for device management and OEM support",
        )
      ],
    );
  }
}
