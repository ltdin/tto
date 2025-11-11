library news.globals;

import 'dart:io';
import 'package:news/models/setting.dart';


void Function(String tabName) onChangeTab;


bool isLoggedIn = false;
bool isTTStar = false;
Setting appSetting;
bool get isOpenAdmobInApp => appSetting?.getIsOpenAdmobInApp ?? false;
bool get isShowDailyNewspaper =>
    (appSetting.getIsShowDailyNewspaper ?? false) && isTTStar;
int numberRunLottieFile = 0;
bool IS_SHOW_DEBUG_RESPONSE = false;
bool get isShowAds => isOpenAdmobInApp && !isTTStar;
bool get isIntoTTStar => isLoggedIn && !isTTStar;
bool isShowFullFunction =
    (Platform.isAndroid || appSetting.getFlagShowFunctionOnIos);
String get getWhiteLogoTTO => appSetting.showLogoNewYear
    ? 'assets/images/tto_news_year_logo.png'
    : 'assets/images/logo-tto.png';
String get getWhiteLogoTTOSvg => appSetting.showLogoNewYear
    ? 'assets/images/tto_news_year_logo.svg'
    : 'assets/images/logo-tto.png';
bool get isShowBannerBCM => (appSetting.getIsShowBannerBCM ?? false);
