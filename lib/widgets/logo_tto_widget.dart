import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LogoTTOWidget extends StatelessWidget {
  const LogoTTOWidget({
    Key key,
    this.height = 40,
    this.scale = 1.0,
    this.assets = 'assets/images/tto_default_logo.png',
  }) : super(key: key);

  final double height;
  final double scale;
  final String assets;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: assets.endsWith('.svg')
          ? SvgPicture.asset(assets, width: 125)
          : Image.asset(assets, scale: scale),
    );
  }
}
