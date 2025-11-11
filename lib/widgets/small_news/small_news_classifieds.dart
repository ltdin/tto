import 'package:flutter/material.dart';
import 'package:news/base/app_helpers.dart';
import 'package:news/constant/color.dart';
import 'package:news/constant/font.dart';
import 'package:news/constant/length.dart';
import 'package:news/models/classifieds.dart';
import 'package:news/widgets/divider_widget.dart';
import 'package:news/widgets/small_news/small_image_type_1.dart';

class SmallNewsClassiFieds extends StatelessWidget {
  const SmallNewsClassiFieds({
    Key key,
    @required this.classiFieds,
    this.isSolidDivider = false,
    this.isShowDivider = true,
    this.colorDivider,
  }) : super(key: key);

  final ClassiFieds classiFieds;
  final bool isSolidDivider;
  final bool isShowDivider;
  final Color colorDivider;

  @override
  Widget build(BuildContext context) {
    printDebug("Build classiFieds news : ${classiFieds.title}");

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Divider
        if (isShowDivider)
          DividerWidget(
            isSolid: isSolidDivider,
            color: colorDivider,
            subtract: (paddingDivider * 4) + 2.0,
          ),

        //
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // Title + price
            Expanded(
              flex: 6,
              child: Padding(
                padding: const EdgeInsets.only(right: paddingNewsTitle),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      classiFieds.getTitle,
                      style: KfontConstant.styleOfTitleSmallType1,
                      maxLines: 4,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      classiFieds.getPrice,
                      style: KfontConstant.styleOfTitleSmallType1
                          .copyWith(color: PRIMARY_COLOR),
                    ),
                  ],
                ),
              ),
            ),

            // Image
            Expanded(
              flex: 4,
              child: SmallImageType1(
                height: heightSmallImage120,
                urlImage: classiFieds.thumb,
              ),
            ),
          ],
        )
      ],
    );
  }
}
