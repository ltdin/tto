import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news/base/app_helpers.dart';
import 'package:news/constant/color.dart';
import 'package:news/constant/string.dart';
import 'package:news/widgets/button_elevated_custom.dart';
import 'package:news/widgets/button_outlined_custom.dart';
import 'package:news/models/globals.dart' as globals;

class RequestUpdate extends StatelessWidget {
  const RequestUpdate({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _color = globals.isTTStar ? PRIMARY_COLOR_TTS : PRIMARY_COLOR;

    final title = 'Cập nhật mới';
    final message =
        'Có một phiên bản mới hơn của ứng dụng có sẵn . Xin vui lòng cập nhật nó ngay bây giờ !';
    final String btnTextAccept = "Cập nhật";
    final String btnTextCancel = "Để sau";

    return Platform.isIOS
        ? CupertinoAlertDialog(
            title: Text(title),
            content: Text(message),
            actions: <Widget>[
              // Oke
              CupertinoDialogAction(
                  isDefaultAction: true,
                  child: Text(btnTextAccept),
                  onPressed: () {
                    AppHelpers.closeContext(context);
                    AppHelpers.onOpenLink(url: KString.APP_STORE_URL);
                  }),

              // Close
              CupertinoDialogAction(
                isDestructiveAction: true,
                child: Text(btnTextCancel),
                onPressed: () => AppHelpers.closeContext(context),
              ),
            ],
          )
        : AlertDialog(
            titlePadding: EdgeInsets.zero,
            contentPadding: EdgeInsets.all(16.0),
            insetPadding: EdgeInsets.all(16.0),
            title: AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: _color,
              title: Text(title),
              actions: [
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: Icon(Icons.clear, color: CL_WHITE),
                )
              ],
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(width: double.maxFinite),
                Center(child: Text(message)),
                IconButton(
                  iconSize: 40,
                  onPressed: () {},
                  icon: Icon(Icons.upgrade, color: SUCCESS_COLOR),
                )
              ],
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ButtonElevatedCustom(
                      width: 150,
                      text: btnTextAccept,
                      color: _color,
                      onTap: () {
                        Navigator.pop(context);
                        AppHelpers.onOpenLink(url: KString.PLAY_STORE_URL);
                      },
                    ),
                    ButtonOutlinedCustom(
                      width: 150,
                      content: Text(
                        btnTextCancel,
                        style: TextStyle(color: tabBarTextLabelColor),
                      ),
                      onClick: () => AppHelpers.closeContext(context),
                    ),
                  ],
                ),
              ),
            ],
          );
  }
}
