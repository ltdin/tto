import 'package:flutter/material.dart';

class SettingWidget extends StatelessWidget {
  const SettingWidget({
    Key key,
    @required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(alignment: Alignment.centerLeft, height: 40, child: child);
  }
}
