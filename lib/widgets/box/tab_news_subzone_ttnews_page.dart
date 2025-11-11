import 'package:flutter/material.dart';
import 'package:news/constant/font.dart';
import 'package:news/constant/length.dart';
import 'package:news/constant/string.dart';
import 'package:news/models/article_model.dart';
import 'package:news/models/zone_data.dart';
import 'package:news/pages/detail/page_detail_webview_custom_tab.dart';
import 'package:news/widgets/large_news/large_news_type_5.dart';
import 'package:news/widgets/button_outlined_custom.dart';
import 'package:news/widgets/small_news/generate_small_list_type_1.dart';

class TabNewsSubZoneTTNewsPage extends StatelessWidget {
  const TabNewsSubZoneTTNewsPage({Key key, @required this.zoneData})
      : super(key: key);

  final ZoneData zoneData;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // LargeNews
        LargeNewsType5(
          article: zoneData.datas.first,
          isNotSapo: true,
          OnTap: _onOpenTTNews,
        ),

        // List small news
        GenerateSmallListType1(
          articles: zoneData.datas.sublist(1),
          indexSolidDivider: zoneData.datas.length + 1,
          OnTapItem: _onOpenTTNews,
        ),

        // Button
        ButtonOutlinedCustom(
          margin: EdgeInsets.only(top: paddingNews),
          content: Text(
            KString.STR_SEE_MORE,
            style: KfontConstant.styleOfSeeMoreSubZone,
          ),
          onClick: () =>
              PageDetailWebviewCustomTab.launch(url: 'https://tuoitrenews.vn'),
        )
      ],
    );
  }

  void _onOpenTTNews(Article article) {
    PageDetailWebviewCustomTab.launch(url: article.getTtoUrl);
  }
}
