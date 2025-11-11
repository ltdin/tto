import 'package:flutter/material.dart';
import 'package:news/constant/color.dart';
import 'package:news/constant/font.dart';

class TextUnderline extends StatelessWidget {
  const TextUnderline(
      {Key key, this.onTap, this.text, this.color = CL_TEXT_LINK})
      : super(key: key);

  final VoidCallback onTap;
  final String text;
  final Color color;

  Widget build(BuildContext context) {
    return InkWell(
      child: Text(
        text ?? 'Text',
        style: KfontConstant.defaultStyle.copyWith(
          color: color,
          decoration: TextDecoration.underline,
        ),
      ),
      onTap: () => onTap != null ? onTap.call() : null,
    );
  }
}
