import 'package:flutter/material.dart';
import 'package:news/constant/string.dart';
import 'package:news/widgets/appbar_for_tab.dart';

class EmptyPage extends StatelessWidget {
  const EmptyPage({Key key, @required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget(title: title),
      body: Center(child: Text(KString.msgNoData)),
    );
  }
}
