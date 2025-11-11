import 'package:flutter/material.dart';
import 'package:news/base/app_cache.dart';
import 'package:news/base/app_helpers.dart';
import 'package:news/constant/bool.dart';
import 'package:news/constant/string.dart';
import 'package:news/util/text_style_util.dart';
import 'package:news/models/globals.dart' as globals;
import 'package:smartech_base/smartech_base.dart';

class TTOSettingsLogoutWidget extends StatelessWidget {
  const TTOSettingsLogoutWidget({Key key, this.callbackAfterLogout, this.text})
      : super(key: key);

  final String text;
  final VoidCallback callbackAfterLogout;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: GestureDetector(
        child: Text(
          text,
          style: TTOTextStyle.regular(color: Colors.red, fontSize: 16.0),
        ),
        onTap: () async {
          printDebug("__DEBUG__ logout");

          // Turn on loading
          AppHelpers.onLoading(context, true);

          // Logout for Netcore
          Smartech().logoutAndClearUserIdentity(true);

          // Update status login
          globals.isLoggedIn = FLAG_OFF;

          // Remove cache login key ( info of user )
          await Future.delayed(
              Duration(seconds: 1), () => AppCache.remove(TTO_USER_KEY));

          // Turn off loading
          AppHelpers.onLoading(context, false);

          // Update UI
          callbackAfterLogout.call();
        },
      ),
    );
  }
}
