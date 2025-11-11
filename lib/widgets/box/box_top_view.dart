import 'package:flutter/material.dart';
// import 'package:news/constant/enum.dart';
import 'package:news/constant/font.dart';
import 'package:news/constant/length.dart';
import 'package:news/constant/string.dart';
import 'package:news/models/article_model.dart';
import 'package:news/models/zone_model.dart';

import 'package:news/widgets/tto_tabbar_widget.dart';

import 'item_small_top_view.dart';

class BoxTopView extends StatefulWidget {
  const BoxTopView({
    Key key,
    @required this.boxTopView,
    @required this.boxTopStar,//code tao nè

  }) : super(key: key);

  final List<Article> boxTopView;
  final List<Article> boxTopStar;//code tao nè


  @override
  State<BoxTopView> createState() => _BoxTopViewState();//code tao nè

}
//code tao nè

class _BoxTopViewState extends State<BoxTopView>
    with SingleTickerProviderStateMixin {
  List<String> _tabName = [];
  List<List<Article>> _listBox = [];
  TabController _tabController;
  int _tabIndex = 0;

  @override
  void initState() {
    //
    _listBox = [
      widget.boxTopView,
      widget.boxTopStar,
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
              labelColor: KfontConstant.titleFontColor,
              labelPadding: const EdgeInsets.only(right: 12),
              indicatorPadding: const EdgeInsets.only(right: 50),
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
//code tao nè --->cái đoan này là goc

          Container(
            height: heightSmallNews310,
            width: double.maxFinite,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.zero,
              child: Row(
                children: List.generate(
                  _listBox.elementAt(_tabIndex).length,
                      (i) => Container(
                    width: widthSmallImage245,
                    margin: EdgeInsets.only(
                      right: i != _listBox.elementAt(_tabIndex).length - 1 ? paddingNews / 2 : 0.0,
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(5.0),
                      child: Container(
                        margin: const EdgeInsets.only(
                          bottom: 6.0,
                        ),
                        child: ItemSmallTopView(
                          article: _listBox.elementAt(_tabIndex)[i],
                          index: i + 1,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.0),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey,
                              offset: Offset(0.0, 1.0), //(x,y)
                              blurRadius: 6.0,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),


        ],
      ),
    );
  }

  void _createTabName() {
    _listBox.asMap().forEach((index, list) => {
      if (list?.isNotEmpty ?? false)
        {
          _tabName.add(KString.boxTopView[index]),
        }
    });
  }

  void _onClickTab(int tabIndex) {
    setState(() {
      _tabIndex = tabIndex;
    });
  }
}
