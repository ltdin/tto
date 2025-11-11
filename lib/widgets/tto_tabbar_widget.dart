import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:news/constant/font.dart';
import 'package:news/constant/string.dart';
import 'package:news/models/zone_model.dart';

class TTOTabBarWidget extends StatelessWidget {
  const TTOTabBarWidget({
    @required this.cates,
    this.controller,
    this.onClickTab,
    this.labelPadding = const EdgeInsets.symmetric(horizontal: 12),
    this.indicatorPadding = EdgeInsets.zero,
    this.indicatorWeight = 3.0,
    this.unselectedLabelStyle = KfontConstant.tabLabelStyle,
    this.selectedLabelStyle = KfontConstant.activeTabLabelStyle,
    this.labelColor,
    this.tabBarheight = kToolbarHeight,
  });

  final List<ZoneList> cates;
  final TabController controller;
  final ValueChanged<int> onClickTab;
  final EdgeInsets labelPadding;
  final EdgeInsets indicatorPadding;
  final double indicatorWeight;
  final double tabBarheight;
  final TextStyle unselectedLabelStyle;
  final TextStyle selectedLabelStyle;
  final Color labelColor;

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);

    return TabBar(
      controller: controller,
      indicatorSize: TabBarIndicatorSize.label,
      isScrollable: true,
      indicatorColor: themeData.primaryColor,
      labelColor: labelColor,
      indicatorWeight: indicatorWeight,
      labelStyle: selectedLabelStyle,
      unselectedLabelStyle: unselectedLabelStyle,
      labelPadding: labelPadding,
      indicatorPadding: indicatorPadding,
      tabs: cates
          .map(
            (cate) => (cate.name == KString.HOME_PAGE)
                ? Tab(
                    height: tabBarheight,
                    icon: SvgPicture.asset(
                      'assets/icons/icon_home_new.svg',
                      width: 24,
                      color: Theme.of(context).primaryColor,
                    ),
                  )
                : Tab(height: tabBarheight, text: cate.name.toUpperCase()),
          )
          .toList(),
      onTap: onClickTab,
    );
  }
}
