import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news/constant/color.dart';

class AppLoadingIndicator extends StatelessWidget {
  const AppLoadingIndicator({Key key, this.colorIndicator = PRIMARY_COLOR})
      : super(key: key);

  final Color colorIndicator;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: SizedBox(
          height: 16,
          width: 16,
          child: Platform.isIOS
              ? CupertinoActivityIndicator(color: colorIndicator)
              : Center(
                  child: CircularProgressIndicator(
                  strokeWidth: 1,
                  color: colorIndicator,
                )),
        ),
      ),
    );
  }
}
