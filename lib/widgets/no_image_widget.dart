import 'package:flutter/material.dart';
import 'package:news/constant/color.dart';
import 'package:news/models/globals.dart' as globals;

class NoImageWidget extends StatelessWidget {
  const NoImageWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(3.0),
        color: CL_BACKGROUND_ITEM,
      ),
      child: Image.asset(globals.getWhiteLogoTTO),
    );
  }
}
