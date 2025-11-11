import 'package:flutter/material.dart';
import 'package:news/constant/enum.dart';
import 'package:news/constant/font.dart';
import 'package:news/constant/length.dart';
import 'package:news/constant/string.dart';
import 'package:news/models/article_model.dart';
import 'package:news/models/zone_model.dart';
import 'package:news/pages/detail/page_detail_webview_custom_tab.dart';
import 'package:news/widgets/large_news/generate_large_list_image.dart';
import 'package:news/widgets/button_outlined_custom.dart';
import 'package:news/widgets/tto_tabbar_widget.dart';

class BoxPicture extends StatefulWidget {
  const BoxPicture({
    Key key,
    @required this.boxNicePicture,
    @required this.boxMegastoryHot,
    @required this.boxInfographic,
  }) : super(key: key);

  final List<Article> boxNicePicture;
  final List<Article> boxMegastoryHot;
  final List<Article> boxInfographic;

  @override
  State<BoxPicture> createState() => _BoxPictureState();
}

class _BoxPictureState extends State<BoxPicture>
    with SingleTickerProviderStateMixin {
  List<String> _tabName = [];
  List<List<Article>> _listBox = [];
  TabController _tabController;
  int _tabIndex = 0;

  @override
  void initState() {
    //
    _listBox = [
      widget.boxNicePicture,
      widget.boxMegastoryHot,
      widget.boxInfographic,
    ];

    // Create tab name
    _createTabName();

    // Init controller
    _tabController = TabController(length: _tabName.length, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: paddingNews),
      margin: const EdgeInsets.symmetric(vertical: paddingNews),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Box title
          Padding(
            padding: const EdgeInsets.only(bottom: paddingNews),
            child: TTOTabBarWidget(
              indicatorWeight: 2.0,
              labelPadding: const EdgeInsets.only(right: 12),
              indicatorPadding: const EdgeInsets.only(right: 12),
              cates: List.generate(
                _tabName.length,
                (index) => ZoneList(name: _tabName[index]),
              ),
              controller: _tabController,
              selectedLabelStyle: KfontConstant.styleOfSelectedLabelTabBar,
              unselectedLabelStyle: KfontConstant.styleOfUnselectedLabelTabBar,
              onClickTab: _onClickTab,
            ),
          ),

          // List large image news
          GenerateLargeListImage(
            articles: _listBox.elementAt(_tabIndex),
            tabIndex: getTabIndex,
          ),

          // Button
          ButtonOutlinedCustom(
            margin: EdgeInsets.only(top: paddingNews),
            content: Text(
              KString.STR_SEE_MORE,
              style: KfontConstant.styleOfSeeMoreSubZone,
            ),
            onClick: () => _seeMoreTab(_tabIndex),
          )
        ],
      ),
    );
  }

  EnumBoxPicture get getTabIndex {
    switch (_tabIndex) {
      case 0:
        return EnumBoxPicture.IMAGE;
        break;

      case 1:
        return EnumBoxPicture.MEGASTORY;
        break;

      default:
        return EnumBoxPicture.INFOGRAPHIC;
    }
  }

  void _createTabName() {
    _listBox.asMap().forEach((index, list) => {
          if (list?.isNotEmpty ?? false)
            {
              _tabName.add(KString.boxPicture[index]),
            }
        });
  }

  void _onClickTab(int tabIndex) {
    setState(() {
      _tabIndex = tabIndex;
    });
  }

  void _seeMoreTab(int tabIndex) {
    switch (tabIndex) {
      case 0:
        PageDetailWebviewCustomTab.launch(url: 'https://tuoitre.vn/photo.htm');
        break;

      case 1:
        PageDetailWebviewCustomTab.launch(
          url: 'https://tuoitre.vn/megastory.htm',
        );
        break;

      default:
        PageDetailWebviewCustomTab.launch(
          url: 'https://tuoitre.vn/infographic.htm',
        );
    }
  }
}
