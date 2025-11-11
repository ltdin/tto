import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart' hide NestedScrollView;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/base/app_helpers.dart';
import 'package:news/base/app_netcore.dart';
import 'package:news/constant/enum.dart';
import 'package:news/constant/number.dart';
import 'package:news/constant/string.dart';
import 'package:news/models/tto_bottom_tabbar_model.dart';
import 'package:news/pages/recently_read/bloc/recently_read_bloc.dart';
import 'package:news/pages/recently_read/recently_read_news_page.dart';
import 'package:news/pages/run/tab_page.dart';
import 'package:news/pages/search/search_page.dart';
import 'package:news/widgets/advertising/ad_helper.dart';
import 'package:news/widgets/tto_bottom_appbar_item.dart';
import 'package:news/widgets/version_update/check_update.dart';
import 'package:news/models/globals.dart' as globals;

class App extends StatefulWidget {
  const App({Key key}) : super(key: key);

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> with AfterLayoutMixin<App> {
  int _currentPage = 0;
  List<Widget> get _bottomBarWidgets =>
      [TabPage(), RecentlyReadPage(), Offstage()];

  @override
  Widget build(BuildContext context) {
    printDebug('---------------------- Build app -----------------------');
// Tin đã xem, Tìm kiếm, Trang nhất
    return Scaffold(
      body: _bottomBarWidgets[_currentPage],
      // bottomNavigationBar: SafeArea(
      //   child: TTOBottomTabbar(
      //     selectedColor: Theme.of(context).primaryColor,
      //     selectedIndex: _currentPage,
      //     notchedShape: CircularNotchedRectangle(),
      //     onTabSelected: _selectedTab,
      //     items: [
      //       TTOBottomTabbarModel(
      //         strImage: 'assets/icons/icon_home.svg',
      //         text: KString.strHome,
      //       ),
      //       TTOBottomTabbarModel(
      //         strImage: 'assets/icons/icon_notification.svg',
      //         text: KString.strRecentlyRead,
      //       ),
      //       TTOBottomTabbarModel(
      //         strImage: 'assets/icons/icon_search.svg',
      //         text: KString.searchHomeTitleNavigation,
      //       ),
      //     ],
      //   ),
      // ),
    );
  }

  void _selectedTab(int index) {
    if (index == SEARCH_TAB) {
      _moveToSearchPage();
      return;
    }

    setState(() {
      _currentPage = index;
    });

    // Check index and add tracking event
    switch (index) {
      case HOME_TAB:
        AppNetcore().addHomeEvent(
          pageName: KString.strHome,
          tabName: KString.HOME_PAGE,
        );
        break;

      case RECENTLY_READ_TAB:
        BlocProvider.of<RecentlyReadBloc>(context).add(GetRecentlyReadEvent());
        break;

      default:
        break;
    }
  }

  void _moveToSearchPage() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => SearchPage(),
      ),
    );
  }

  @override
  void afterFirstLayout(BuildContext context) {
    // Check version app
    CheckUpdate().check(context);

    // Load admod
    if (globals.isShowAds) {
      AdManager().createBannerAd(context, AdmodAdsType.BANNER320x250MID2);
    }
  }
}
