import 'package:flutter/material.dart';
// utils
import 'package:news/util/text_style_util.dart';

class TTOCommentPageSettingsUI {
  final TextStyle titleStyle = TTOTextStyle.regular(color: Colors.black);
  final TextStyle firstCommentStyle =
      TTOTextStyle.regular(color: Colors.black, fontSize: 15.0);
  final TextStyle loginStyle = TTOTextStyle.regular(
      color: Colors.black.withOpacity(0.7), fontSize: 15.0);
  final double bottomInputHeight = 40.0;
  final EdgeInsets inputContentPadding = EdgeInsets.symmetric(horizontal: 16.0);
}
