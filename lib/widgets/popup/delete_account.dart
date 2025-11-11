import 'package:flutter/material.dart';
import 'package:news/constant/color.dart';
import 'package:news/widgets/button_elevated_custom.dart';
import 'package:news/widgets/button_outlined_custom.dart';
import 'package:news/models/globals.dart' as globals;

class DeleteAccount extends StatelessWidget {
  const DeleteAccount({Key key, this.onAccept}) : super(key: key);

  final VoidCallback onAccept;

  @override
  Widget build(BuildContext context) {
    final _color = globals.isTTStar ? PRIMARY_COLOR_TTS : PRIMARY_COLOR;

    return AlertDialog(
      titlePadding: EdgeInsets.zero,
      contentPadding: EdgeInsets.all(16.0),
      insetPadding: EdgeInsets.all(16.0),
      title: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: _color,
        title: Text('Xoá tài khoản'),
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
          Center(
            child: Text('Bạn có chắc chắn muốn xoá tài khoản này không ? '),
          ),
          IconButton(
            iconSize: 40,
            onPressed: () {},
            icon: Icon(
              Icons.error,
              color: PRIMARY_COLOR,
            ),
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
                text: "Có",
                color: _color,
                onTap: () {
                  if (onAccept != null) {
                    Navigator.pop(context);
                    onAccept.call();
                  }
                },
              ),
              ButtonOutlinedCustom(
                width: 150,
                content: Text(
                  "Không",
                  style: TextStyle(color: tabBarTextLabelColor),
                ),
                onClick: () => Navigator.pop(context),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
