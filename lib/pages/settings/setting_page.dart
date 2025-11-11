import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:news/base/app_cache.dart';
import 'package:news/base/app_helpers.dart';
import 'package:news/base/app_theme.dart';
import 'package:news/blocs/auth_bloc.dart';
import 'package:news/constant/bool.dart';
import 'package:news/constant/string.dart';
import 'package:news/models/response_model.dart';
import 'package:news/pages/detail/widgets/show_range_text_size_native.dart';
import 'package:news/pages/settings/bloc/setting_bloc.dart';
import 'package:news/pages/settings/widgets/setting_widget.dart';
import 'package:news/widgets/appbar_for_tab.dart';
import 'package:news/widgets/icon_text_widget.dart';
import 'package:news/widgets/switch_widget.dart';
import 'package:news/models/globals.dart' as globals;
import 'package:smartech_base/smartech_base.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({Key key, this.callbackAfterDeleteAccount})
      : super(key: key);
  final VoidCallback callbackAfterDeleteAccount;

  @override
  Widget build(BuildContext context) {
    printDebug('=====================Build Setting Page=====================');

    final dividerWidget = Divider(height: 1, color: Colors.grey);
    final _themeData = Theme.of(context);
    final textThemeSubtitle = _themeData.textTheme.subtitle1.copyWith(
      fontWeight: FontWeight.normal,
    );
    final colorText = _themeData.primaryColor;
    final valueTheme = (AppTheme().currentThemeString == DART_THEME);

    return Scaffold(
      appBar: appBarWidget(title: KString.strSetting),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          if (Platform.isAndroid) ...[
            // Setting text size
            SettingWidget(
              child: IconTextWidget(
                icon: SvgPicture.asset(
                  'assets/icons/icon_setting_fontsize.svg',
                  color: _themeData.iconTheme.color,
                ),
                text: KString.strTextSize,
                textStyle: textThemeSubtitle,
                onPressed: () {
                  showDialog<bool>(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 24),
                        content: ShowRangeTextSizeNative(
                          textZoom: AppCache().textSize,
                          textStyle: Theme.of(context).textTheme.bodyText1,
                          setTextZoom: (int value) {},
                        ),
                      );
                    },
                  );
                },
              ),
            ),
            dividerWidget,
          ],

          ...[
            // Setting recive notification
            SettingWidget(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconTextWidget(
                    icon: SvgPicture.asset(
                      'assets/icons/icon_notification.svg',
                      color: _themeData.iconTheme.color,
                    ),
                    text: KString.strReciveNotification,
                    textStyle: textThemeSubtitle,
                  ),
                  Switch(
                    onChanged: (_) {
                      AppHelpers.showToast(text: KString.msgFunctionNotFinish);
                    },
                    value: true,
                    activeColor: colorText,
                    activeTrackColor: colorText.withOpacity(0.38),
                  ),
                ],
              ),
            ),
            dividerWidget,

            // Setting dark mode
            SettingWidget(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconTextWidget(
                    icon: SvgPicture.asset(
                      'assets/icons/icon_moon.svg',
                      color: _themeData.iconTheme.color,
                    ),
                    text: KString.strDarkMode,
                    textStyle: textThemeSubtitle,
                  ),
                  SwitchWidget(
                    colorSwitch: colorText,
                    switchControl: valueTheme,
                    onValueChanged: (bool value) {
                      BlocProvider.of<SettingBloc>(context).add(
                        UpdateThemeSettingEvent(
                          themeName: value ? DART_THEME : LIGHT_THEME,
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],

          dividerWidget,

          // Rate app
          SettingWidget(
            child: IconTextWidget(
              icon: SvgPicture.asset(
                'assets/icons/icon_star.svg',
                color: _themeData.iconTheme.color,
              ),
              text: KString.strRateApp,
              textStyle: textThemeSubtitle,
              onPressed: () {
                Platform.isIOS
                    ? AppHelpers.onOpenLink(url: KString.APP_STORE_URL)
                    : AppHelpers.onOpenLink(url: KString.PLAY_STORE_URL);
              },
            ),
          ),

          // Send mail for comment app
          if (Platform.isAndroid)
            SettingWidget(
              child: IconTextWidget(
                icon: SvgPicture.asset(
                  'assets/icons/icon_mail.svg',
                  color: _themeData.iconTheme.color,
                ),
                text: KString.strSentMail,
                textStyle: textThemeSubtitle,
                onPressed: () {
                  AppHelpers.launchMail('tuoitrenewsapp@gmail.com',
                      'THƯ GÓP Ý TỪ BẠN ĐỌC', 'Nội dung :   ');
                },
              ),
            ),

          // Contact ads
          SettingWidget(
            child: IconTextWidget(
              icon: SvgPicture.asset(
                'assets/icons/icon_money.svg',
                color: _themeData.iconTheme.color,
              ),
              text: KString.strContactAds,
              textStyle: textThemeSubtitle,
              onPressed: () {
                AppHelpers.callPhone(phone: KString.strNumberHotline);
              },
            ),
          ),

          // Delete account
          if (globals.isLoggedIn) ...[
            dividerWidget,
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: SettingWidget(
                child: IconTextWidget(
                  icon: Image.asset(
                    'assets/icons/ic_account_bottombar.png',
                    color: _themeData.iconTheme.color,
                    width: 20,
                    height: 20,
                  ),
                  text: KString.strDeleteAccount,
                  textStyle: textThemeSubtitle.copyWith(color: Colors.red),
                  onPressed: () {
                    // Turn on loading
                    AppHelpers.onLoading(context, true);

                    // Call delete account
                    authBloc.deleteAccount().then((data) async {
                      if (data.status == StatusRequest.SUCCESS) {
                        // Logout for Netcore
                        Smartech().logoutAndClearUserIdentity(true);

                        // Update status login
                        globals.isLoggedIn = FLAG_OFF;

                        // Remove cache login key ( info of user )
                        await Future.delayed(Duration(seconds: 10),
                            () => AppCache.remove(TTO_USER_KEY));

                        // Update UI
                        callbackAfterDeleteAccount.call();

                        // Message delete success
                        AppHelpers.showToast(
                          text: KString.msgDeleteAccountSuccess,
                          isError: false,
                        );
                      } else {
                        AppHelpers.showToast(
                            text: KString.msgDeleteAccountFaild, isError: true);
                      }

                      // Turn off loading
                      AppHelpers.onLoading(context, false);
                    });
                  },
                ),
              ),
            ),
          ]
        ],
      ),
    );
  }
}
