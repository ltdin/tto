import 'package:flutter/material.dart';

class ImageAsset extends StatelessWidget {
  const ImageAsset({
    this.imageAsset,
    this.onTap,
    this.width,
    this.height,
  });

  final String imageAsset;
  final double width;
  final double height;

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Image.asset(imageAsset, width: width, height: height),
      onTap: () => onTap != null ? onTap.call() : null,
    );
  }
}
