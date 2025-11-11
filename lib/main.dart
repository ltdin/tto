import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:news/base/app_init.dart';
import 'package:news/base/app_theme.dart';
import 'package:news/pages/run/app_bloc_delegate.dart';
import 'package:news/pages/settings/bloc/setting_bloc.dart';
import 'pages/splash_screen/splash_screen.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

/// Initialize the [FlutterLocalNotificationsPlugin] package.
FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Init firebase
  await Firebase.initializeApp();

  // Init admod
  MobileAds.instance.initialize();

  // Set orientation
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    // Add new Bloc delegate for debugging bloc behaviors
    Bloc.observer = AppBlocDelegate();

    // Init the app settings and run the main app
    AppInit.init().then((dynamic value) => runApp(MyApp()));
  });
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeData _themeData;

  @override
  void initState() {
    _themeData = AppTheme().currentTheme;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SettingBloc>(
      create: (context) => SettingBloc(),
      child: BlocListener<SettingBloc, SettingState>(
        listener: (BuildContext context, SettingState state) {
          if (state is SettingThemeSuccess) {
            setState(() {
              _themeData = state.theme;
            });
          }
        },
        child: MaterialApp(
          title: 'Tuổi Trẻ Online',
          home: SplashScreen(),
          theme: _themeData,
          debugShowCheckedModeBanner: false,
          builder: (context, child) {
            return MediaQuery(
              child: child,
              data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
            );
          },
        ),
      ),
    );
  }
}
