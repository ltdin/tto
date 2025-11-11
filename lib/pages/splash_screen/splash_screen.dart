import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/base/app_cache.dart';
import 'package:news/base/app_helpers.dart';
import 'package:news/base/app_setting.dart';
import 'package:news/blocs/auth_bloc.dart';
import 'package:news/blocs/user_bloc.dart';
import 'package:news/constant/string.dart';
import 'package:news/models/globals.dart' as globals;
import 'package:flutter/material.dart';
import 'package:news/pages/recently_read/bloc/recently_read_bloc.dart';
import 'package:news/pages/run/app_bloc.dart';
import 'package:news/pages/settings/bloc/setting_bloc.dart';

class SplashScreen extends StatefulWidget {
  @override
  SplashScreenState createState() => new SplashScreenState();
}

class SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  AnimationController animationController;
  Animation<double> animation;

  @override
  void initState() {
    super.initState();

    // Animation
    animationController =
        AnimationController(duration: Duration(seconds: 1), vsync: this);
    animation =
        new CurvedAnimation(parent: animationController, curve: Curves.easeOut);
    animationController.forward();

    // Move to App
    _start();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(16),
        constraints: BoxConstraints.expand(),
        child: Image.asset(
          'assets/images/tto_default_logo.png',
          scale: 2.0,
        ),
      ),
    );
  }

  void _start() async {
    // Check user logged in
    await _checkSignIn();

    // Sync setting in app
    await AppSetting().syncSetting(context);

    _navigationPage();
  }

  Future<void> _checkSignIn() async {
    try {
      // Get isLoggedIn flag
      globals.isLoggedIn = await AppCache().isLoggedIn;

      // Get jwtToken flag
      userBloc.jwtToken = await AppCache().jwtToken;

      if (globals.isLoggedIn) {
        // Load user info
        await userBloc.loadUserInfoFromCache();

        // Get isTTStar from cache
        globals.isTTStar = await AppCache().isTTStar;

        // Sure is TTStar ?
        if (globals.isTTStar) {
          if (userBloc.userInfo.isSSOAccount) {
            authBloc.getUpdateUserInfo();
          } else {
            _updateSSOAccount(false);
          }
        } else {
          final isCall = await authBloc.getUpdateUserInfo();
          if (isCall && userBloc.userInfo.isSSOAccount) {
            _updateSSOAccount(true);
          }
        }

        // Get token
        userBloc.token = await AppCache().token;
      }
    } catch (e) {
      printDebug("checkSignIn: ${e.toString()}");
    }
  }

  void _updateSSOAccount(bool flag) {
    globals.isTTStar = flag;
    AppCache().isTTStar = flag;

    // Change theme
    Future.delayed(Duration(milliseconds: 500), () {
      BlocProvider.of<SettingBloc>(context).add(
        UpdateThemeSettingEvent(themeName: flag ? TTS_THEME : LIGHT_THEME),
      );
    });
  }

  void _navigationPage() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => BlocProvider<RecentlyReadBloc>(
          create: (context) => RecentlyReadBloc(),
          child: AppBloc(),
        ),
        settings: RouteSettings(name: '/app_bloc'),
      ),
    );
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }
}
