class Setting {
  const Setting({
    this.appVersion = '487',
    this.showFunctionIos = '0',
    this.idNewsOpenWebview = '0',
    this.isOpenNewsInWebview = '0',
    this.isShowLogoNewYear = '0',
    this.isOpenAdmobInApp = '0',
    this.isShowDailyNewspaper = '0',
    this.isShowBannerBCM = '0',
  });

  final String appVersion;
  final String showFunctionIos;
  final String idNewsOpenWebview;
  final String isOpenNewsInWebview;
  final String isShowLogoNewYear;
  final String isOpenAdmobInApp;
  final String isShowDailyNewspaper;
  final String isShowBannerBCM;

  // Get
  bool get getFlagShowFunctionOnIos => showFunctionIos == '1' ? true : false;
  int get getAppVersion => int.tryParse(appVersion);
  bool get getFlagOpenNewsInWebview =>
      isOpenNewsInWebview == '1' ? true : false;
  bool get showLogoNewYear => isShowLogoNewYear == '1' ? true : false;
  bool get getIsOpenAdmobInApp => isOpenAdmobInApp == '1' ? true : false;
  bool get getIsShowDailyNewspaper =>
      isShowDailyNewspaper == '1' ? true : false;
  bool get getIsShowBannerBCM => isShowBannerBCM == '1' ? true : false;
  factory Setting.fromJson(Map<String, dynamic> json) {
    if (json == null) {
      return Setting();
    }

    return Setting(
      appVersion: json["app_version"] ?? '477',
      showFunctionIos: json["show_function_ios"] ?? '0',
      idNewsOpenWebview: json["idnews_open_webview"] ?? '0',
      isOpenNewsInWebview: json["open_news_in_webview"] ?? '0',
      isShowLogoNewYear: json["is_logo_new_year"] ?? '0',
      isOpenAdmobInApp: json["is_open_admob_in_app"] ?? '0',
      isShowDailyNewspaper: json["show_daily_newspaper"] ?? '0',
      isShowBannerBCM: json["show_banner_bcm"] ?? '0',
    );
  }

  Map<String, dynamic> toJson() => {
        "app_version": appVersion,
        "show_function_ios": showFunctionIos,
        "idnews_open_webview": idNewsOpenWebview,
        "open_news_in_webview": isOpenNewsInWebview,
        "is_logo_new_year": isShowLogoNewYear,
        "is_open_admob_in_app": isOpenAdmobInApp,
        "show_daily_newspaper": isShowDailyNewspaper,
        "show_banner_bcm": isShowBannerBCM,
      };
}
