import 'package:flutter/material.dart';

class IconTextOutlineButton extends StatelessWidget {
  const IconTextOutlineButton({
    Key key,
    this.title,
    this.icon,
    this.onPressed,
    this.color = Colors.white,
    this.height = 32.0,
    this.borderRadius = 16.0,
  }) : super(key: key);

  final String title;
  final Widget icon;
  final Color color;
  final double height;
  final double borderRadius;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        height: height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius),
          border: Border.all(color: color),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null)
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: icon,
              ),
            Text(title, style: TextStyle(color: color)),
          ],
        ),
      ),
    );
  }
}
