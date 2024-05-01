import 'package:flutter/material.dart';

class ErrorPage extends StatelessWidget {
  const ErrorPage(this.error, {super.key});
  final Exception error;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        extendBody: true,
        body: Center(
          child: Text(error.toString()),
        ));
  }
}
