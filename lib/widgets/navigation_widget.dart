import 'package:flutter/material.dart';
import 'package:news/constant/font.dart';

class NavigationWidget extends StatelessWidget {
  const NavigationWidget({
    Key key,
    @required this.text,
  }) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: <Widget>[
          SizedBox(
            width: 30,
            child: Container(
              color: Colors.red,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 20),
            child: Text('$text',
                style: KfontConstant.LoginPageTitleNavigationStyle),
          )
        ],
      ),
      height: 30,
    );
  }
}
