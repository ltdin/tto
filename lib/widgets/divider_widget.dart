import 'package:flutter/material.dart';
import 'package:flutter_dash_nullsafety/flutter_dash_nullsafety.dart';
import 'package:news/constant/length.dart';

class DividerWidget extends StatelessWidget {
  const DividerWidget({
    this.isSolid = false,
    this.subtract = 0,
    this.color,
  });

  final bool isSolid;
  final double subtract;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final color = this.color ?? Theme.of(context).textTheme.caption.color;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: paddingDivider),
      child: isSolid
          ? Padding(
              padding: EdgeInsets.symmetric(horizontal: subtract),
              child: Divider(color: color, thickness: 0.5),
            )
          : Padding(
              padding: const EdgeInsets.symmetric(vertical: paddingDivider),
              child: Dash(
                direction: Axis.horizontal,
                length: MediaQuery.of(context).size.width -
                    ((paddingNews * 2) + subtract),
                dashColor: color,
                dashThickness: 0.5,
              ),
            ),
    );
  }
}

class DrawDottedhorizontalline extends CustomPainter {
  Paint _paint;
  DrawDottedhorizontalline({Color color, double thickness}) {
    _paint = Paint();
    _paint.color = color; // dots color
    _paint.strokeWidth = thickness; // dots thickness
    // _paint.strokeCap = StrokeCap.square; // dots corner edges
    _paint.strokeMiterLimit = 10;
  }

  @override
  void paint(Canvas canvas, Size size) {
    for (double i = -300; i < 300; i = i + 15) {
      // 15 is space between dots
      if (i % 3 == 0)
        canvas.drawLine(Offset(i, 0.0), Offset(i + 10, 0.0), _paint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
