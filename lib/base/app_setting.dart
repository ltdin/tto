import 'package:flutter/cupertino.dart';
import 'package:news/base/app_cache.dart';
import 'package:news/blocs/auth_bloc.dart';
import 'package:news/constant/string.dart';
import 'package:news/models/globals.dart' as globals;
import 'package:news/models/setting.dart';

class AppSetting {
  Future<void> syncSetting(BuildContext context) async {
    final setting = await authBloc.getSetting();

    if (setting != null) {
      globals.appSetting = setting;
      AppCache.save(
        key: KString.CACHE_SETTING_APP,
        jsonModel: setting.toJson(),
      );
    } else {
      globals.appSetting = await _getSettingFromCache();
    }
  }

  Future<void> updateSetting(String idNews) async {
    await authBloc.updateSetting(idNews);
  }

  Future<Setting> _getSettingFromCache() async {
    final Map<String, dynamic> maps =
        await AppCache.load(KString.CACHE_SETTING_APP);
    return Setting.fromJson(maps);
  }
}
