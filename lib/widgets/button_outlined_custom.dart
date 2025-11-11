import 'package:flutter/material.dart';
import 'package:news/constant/color.dart';
import 'package:news/constant/font.dart';

class ButtonOutlinedCustom extends StatelessWidget {
  const ButtonOutlinedCustom({
    Key key,
    this.onClick,
    this.padding = EdgeInsets.zero,
    this.content,
    this.margin = EdgeInsets.zero,
    this.height = 40,
    this.width = double.maxFinite,
  }) : super(key: key);

  final EdgeInsets padding;
  final EdgeInsets margin;
  final Widget content;
  final VoidCallback onClick;
  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      padding: padding,
      margin: margin,
      width: width,
      child: OutlinedButton(
        style: KfontConstant.styleButtonVote.copyWith(
          backgroundColor:
              MaterialStateProperty.all<Color>(cardNewsBorderColor),
        ),
        child: content ?? Offstage(),
        onPressed: () => onClick?.call(),
      ),
    );
  }
}
