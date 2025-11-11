import 'package:flutter/material.dart';
import 'package:news/base/app_cache.dart';
import 'package:news/constant/color.dart';
import 'package:news/constant/string.dart';

class AppTheme {
  final _darkTheme = ThemeData.dark().copyWith(
    primaryColor: CL_WHITE,
    //
    appBarTheme: AppBarTheme(
      color: CL_PRIMARY_DARK,
      iconTheme: IconThemeData(color: CL_WHITE),
    ),
    //
    tabBarTheme: TabBarTheme(
      labelColor: CL_WHITE,
      unselectedLabelColor: tabBarTextLabelColor,
    ),
    //
    bottomAppBarTheme: BottomAppBarTheme(color: CL_PRIMARY_DARK, elevation: 10),
    scaffoldBackgroundColor: CL_SECONDARY_DARK,
    brightness: Brightness.dark,
    indicatorColor: CL_PRIMARY_DARK,
    iconTheme: IconThemeData(color: CL_WHITE),
    sliderTheme: SliderThemeData(
      activeTrackColor: CL_ACCENT_DARK,
      trackHeight: 3.0,
      tickMarkShape: RoundSliderTickMarkShape(tickMarkRadius: 4),
      activeTickMarkColor: CL_ACCENT_DARK,
      inactiveTickMarkColor: CL_ACCENT_DARK.withOpacity(0.99),
      thumbColor: CL_ACCENT_DARK,
      thumbShape: RoundSliderThumbShape(enabledThumbRadius: 8.0),
      overlayShape: RoundSliderOverlayShape(overlayRadius: 14.0),
    ),
    colorScheme: ColorScheme.fromSwatch().copyWith(secondary: CL_WHITE),
  );

  final _lightTheme = ThemeData.light().copyWith(
    primaryColor: PRIMARY_COLOR,

    //
    appBarTheme: AppBarTheme(
      color: CL_WHITE,
      iconTheme: IconThemeData(color: tabBarTextLabelColor),
    ),
    //
    tabBarTheme: TabBarTheme(
      labelColor: PRIMARY_COLOR,
      unselectedLabelColor: tabBarTextLabelColor,
    ),
    //
    bottomAppBarTheme: BottomAppBarTheme(color: CL_WHITE, elevation: 10),
    brightness: Brightness.light,
    indicatorColor: PRIMARY_COLOR,
    // iconTheme: IconThemeData(color: Colors.black87),
    sliderTheme: SliderThemeData(
      activeTrackColor: CL_ACCENT_LIGHT,
      trackHeight: 3.0,
      tickMarkShape: RoundSliderTickMarkShape(tickMarkRadius: 4),
      activeTickMarkColor: CL_ACCENT_LIGHT,
      inactiveTickMarkColor: CL_ACCENT_LIGHT.withOpacity(0.99),
      thumbColor: CL_ACCENT_LIGHT,
      thumbShape: RoundSliderThumbShape(enabledThumbRadius: 8.0),
      overlayShape: RoundSliderOverlayShape(overlayRadius: 18.0),
    ),
    colorScheme: ColorScheme.fromSwatch().copyWith(secondary: PRIMARY_COLOR),
  );

  final _ttsTheme = ThemeData.light().copyWith(
    primaryColor: PRIMARY_COLOR_TTS,

    //
    appBarTheme: AppBarTheme(
      color: CL_WHITE,
      iconTheme: IconThemeData(color: tabBarTextLabelColor),
    ),
    //
    tabBarTheme: TabBarTheme(
      labelColor: PRIMARY_COLOR_TTS,
      unselectedLabelColor: tabBarTextLabelColor,
    ),
    //
    bottomAppBarTheme: BottomAppBarTheme(color: CL_WHITE, elevation: 10),
    brightness: Brightness.light,
    indicatorColor: PRIMARY_COLOR_TTS,
    // iconTheme: IconThemeData(color: Colors.black87),
    sliderTheme: SliderThemeData(
      activeTrackColor: CL_ACCENT_LIGHT,
      trackHeight: 3.0,
      tickMarkShape: RoundSliderTickMarkShape(tickMarkRadius: 4),
      activeTickMarkColor: CL_ACCENT_LIGHT,
      inactiveTickMarkColor: CL_ACCENT_LIGHT.withOpacity(0.99),
      thumbColor: CL_ACCENT_LIGHT,
      thumbShape: RoundSliderThumbShape(enabledThumbRadius: 8.0),
      overlayShape: RoundSliderOverlayShape(overlayRadius: 18.0),
    ),
    colorScheme:
        ColorScheme.fromSwatch().copyWith(secondary: PRIMARY_COLOR_TTS),
  );

  ThemeData get currentTheme {
    final themeCurrent = AppCache().themeSetting;

    switch (themeCurrent) {
      case DART_THEME:
        return _darkTheme;

      case TTS_THEME:
        return _ttsTheme;

      default:
        return _lightTheme;
    }
  }

  String get currentThemeString => AppCache().themeSetting;
}
