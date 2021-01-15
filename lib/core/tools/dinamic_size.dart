import 'package:flutter/material.dart';

class DinamicSize {
  static double fontSize(
    BuildContext context,
    int size,
  ) {
    return MediaQuery.of(context).size.height * size / 1080;
  }

  static double heightSize(
    BuildContext context,
    int size,
  ) {
    return MediaQuery.of(context).size.height * size / 1080;
  }

  static double widthSize(
    BuildContext context,
    int size,
  ) {
    return MediaQuery.of(context).size.width * size / 1920;
  }

  static bool phoneMode(
    BuildContext context,
  ) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return height > width || width < 992;
  }
}
