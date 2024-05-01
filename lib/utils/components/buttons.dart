import 'package:flutter/material.dart';

import '../constant.dart';

final ButtonStyle outlinedButton = OutlinedButton.styleFrom(
  alignment: Alignment.center,
  side: const BorderSide(color: kBaseGreenColor, width: 1.5),
  // minimumSize: Size(80, 30),
  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
  padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 12),

);

final ButtonStyle filledButton = FilledButton.styleFrom(
  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
  backgroundColor: kBaseGreenColor,
  padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 12),
);
