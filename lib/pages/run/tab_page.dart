import 'dart:io';

import 'package:extended_nested_scroll_view/extended_nested_scroll_view.dart';
import 'package:flutter/material.dart' hide NestedScrollView;
import 'package:news/ads/ad_banner_123.dart';
import 'package:news/base/app_helpers.dart';
import 'package:news/constant/length.dart';
import 'package:news/constant/number.dart';
import 'package:news/models/globals.dart' as globals;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:news/constant/string.dart';
import 'package:news/models/zone_model.dart';
import 'package:news/pages/category/tab_category_page.dart';
import 'package:news/pages/detail/page_detail_webview_custom_tab.dart';
import 'package:news/pages/home/home_page.dart';
import 'package:news/pages/latest/latest_page.dart';
import 'package:news/pages/podcast/podcast_page.dart';
import 'package:news/pages/recommend/recommend_page.dart';
import 'package:news/pages/settings/bloc/setting_bloc.dart';
import 'package:news/pages/stars/stars_page.dart';
import 'package:news/pages/user/auth_page.dart';
import 'package:news/pages/user/tto_infomation_user_page.dart';
import 'package:news/pages/video/videos_tvo_page.dart';
import 'package:news/widgets/logo_logged_in.dart';
import 'package:news/widgets/logo_sso_widget.dart';
import 'package:news/widgets/logo_tto_widget.dart';
import 'package:news/widgets/side_menu.dart';
import 'package:news/widgets/tto_tabbar_widget.dart';
import 'package:news/pages/category/bloc/tab_category_page_bloc.dart';

class TabPage extends StatefulWidget {
  @override
  _TabPageState createState() => _TabPageState();
}

