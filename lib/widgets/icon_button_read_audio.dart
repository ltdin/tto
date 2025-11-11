import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:news/base/app_helpers.dart';
import 'package:news/constant/color.dart';
import 'package:news/constant/font.dart';

class IconButtonReadAudio extends StatefulWidget {
  const IconButtonReadAudio({
    Key key,
    this.url,
    this.subject,
    this.onTap,
  }) : super(key: key);

  final String url;
  final String subject;
  final ValueChanged<bool> onTap;

  @override
  State<IconButtonReadAudio> createState() => _IconButtonReadAudioState();
}

class _IconButtonReadAudioState extends State<IconButtonReadAudio> {
  bool _stateColor = false;

  @override
  Widget build(BuildContext context) {
    printDebug('Build : IconButtonReadAudio');
    return IconButton(
      icon: SvgPicture.asset(
        'assets/icons/icon_read_news.svg',
        color: _stateColor ? PRIMARY_COLOR : KfontConstant.recommendFontColor,
      ),
      onPressed: () {
        setState(() {
          _stateColor = !_stateColor;
        });
        widget.onTap != null ? widget.onTap.call(_stateColor) : null;
      },
    );
  }
}
