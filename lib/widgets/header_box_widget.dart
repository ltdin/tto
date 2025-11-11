import 'package:flutter/material.dart';
import 'package:news/constant/length.dart';

class HeaderBoxWidget extends StatelessWidget {
  const HeaderBoxWidget({
    Key key,
    @required this.title,
    this.backgroundColor,
    this.isTrailing = false,
    this.marginTop = 10,
    this.paddingTitle = const EdgeInsets.only(left: paddingNews),
    this.titleStyle = const TextStyle(
      fontSize: 20,
      color: Color(0xFFE02020),
    ),
  }) : super(key: key);

  final String title;
  final Color backgroundColor;
  final bool isTrailing;
  final TextStyle titleStyle;
  final double marginTop;
  final EdgeInsets paddingTitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: this.backgroundColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: paddingTitle,
            child: Text(this.title ?? '', style: titleStyle),
          ),
          this.isTrailing
              ? new Icon(
                  Icons.keyboard_arrow_right,
                  color: Theme.of(context).primaryColor,
                  size: 35,
                )
              : Offstage(),
        ],
      ),
    );
  }
}
