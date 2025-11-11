import 'package:flutter/material.dart';
import 'package:news/constant/color.dart';

class AcceptButton extends StatelessWidget {
  const AcceptButton({
    this.onTap,
    this.title,
    this.backgroundColor,
    this.borderColor,
    this.style = const TextStyle(color: CL_WHITE),
  });

  final Function onTap;
  final Color backgroundColor;
  final Color borderColor;
  final String title;
  final TextStyle style;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap ?? () {},
      child: Container(
        height: 40,
        alignment: Alignment.center,
        child: Text(title ?? 'OK', style: style),
        margin: const EdgeInsets.only(left: 16, right: 16),
        decoration: BoxDecoration(
          border: Border.all(color: borderColor ?? PRIMARY_COLOR),
          color: backgroundColor ?? PRIMARY_COLOR,
          borderRadius: const BorderRadius.all(Radius.circular(4)),
        ),
      ),
    );
  }
}
