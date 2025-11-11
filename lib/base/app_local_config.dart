import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:package_info/package_info.dart';

class AppLocalConfig {
  // Runtime device info
  static PackageInfo _packageInfo;

  // Init the app settings
  static Future<void> init([BuildContext context]) async {
    // Set default behavior for Equatable
    EquatableConfig.stringify = true;

    // Package info
    _packageInfo = await PackageInfo.fromPlatform();

    // Symbol data local
    await initializeDateFormatting('en_US');
  }

  /// Get current version
  static int get currentVersion => int.tryParse(
        _packageInfo.version.trim().replaceAll(".", ""),
      );

  static String get strAppVersion => _packageInfo.version;

  static bool get isShowRatingApp {
    final DateTime before = DateTime.fromMillisecondsSinceEpoch(1640979000000);
    final DateTime now = DateTime.now();
    final dayDifference = now.difference(before).inDays;
    if (dayDifference >= 365) {
      return true;
    }
    return false;
  }
}
