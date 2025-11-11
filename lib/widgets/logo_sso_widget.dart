import 'package:flutter/material.dart';

class LogoSSOWidget extends StatelessWidget {
  const LogoSSOWidget({Key key, this.height = 40, this.isLogoWhite = false})
      : super(key: key);

  final double height;
  final bool isLogoWhite;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: isLogoWhite
          ? Image.asset('assets/images/tto_star_small_white.png')
          : Image.asset('assets/images/tto_star_small.png'),
    );
  }
}
