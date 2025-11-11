import 'package:flutter/material.dart';

// ignore: must_be_immutable
class NavigationDetailWidget extends StatelessWidget {
  final ValueChanged<int> changeFontSize;
  int currentFontSize = 16;

  NavigationDetailWidget({Key key, this.changeFontSize}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: new IconButton(
              icon: new Icon(
                Icons.arrow_back_ios,
                color: Colors.black,
              ),
              onPressed: () {
                Navigator.of(context).pop(true);
              },
            ),
          ),
          Expanded(flex: 7, child: Container()),
          Expanded(
            flex: 2,
            child: Container(
              //color: Colors.white,
              child: Row(
                children: <Widget>[
                  new SizedBox(
                      //height: 30.0,
                      width: 40.0,
                      child: new IconButton(
                        alignment: Alignment.center,
                        padding: new EdgeInsets.only(left: 5, right: 5),
                        icon: Image.asset('assets/icons/ic_format_font_1.png'),
                        onPressed: () {
                          changeFontSize(currentFontSize--);
                        },
                      )),
                  new SizedBox(
                      //height: 30.0,
                      width: 25.0,
                      child: new IconButton(
                        alignment: Alignment.center,
                        padding: new EdgeInsets.only(right: 5),
                        icon: Image.asset('assets/icons/ic_format_font_2.png'),
                        onPressed: () {
                          changeFontSize(currentFontSize++);
                        },
                      )),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
