import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:news/constant/color.dart';
import 'package:news/constant/font.dart';
import 'package:news/constant/length.dart';

class HeaderBoxSSO extends StatelessWidget {
  const HeaderBoxSSO({Key key, this.topic, this.inmageAsset}) : super(key: key);

  final String topic;
  final String inmageAsset;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: paddingNews),
      child: ColoredBox(
        color: voteBackgroundColor,
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: paddingNews),
              child: SvgPicture.asset(inmageAsset, width: 25, height: 25),
            ),

            // Title topic
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(
                    vertical: paddingNews, horizontal: 8.0),
                child: Text(
                  topic,
                  textAlign: TextAlign.start,
                  style: KfontConstant.styleOfTitleSmallType1,
                  maxLines: 2,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
