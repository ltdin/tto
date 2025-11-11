import 'package:flutter/material.dart';

class LogoYouthGroupWidget extends StatelessWidget {
  const LogoYouthGroupWidget({
    Key key,
    this.height = 40,
    this.scale = 1.0,
    this.assets = 'assets/images/logo_daily_newspaper.png',
  }) : super(key: key);

  final double height;
  final double scale;
  final String assets;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: Image.asset(assets, scale: scale),
    );
  }
}
