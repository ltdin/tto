import 'package:flutter/material.dart';
import 'package:news/constant/font.dart';

class appBarWidget extends StatelessWidget implements PreferredSizeWidget {
  const appBarWidget({
    Key key,
    this.title,
    this.centerTitle = true,
    this.actions,
    this.titleColor = KfontConstant.titleFontColor,
    this.elevation = 2,
  }) : super(key: key);

  final String title;
  final bool centerTitle;
  final List<Widget> actions;
  final Color titleColor;
  final double elevation;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: elevation,
      centerTitle: centerTitle,
      title: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.normal,
          fontFamily: KfontConstant.Roboto,
          color: titleColor,
        ),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      actions: actions,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
