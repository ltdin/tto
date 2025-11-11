import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:news/constant/color.dart';

class AppLoadingAnimation extends StatelessWidget {
  const AppLoadingAnimation({Key key, this.colorIndicator = PRIMARY_COLOR})
      : super(key: key);

  final Color colorIndicator;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: LoadingAnimationWidget.hexagonDots(
        color: colorIndicator.withOpacity(0.23),
        size: 80,
      ),
    );
  }
}
