import 'package:flutter/material.dart';
import 'package:news/constant/font.dart';
import 'package:news/constant/length.dart';
import 'package:news/models/body_row.dart';
import 'package:news/pages/detail/widgets/text_html_widget.dart';

class BodyRowPWidget extends StatelessWidget {
  const BodyRowPWidget({
    Key key,
    @required this.row,
    @required this.textSize,
    this.padding = const EdgeInsets.symmetric(vertical: paddingNews),
    this.onTapUrl,
  }) : super(key: key);

  final BodyRow row;
  final int textSize;
  final EdgeInsets padding;
  final ValueChanged<String> onTapUrl;

  @override
  Widget build(BuildContext context) {
    return row?.value?.isNotEmpty ?? false
        ? TextHtmlWidget(
            row: row,
            padding: padding,
            textStyle: KfontConstant.styleOfContent.copyWith(
              fontSize: textSize.toDouble(),
            ),
            onTapUrl: onTapUrl,
          )
        : Offstage();
  }
}
