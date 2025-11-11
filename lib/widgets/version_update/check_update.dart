import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:news/base/app_local_config.dart';
import 'package:news/base/app_helpers.dart';
import 'package:news/base/app_sqflite.dart';
import 'package:flutter/material.dart';
import 'package:news/models/globals.dart' as globals;
import 'package:news/widgets/popup/request_update.dart';

class CheckUpdate {
  void check(BuildContext context) {
    try {
      _versionCheck(context);
      _updateIsUpdateTrue();
    } catch (e) {
      printDebug('Catch CheckUpdate.check :  $e');
    }
  }

  void _versionCheck(context) async {
    try {
      // Get Current version
      final appVersion = AppLocalConfig.currentVersion;

      // Get version from server
      final serverVersion = globals.appSetting.getAppVersion;

      // Check emplty
      if (serverVersion == null || appVersion == null) {
        return;
      }

      // Check serverVersion and appVersion
      if (serverVersion > appVersion) {
        AppHelpers.showDialogForWidget(
          context,
          widget: RequestUpdate(),
        );
      }
    } on PlatformException catch (exception) {
      printDebug('Catch $exception');
    } catch (exception) {
      printDebug('Catch unable to fetch remote config.');
    }
  }

  void _updateIsUpdateTrue() {
    // Update column isUpdate = true
    AppSqflite.instance.updateAllIsUpdateTrue();
  }
}
