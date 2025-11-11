import 'package:flutter/material.dart';

class ScreenUtil {
  static ScreenUtil instance = new ScreenUtil();

  ///Design size of the device design modification
  int _designWidth;
  int _designHeight;

  static MediaQueryData _mediaQueryData;
  static double _screenWidth;
  static double _screenHeight;
  static double _pixelRatio;
  static double _statusBarHeight;

  static double _bottomBarHeight;

  static double _textScaleFactor;

  ScreenUtil({int width, int height}) {
    _designWidth = width;
    _designHeight = height;
  }

  static ScreenUtil getInstance() {
    return instance;
  }

  void init(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    _mediaQueryData = mediaQuery;
    _pixelRatio = mediaQuery.devicePixelRatio;
    _screenWidth = mediaQuery.size.width;
    _screenHeight = mediaQuery.size.height;
    _statusBarHeight = mediaQuery.padding.top;
    _bottomBarHeight = _mediaQueryData.padding.bottom;
    _textScaleFactor = mediaQuery.textScaleFactor;
  }

  static MediaQueryData get mediaQueryData => _mediaQueryData;

  ///The number of font pixels per logical pixel, the scaling of the font
  static double get textScaleFactory => _textScaleFactor;

  ///Device pixel density
  static double get pixelRatio => _pixelRatio;

  ///Current device width dp
  static double get screenWidthDp => _screenWidth;

  ///Current device height dp
  static double get screenHeightDp => _screenHeight;

  ///Current device width px
  static double get screenWidth => _screenWidth;

  ///Current device height px
  static double get screenHeight => _screenHeight;

  ///Status bar height Liu Haiping will be higher
  static double get statusBarHeight => _statusBarHeight;

  ///Bottom safe zone distance
  static double get bottomBarHeight => _bottomBarHeight;

  ///The ratio of the actual dp to the design draft px
  get scaleWidth => _screenWidth / instance._designWidth;

  get scaleHeight => _screenHeight / instance._designHeight;

  /// Adapted to the device width of the design draft
  ///The height is also adapted according to this to ensure no deformation.
  setWidth(int width) => width * scaleWidth;

  /// Adapted to the device width of the design draft
  ///The height is also adapted according to this to ensure no deformation.
  L(double width) => width * scaleWidth;

  /// Adapted to the height of the device according to the design draft
  /// When it is found that one screen in the design draft does not match the current style effect,
  /// or when there is a difference in shape, it is recommended to use this method for height adaptation.
  /// The height adaptation is mainly for the same effect that you want to display according to the one screen of the design draft.
  setHeight(int height) => height * scaleHeight;

  ///Font size adaptation method
  ///@param fontSize Pass the px of the font on the design draft,
  ///@param allowFontScaling Controls whether the font is scaled according to the system's "font size" accessibility option. The default is true.
  ///@param allowFontScaling Specify whether fonts should scale to respect Text Size accessibility settings. The default is true.
  setSp(int fontSize, [allowFontScaling = true]) => allowFontScaling
      ? setWidth(fontSize) * _textScaleFactor
      : setWidth(fontSize);
}
