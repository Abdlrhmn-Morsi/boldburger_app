import 'package:flutter/material.dart';

class Themes {
  static final light = ThemeData(
    brightness: Brightness.light,
    colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.black),
  );
  static final dark = ThemeData(
    colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.black),
    brightness: Brightness.dark,
  );
}
