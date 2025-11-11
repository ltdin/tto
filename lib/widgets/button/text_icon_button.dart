import 'package:flutter/material.dart';

class TextIconButton extends StatelessWidget {
  const TextIconButton({
    Key key,
    this.title,
    this.icon,
    this.onPressed,
    this.textColor = Colors.white,
    this.height = 32.0,
    this.borderRadius = 16.0,
    this.buttonColor = Colors.red,
  }) : super(key: key);

  final String title;
  final Widget icon;
  final Color buttonColor;
  final Color textColor;
  final double height;
  final double borderRadius;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onPressed.call(),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        height: height,
        decoration: BoxDecoration(
          color: buttonColor,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Text(
                title,
                style: TextStyle(color: textColor),
              ),
            ),
            icon,
          ],
        ),
      ),
    );
  }
}
