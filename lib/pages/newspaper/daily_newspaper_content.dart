import 'package:flutter/material.dart';
import 'package:news/constant/length.dart';

class DailyNewspaperContent extends StatelessWidget {
  const DailyNewspaperContent({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(paddingNews),
      child: Offstage(),
    );
  }
}
