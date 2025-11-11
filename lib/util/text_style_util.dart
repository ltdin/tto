import 'dart:io';

import 'package:flutter/material.dart';

class TTOTextStyle {
  // ignore: non_constant_identifier_names
  static String get TTOFontFamily => Platform.isIOS ? "SFProText" : "Roboto";

  static TextStyle regular({Color color, double fontSize}) {
    return TextStyle(
        fontFamily: TTOFontFamily, color: color, fontSize: fontSize);
  }

  static TextStyle medium({Color color, double fontSize}) {
    return TextStyle(
        fontFamily: TTOFontFamily,
        fontWeight: FontWeight.w500,
        color: color,
        fontSize: fontSize);
  }

  static TextStyle bold({Color color, double fontSize}) {
    return TextStyle(
        fontFamily: TTOFontFamily,
        fontWeight: FontWeight.w800,
        color: color,
        fontSize: fontSize);
  }
}