class _TabPageState extends State<TabPage> with TickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final GlobalKey<AdBannerState> _adBannerKey = GlobalKey<AdBannerState>();
  List<ZoneList> _cates;
  TabController _tabcontroller;
  bool _isHideSilderTextSize = false;
  AnimationController _animationController;
  Animation<double> _animation;
  EdgeInsets _viewPadding;
  String addBanner = "jwsn1c2f";
  final List<String> _adBanners = ["jwsn1c2f", "jwsn2xfm"];
  List<AdBanner> _adsBanner ;
  // List<SimpleWebView>? _adWebViewPage;
  final List<String> _channels = ["/home/", "/media/", "/video/","/home/", "/media/", "/video/","/home/", "/media/", "/video/","/home/", "/media/", "/video/","/home/", "/media/", "/video/","/home/", "/media/", "/video/","/home/", "/media/", "/video/","/home/", "/media/", "/video/"];


  @override
  void initState() {
    // Init cates
    _cates = _initCates();
    _adsBanner = _initAdBanner();
    // Init tab controller
    _tabcontroller = TabController(length: _cates.length, vsync: this);

    // Animation
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _animation =
        CurvedAnimation(parent: _animationController, curve: Curves.easeIn);

//box podcast chuyển tag
    globals.onChangeTab = (String tabName) {
      final idx = _cates.indexWhere((e) => e.name == tabName);
      if (idx != -1) {
        Future.delayed(const Duration(milliseconds: 50), () {
          if (mounted) _tabcontroller.animateTo(idx);
        });
      }
    };
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    printDebug('---------------------- Build TabPage ----------------------');
    _viewPadding = MediaQuery.of(context).viewPadding;


    return Scaffold(
      key: _scaffoldKey,
      body: Stack(
        children: [
          LayoutBuilder(
              builder: (context, constraints){
              return NestedScrollView(
                headerSliverBuilder:
                    (BuildContext context, bool innerBoxIsScrolled) {
                  return <Widget>[
                    SliverOverlapAbsorber(
                      handle:
                          NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                      sliver: SliverSafeArea(
                        top: false,
                        bottom: Platform.isIOS ? false : true,
                        sliver: SliverAppBar(
                          centerTitle: true,
                          backgroundColor: Theme.of(context).indicatorColor,
                          automaticallyImplyLeading: false,
                          expandedHeight: (!globals.isTTStar && _cates[_tabcontroller.index].getAdmChannel != ""
                              ? (constraints.maxWidth * rateAdsTop)
                              : 0) + heightLogoTabPage + heightHeaderTabPage,
                          pinned: true,
                          forceElevated: innerBoxIsScrolled,
                          bottom: AppBar(
                            automaticallyImplyLeading: false,
                            elevation: 4,
                            toolbarHeight: kToolbarHeight - paddingNews,
                            flexibleSpace: TTOTabBarWidget(
                              tabBarheight: (kToolbarHeight - paddingNews),
                              cates: _cates,
                              controller: _tabcontroller,
                            ),
                          ),
                          flexibleSpace: Stack(
                            fit: StackFit.expand,
                            children: [
                              if (!globals.isTTStar &&
                                  _cates[_tabcontroller.index].getAdmChannel != "")
                                Container(
                                  margin:
                                  EdgeInsets.only(top: MediaQuery.of(context).padding.top),
                                  height: constraints.maxWidth * rateAdsTop,
                                  color: Colors.transparent,
                                  alignment: Alignment.topCenter,
                                  child: AdBanner(
                                      zone: "m8ws56d0", channel: "/home/", rate: rateAdsTop),
                                ),
                              Align(
                                alignment: Alignment.bottomCenter,
                                child: Container(
                                  color: Theme.of(context).indicatorColor,
                                  margin: EdgeInsets.only(
                                      bottom: heightHeaderTabPage,
                                      top: !globals.isTTStar &&
                                          _cates[_tabcontroller.index].getAdmChannel != ""
                                          ? MediaQuery.of(context).padding.top
                                          : 0),
                                  height: heightLogoTabPage,
                                  alignment: Alignment.center,
                                  child: Row(
                                    children: [
                                      IconButton(
                                        icon: Icon(Icons.menu),
                                        color: Colors.white,
                                        onPressed: () {
                                          _scaffoldKey.currentState.openDrawer();
                                        },
                                      ),
                                      // LOGO TTO hoặc TTS
                                      Expanded(
                                        child: GestureDetector(
                                          child: globals.isTTStar
                                              ? LogoSSOWidget(isLogoWhite: true)
                                              : LogoTTOWidget(
                                              assets: globals.getWhiteLogoTTOSvg,
                                              scale: 1.5),
                                          // onTap: () => _onTapLogo(),
                                          onTap: () {
                                            KString.HOME_PAGE; // Log analytics về Home
                                            _onTapLogo(); // Chuyển tab về Home
                                          },
                                        ),
                                      ),
                                      if (globals.isLoggedIn) ...{
                                        LogoLoggedIn(onTap: () => _openCloseAccountPage()),
                                      } else ...{
                                        IconButton(
                                          icon:
                                          SvgPicture.asset('assets/icons/icon_account.svg'),
                                          onPressed: () => _moveToLoginPage(),
                                        )
                                      },
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ];
                },
                innerScrollPositionKeyBuilder: () {
                  return Key('Tab${_tabcontroller.index}');
                },
                body: TabBarView(
                  controller: _tabcontroller,
                  children: _cates.asMap().entries.map((entry) {
                    return (entry.value.zoneId == -1)//mục sidemenu
                        ? getMainTab(entry.value.name)
                        : BlocProvider<TabCategoryPageBloc>(
                            create: (context) => TabCategoryPageBloc()
                              ..add(GetTabCategoryListEvent(zone: entry.value)),
                            child: TabCategoryPage(
                              tabKey: Key('Tab${entry.key}'),
                              zone: entry.value,
                            ),
                          );
                  }).toList(),
                ),
              );
            }
          ),
          // Show UI with animation
          SizeTransition(
            axisAlignment: 1.0,
            sizeFactor: _animation,
            child: Container(
              margin: EdgeInsets.only(top: _viewPadding.top + 60.0),
              child: TTOInfomationUserPage(
                callBackClose: () => _openCloseAccountPage(),
                callBackLogout: () {
                  _openCloseAccountPage();
                  _swichtLightTheme();
                },
                callBackIntoTTStar: () {
                  _openCloseAccountPage();
                  _swichtSSOTheme();
                },
              ),
            ),
          ),
        ],
      ),
      drawer: Drawer(
        child: SideMenu(onClickHeader: _onClickHeader),
      ),
    );
  }

  List<ZoneList> _initCates() {
    List<ZoneList> _catess = [];

    // Add main cate
    _catess.add(ZoneList(zoneId: -1, name: KString.HOME_PAGE,admChannel: "/home/"),);

    // if (!globals.isTTStar) {
    //   _cates.add(ZoneList(zoneId: -1, name: KString.TTS_PAGE));
    // }

    _catess.add(ZoneList(zoneId: -1, name: KString.LASTLEST_PAGE));
    _catess.add(ZoneList(zoneId: -1, name: KString.STR_RECOMMEND));
    _catess.add(ZoneList(zoneId: -1, name: KString.VIDEO_PAGE, admChannel: "/media/video/"));
    _catess.addAll(KString.cates);

    _catess.add(ZoneList(zoneId: -1, name: KString.STR_MANY_STARS_PAGE));

    _catess.add(ZoneList(zoneId: -1, name: KString.PODCAST_PAGE));
    // _cates.add(ZoneList(zoneId: -1, name: KString.TNDG_PAGE));
    // _cates.add(ZoneList(zoneId: -1, name: KString.THOI_TIET_PAGE));

    // return cates
    return _catess;
  }

  List<AdBanner> _initAdBanner(){//["jwsn1c2f", "jwsn2xfm"
    List<AdBanner> _adsBaner = [];
    _cates.asMap().forEach((index, list) => {
      _adsBaner.add(AdBanner(zone: list.zoneId == -1 ? "jwsn1c2f" : "jwsn2xfm", channel: "${list.getAdmChannel}", rate: 1,))
    });
    return _adsBaner;
  }

  Widget getMainTab(String name) {
    switch (name) {
      case KString.HOME_PAGE:
        return HomePage();
        break;

      case KString.TTS_PAGE:
        return Offstage();
        break;

      case KString.LASTLEST_PAGE:
        return LastestPage();
        break;

      case KString.STR_RECOMMEND:
        return RecommendPage();
        break;

      case KString.VIDEO_PAGE:
        return VideosTvoPage();
        break;

      //Sao nhiều
      case KString.STR_MANY_STARS_PAGE:
        return StarsPage();
        break;

      case KString.VIDEO_PAGE:
        return VideosTvoPage();
        break;

      default:
        return PodcastPage();
    }
  }

  void _onTapLogo() {
    Future.delayed(Duration(milliseconds: 5), () {//200
      _tabcontroller.animateTo(0);
    });
  }

  void _moveToLoginPage() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => AuthPage(
          callbackAfterLogin: () {
            setState(() {});

            // Update when is TTS
            if (globals.isTTStar) {
              _swichtSSOTheme();
            } else {
              _swichtLightTheme();
            }
          },
        ),
        settings: RouteSettings(name: '/app_bloc/login_page'),
      ),
    );
  }

  Future<void> _openCloseAccountPage() async {
    if (_isHideSilderTextSize) {
      _animationController.reverse();
    } else {
      _animationController.forward();
    }

    //
    setState(() {
      _isHideSilderTextSize = !_isHideSilderTextSize;
    });
  }

  void _swichtLightTheme() {
    Future.delayed(Duration(milliseconds: 500), () {
      BlocProvider.of<SettingBloc>(context).add(
        UpdateThemeSettingEvent(themeName: LIGHT_THEME),
      );
    });
  }

  void _swichtSSOTheme() {
    Future.delayed(Duration(milliseconds: 500), () {
      BlocProvider.of<SettingBloc>(context).add(
        UpdateThemeSettingEvent(themeName: TTS_THEME),
      );
    });
  }

  void _onClickHeader(int index) {
    printDebug(index.toString());

    switch (index) {
      case 0:
        Future.delayed(Duration(milliseconds: 200), () {
          _tabcontroller.animateTo(4 - subtractIndex);
        });
        break;

      case 18:
        break;

      case 19:
        PageDetailWebviewCustomTab.launch(
          url: KString.THOI_TIET_URL,
        );
        break;

      case 20:
        PageDetailWebviewCustomTab.launch(url: KString.TNDG_URL);
        break;

      case 21:
        PageDetailWebviewCustomTab.launch(
          url: KString.RAO_VAT_URL,
        );
        break;

      case 22:
        PageDetailWebviewCustomTab.launch(
          url: KString.TT_NEWS_URL,
        );
        break;

      case 23:
        PageDetailWebviewCustomTab.launch(
          url: KString.CUOI_TUAN_URL,
        );
        break;

      // case 24:
      //   Future.delayed(Duration(milliseconds: 200), () {
      //     _tabcontroller.animateTo(24 - subtractIndex);//22 NHẢY SANG THÒI TIẾT
      //   });
      //   break;// này trogn tag

      case 24:
        PageDetailWebviewCustomTab.launch(url: KString.PODCAST_URL);
        break;

      case 25:
        PageDetailWebviewCustomTab.launch(url: KString.TTSHOP_URL);
        break;

      case 26:
        PageDetailWebviewCustomTab.launch(url: KString.QUANG_CAO_URL);
        break;

      case 27:
        PageDetailWebviewCustomTab.launch(url: KString.DAT_BAO_URL);
        break;


      default:
        Future.delayed(Duration(milliseconds: 200), () {
          _tabcontroller.animateTo(4 + index - subtractIndex);
        });
    }
  }

  // Get
  int get subtractIndex => 1;

  @override
  void dispose() {
    _animationController.dispose();
    _tabcontroller.dispose();
    super.dispose();
  }
}
