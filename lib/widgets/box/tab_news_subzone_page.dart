import 'package:flutter/material.dart';
import 'package:news/constant/font.dart';
import 'package:news/constant/length.dart';
import 'package:news/constant/string.dart';
import 'package:news/models/zone_data.dart';
import 'package:news/widgets/large_news/large_news_type_5.dart';
import 'package:news/widgets/button_outlined_custom.dart';
import 'package:news/widgets/small_news/generate_small_list_type_1.dart';

class TabNewsSubZonePage extends StatelessWidget {
  const TabNewsSubZonePage({
    Key key,
    @required this.zoneData,
    this.tabIndex,
    this.onSeeMore,
  }) : super(key: key);

  final ZoneData zoneData;
  final int tabIndex;
  final ValueChanged<int> onSeeMore;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // LargeNews
        LargeNewsType5(
          article: zoneData.datas.first,
          isNotSapo: true,
        ),

        // List small news
        GenerateSmallListType1(
          articles: zoneData.datas.sublist(1),
          indexSolidDivider: zoneData.datas.length + 1,
        ),

        // Button
        ButtonOutlinedCustom(
          margin: EdgeInsets.only(top: paddingNews),
          content: Text(
            KString.STR_SEE_MORE,
            style: KfontConstant.styleOfSeeMoreSubZone,
          ),
          onClick: () => onSeeMore != null ? onSeeMore.call(tabIndex) : null,
        )
      ],
    );
  }
}
