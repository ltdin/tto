import 'dart:async';

import 'package:flutter/material.dart';
import 'package:news/base/app_cache.dart';
import 'package:news/base/app_local_config.dart';

class AppInit {
  static Future<void> init([BuildContext context]) async {
    // Init shared preferences
    await AppCache.init();

    // Init package info
    await AppLocalConfig.init();
  }
}
