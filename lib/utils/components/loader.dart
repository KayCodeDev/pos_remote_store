import 'package:flutter/material.dart';

import '../constant.dart';

class Loader extends StatelessWidget {
  final double size;
  final double strokes;
  final Color color;
  const Loader(
      {super.key, this.size = 30, this.strokes = 4, this.color = kBaseColor});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: SizedBox(
            width: size,
            height: size,
            child: CircularProgressIndicator(
              strokeWidth: strokes,
              color: color,
            )));
  }
}
