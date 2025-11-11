import 'package:flutter/material.dart';
import 'package:news/constant/length.dart';
import 'package:news/models/news_by_zone.dart';
import 'package:news/models/zone_model.dart';
import 'package:news/pages/category/sub_category_page.dart';
import 'package:news/widgets/box/title_zone_list_sub_category.dart';
import 'package:news/widgets/large_news/large_news_type_5.dart';
import 'package:news/widgets/small_news/generate_small_title.dart';

class ItemLargeNewsByZone extends StatelessWidget {
  const ItemLargeNewsByZone({
    Key key,
    @required this.newsByZones,
  }) : super(key: key);

  final NewsByZone newsByZones;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Title zone + List sub category
        Padding(
          padding: const EdgeInsets.only(top: paddingNews + paddingNewsTitle),
          child: TitleZoneListSubCategory(
            subZones: newsByZones.subZones,
            zoneName: newsByZones.zone.name,
            onTapItemZone: (ZoneList zoneList) {
              _moveToSubCategoryPage(context, zoneList, newsByZones.zone.name);
            },
          ),
        ),

        if (newsByZones.data.isNotEmpty ?? false) ...[
          // Large news
          LargeNewsType5(
            isShowDivider: true,
            isSolid: true,
            article: newsByZones.data.first,
          ),

          // List horizontal news
          GenerateSmallTitle(
            articles: newsByZones.data.sublist(1),
            hasDividerAtBottom: true,
          ),
        ]
      ],
    );
  }

  void _moveToSubCategoryPage(
    BuildContext context,
    ZoneList zoneList,
    String parentCategory,
  ) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SubCategoryPage(
          zone: zoneList,
          parentCategory: parentCategory,
        ),
      ),
    );
  }
}
