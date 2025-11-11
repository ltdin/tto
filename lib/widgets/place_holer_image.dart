import 'package:flutter/material.dart';
import 'package:news/constant/string.dart';

class PlaceHolerImage extends StatelessWidget {
  const PlaceHolerImage({
    Key key,
    this.onClickRetry,
  }) : super(key: key);

  final VoidCallback onClickRetry;

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme.subtitle1;
    return Container(
      constraints: BoxConstraints.expand(),
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            KString.msgNoData,
            style: textStyle,
          ),
        ],
      ),
    );
  }
}
