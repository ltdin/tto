import 'package:flutter/material.dart';
import 'package:news/constant/font.dart';
import 'package:news/constant/length.dart';
import 'package:news/models/body_row.dart';
import 'package:news/pages/detail/widgets/text_html_widget.dart';

class BodyRowH1Widget extends StatelessWidget {
  const BodyRowH1Widget({
    Key key,
    @required this.row,
    @required this.textSize,
    this.padding = const EdgeInsets.all(paddingNews),
  }) : super(key: key);

  final BodyRow row;
  final int textSize;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    return row?.value?.isNotEmpty ?? false
        ? TextHtmlWidget(
            row: row,
            padding: padding,
            textStyle: KfontConstant.styleOfTitleSmallType1
                .copyWith(fontSize: textSize + 12.0),
          )
        : Offstage();
  }
}
