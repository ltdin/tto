// import 'dart:io';

// import 'package:firebase_analytics/firebase_analytics.dart';
// import 'package:flutter/cupertino.dart';

// class AppAnalytics {
//   // Analytics
//   static final FirebaseAnalytics analytics = FirebaseAnalytics.instance;

//   // Current screen
//   static String currentScreen;

//   // Value
//   static const SETTING_SCREEN = 'setting_screen';
//   static const DETAIL_SCREEN = 'detail_screen';

//   static Future<void> setWPNMessageIdAndroid({String id}) async {
//     try {
//       if (Platform.isAndroid)
//         await analytics.setUserProperty(name: 'wpn_message_id', value: id);
//     } finally {}
//   }

//   static Future<void> sendWPNPushAndroid({String wpnMessageId}) async {
//     if (Platform.isAndroid) {
//       try {
//         await analytics.setUserProperty(
//           name: 'wpn_message_id',
//           value: wpnMessageId,
//         );
//       } on Exception catch (_, e) {
//         print('erroe $e');
//       } finally {}
//     }
//   }

//   static Future<void> sendPageview({
//     @required String screen,
//     String screenClassOverride,
//     bool saveScreen = false,
//   }) async {
//     if (saveScreen) {
//       currentScreen = screen;
//     }

//     await analytics.setCurrentScreen(
//       screenName: screen,
//       screenClassOverride: screenClassOverride ?? screen,
//     );
//   }

//   static Future<void> sendLogin([String loginType]) async {
//     await analytics.logLogin(loginMethod: loginType ?? 'wpn-api');
//   }
// }
