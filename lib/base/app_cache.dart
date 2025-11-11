import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:news/base/app_helpers.dart';
import 'package:news/constant/string.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppCache {
  static SharedPreferences _sharedPreferences;

  static Future<void> init() async {
    _sharedPreferences ??= await SharedPreferences.getInstance();
  }

  bool isValid(List<String> cacheValueEntry) {
    try {
      if (cacheValueEntry != null &&
          cacheValueEntry.isNotEmpty &&
          cacheValueEntry.length == 2) {
        int expiryTimestamp = int.parse(cacheValueEntry[0]);
        return (expiryTimestamp >= DateTime.now().millisecondsSinceEpoch);
      }
    } catch (e) {
      printDebug(e.toString());
    }
    return false;
  }

  void setKey(
      {@required String key, @required String value, int expireOn = -1}) {
    List<String> cacheValueEntry = [expireOn.toString(), value];

    _sharedPreferences.setStringList(key, cacheValueEntry);
  }

  String getKey({@required String key}) {
    List<String> cacheValueEntry = _sharedPreferences.getStringList(key);
    if (isValid(cacheValueEntry)) {
      return cacheValueEntry[1];
    }

    return null;
  }

  void removeKey({@required String key}) {
    _sharedPreferences.remove(key);
  }

  void purgeCache() {
    Set<String> keys = _sharedPreferences.getKeys();
    for (String key in keys) {
      if (getKey(key: key) == null) {
        _sharedPreferences.remove(key);
      }
    }
  }

  void clearCache() {
    _sharedPreferences.clear();
  }

  // FUNCTION GET KEY

  /// App theme setting
  String get themeSetting =>
      _sharedPreferences?.getString(THEME_SETTING) ?? LIGHT_THEME;
  set themeSetting(String value) =>
      _sharedPreferences?.setString(THEME_SETTING, value);

  /// Text size setting
  int get textSize => _sharedPreferences?.getInt(TEXT_ZOOM) ?? 14;
  set textSize(int value) => _sharedPreferences?.setInt(TEXT_ZOOM, value);

  /// Ads interstitials
  int get adsInterstitialsTime =>
      _sharedPreferences?.getInt(ADS_INTERSTITIALS_TIME);
  set adsInterstitialsTime(int value) =>
      _sharedPreferences?.setInt(ADS_INTERSTITIALS_TIME, value);

  /// Difference hour
  int get getDifferenceInHours {
    return DateTime.now()
        .difference(DateTime.fromMillisecondsSinceEpoch(adsInterstitialsTime))
        .inHours;
  }

  /// Avata
  String get avataUser => _sharedPreferences?.getString(AVATA_USER_BASE64);
  set avataUser(String value) =>
      _sharedPreferences?.setString(AVATA_USER_BASE64, value);

  /// State logged in
  bool get isLoggedIn => _sharedPreferences?.getBool(IS_LOGGED_IN) ?? false;
  set isLoggedIn(bool value) =>
      _sharedPreferences?.setBool(IS_LOGGED_IN, value);

  /// State TT Star
  bool get isTTStar => _sharedPreferences?.getBool(IS_TT_STAR) ?? false;
  set isTTStar(bool value) => _sharedPreferences?.setBool(IS_TT_STAR, value);

  /// Jwt token
  String get jwtToken =>
      _sharedPreferences?.getString(JWT_TOKEN) ?? KString.jwtTokenDefault;
  set jwtToken(String value) => _sharedPreferences?.setString(JWT_TOKEN, value);

  /// Token
  String get token =>
      _sharedPreferences?.getString(TOKEN) ?? KString.tokenDefault;
  set token(String value) => _sharedPreferences?.setString(TOKEN, value);

  static Future<bool> save({String key, Map<String, dynamic> jsonModel}) async {
    final jsonString = json.encode(jsonModel);
    return _sharedPreferences?.setString(key, jsonString);
  }

  static Future<Map<String, dynamic>> load(String key) async {
    if (!_sharedPreferences.containsKey(key)) {
      return null;
    }
    final jsonString = _sharedPreferences?.getString(key);
    return json.decode(jsonString);
  }

  static Future<bool> remove(String key) async {
    if (!_sharedPreferences.containsKey(key)) {
      return false;
    }
    return _sharedPreferences?.remove(key);
  }
}
