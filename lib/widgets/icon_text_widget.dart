import 'package:flutter/material.dart';

class IconTextWidget extends StatelessWidget {
  const IconTextWidget({
    Key key,
    @required this.icon,
    @required this.text,
    this.onPressed,
    this.textStyle,
  }) : super(key: key);

  final Widget icon;
  final String text;
  final VoidCallback onPressed;
  final TextStyle textStyle;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 20,
              height: 20,
              child: icon,
            ),
            if (text.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(left: 24),
                child: Text(
                  text,
                  style: textStyle != null ? textStyle : null,
                ),
              )
          ],
        ),
      ),
      onTap: () {
        if (onPressed != null) {
          onPressed();
        }
      },
    );
  }
}
