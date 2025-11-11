import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:news/constant/color.dart';
import 'package:news/models/tto_bottom_tabbar_model.dart';
import 'package:news/widgets/tto_bottom_appbar_item.dart';

class TabItem extends StatelessWidget {
  const TabItem({
    Key key,
    @required this.selectedIndex,
    @required this.widget,
    @required this.item,
    @required this.index,
    @required this.onPressed,
  }) : super(key: key);

  final int selectedIndex;
  final TTOBottomTabbar widget;
  final TTOBottomTabbarModel item;
  final int index;
  final ValueChanged<int> onPressed;

  @override
  Widget build(BuildContext context) {
    final Color color =
        selectedIndex == index ? widget.selectedColor : tabBarTextLabelColor;

    return Expanded(
      child: SizedBox(
        height: widget.height,
        child: Material(
          type: MaterialType.transparency,
          child: InkWell(
            onTap: () => onPressed(index),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: widget.iconSize,
                  child: SvgPicture.asset(item.strImage, color: color),
                ),
                Text(item.text, style: TextStyle(color: color, fontSize: 10)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
