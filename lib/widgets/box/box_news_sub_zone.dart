import 'package:flutter/material.dart';
import 'package:news/constant/font.dart';
import 'package:news/constant/length.dart';
import 'package:news/constant/string.dart';
import 'package:news/models/tto_news.dart';
import 'package:news/models/zone_data.dart';
import 'package:news/pages/detail/page_detail_webview_custom_tab.dart';
import 'package:news/widgets/box/tab_news_subzone_page.dart';
import 'package:news/widgets/tto_tabbar_widget.dart';

class BoxNewsSubZone extends StatefulWidget {
  const BoxNewsSubZone({
    Key key,
    @required this.boxNewsSubZone,
    this.ttNews,
  }) : super(key: key);

  final List<ZoneData> boxNewsSubZone;
  final List<TtoNews> ttNews;

  @override
  State<BoxNewsSubZone> createState() => _BoxNewsSubZoneState();
}

class _BoxNewsSubZoneState extends State<BoxNewsSubZone>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  int _tabIndex = 0;

  @override
  void initState() {
    _tabController =
        TabController(length: widget.boxNewsSubZone.length, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Box title
        Padding(
          padding: const EdgeInsets.only(bottom: paddingNews),
          child: TTOTabBarWidget(
            indicatorWeight: 2.0,
            labelColor: KfontConstant.titleFontColor,
            labelPadding: const EdgeInsets.only(right: 12),
            indicatorPadding: const EdgeInsets.only(right: 12),
            cates: List.generate(
              widget.boxNewsSubZone.length,
              (index) => widget.boxNewsSubZone[index].zone,
            ),
            controller: _tabController,
            selectedLabelStyle: KfontConstant.styleOfSelectedLabelTabBar,
            unselectedLabelStyle: KfontConstant.styleOfUnselectedLabelTabBar,
            onClickTab: _onClickTab,
          ),
        ),

        TabNewsSubZonePage(
          zoneData: widget.boxNewsSubZone[_tabIndex],
          tabIndex: _tabIndex,
          onSeeMore: _onSeeMore,
        ),

        // Content
        // if (_tabIndex == 2) ...{
        //   TabNewsSubZoneTTNewsPage(
        //     zoneData: widget.boxNewsSubZone[_tabIndex].copyWith(
        //       datas: List.generate(widget.ttNews.length,
        //           (index) => widget.ttNews[index].toArticle()).toList(),
        //     ),
        //   ),
        // } else ...{
        //   TabNewsSubZonePage(
        //     zoneData: widget.boxNewsSubZone[_tabIndex],
        //     tabIndex: _tabIndex,
        //     onSeeMore: _onSeeMore,
        //   ),
        // }
      ],
    );
  }

  void _onClickTab(int tabIndex) {
    setState(() {
      _tabIndex = tabIndex;
    });
  }

  void _onSeeMore(int index) {
    String _url = '';

    switch (index) {
      case 0:
        _url = KString.CUOI_URL;

        break;

      case 1:
        _url = KString.CUOI_TUAN_URL;
        break;

      case 2:
        _url = KString.TT_NEWS_URL;
        break;

      case 3:
        _url = KString.TT_MUCTIM_URL;
        break;
    }

    //
    PageDetailWebviewCustomTab.launch(url: _url);
  }
}
