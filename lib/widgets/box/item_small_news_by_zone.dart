import 'package:flutter/material.dart';
import 'package:news/constant/color.dart';
import 'package:news/constant/length.dart';
import 'package:news/models/news_by_zone.dart';
import 'package:news/widgets/box/title_zone.dart';
import 'package:news/widgets/small_news/generate_small_title.dart';
import 'package:news/widgets/small_news/small_news_type_1.dart';

class ItemSmallNewsByZone extends StatelessWidget {
  const ItemSmallNewsByZone({
    Key key,
    @required this.newsByZones,
  }) : super(key: key);

  final NewsByZone newsByZones;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(paddingNews),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title zone
          TitleZone(zoneName: newsByZones.zone.name),

          if (newsByZones.data.isNotEmpty ?? false) ...[
            // Large news
            SmallNewsType1(
              isShowDivider: true,
              isSolidDivider: true,
              article: newsByZones.data.first,
            ),

            // List horizontal news
            GenerateSmallTitle(
              articles: newsByZones.data.sublist(1),
              subtractDivider: (paddingNews * 2) + 2.0,
            ),
          ]
        ],
      ),
      decoration: BoxDecoration(
        color: cardNewsBackgroundColor,
        border: Border.all(color: cardNewsBorderColor),
        borderRadius: BorderRadius.circular(radius8),
      ),
    );
  }
}
