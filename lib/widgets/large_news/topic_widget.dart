import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:news/constant/font.dart';
import 'package:news/constant/length.dart';

class TopicWidget extends StatelessWidget {
  const TopicWidget({this.threadName});
  final String threadName;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SvgPicture.asset(
          'assets/icons/icon_topic.svg',
          width: 25,
          height: 25,
        ),
        Expanded(
          child: Padding(
            padding:
                EdgeInsets.symmetric(vertical: paddingNews, horizontal: 8.0),
            child: Text(
              threadName,
              textAlign: TextAlign.start,
              style: KfontConstant.styleOfTopicLargeType4,
              maxLines: 2,
            ),
          ),
        ),
      ],
    );
  }
}
