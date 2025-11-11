import 'package:flutter/material.dart';
import 'package:news/constant/font.dart';
import 'package:news/constant/length.dart';

class TitleZone extends StatelessWidget {
  const TitleZone({
    Key key,
    @required this.zoneName,
  }) : super(key: key);

  final String zoneName;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          margin: EdgeInsets.only(right: paddingNewsSapo),
          height: 15,
          width: 3,
          color: Colors.red,
        ),
        Text(
          zoneName,
          textAlign: TextAlign.start,
          style: KfontConstant.styleOfTitleBoxHighlightVideo,
        ),
      ],
    );
  }
}
