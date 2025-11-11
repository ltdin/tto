import 'package:flutter/material.dart';
import 'package:news/constant/color.dart';
import 'package:news/constant/length.dart';

class ImageWithBorder extends StatelessWidget {
  const ImageWithBorder({this.urlImage, this.onTap});
  final urlImage;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        width: double.maxFinite,
        height: 65.0,
        padding: EdgeInsets.all(8.0),
        margin: EdgeInsets.symmetric(vertical: 8.0),
        child: Image.asset(urlImage),
        decoration: BoxDecoration(
          border: Border.all(color: borderImageColor),
          borderRadius: BorderRadius.circular(radius4),
        ),
      ),
      onTap: () => onTap != null ? onTap.call() : null,
    );
  }
}
