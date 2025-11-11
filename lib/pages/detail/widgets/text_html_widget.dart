import 'package:flutter/material.dart';
import 'package:news/constant/font.dart';
import 'package:news/constant/length.dart';
import 'package:news/models/body_row.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';

class TextHtmlWidget extends StatelessWidget {
  const TextHtmlWidget({
    Key key,
    @required this.row,
    this.padding = const EdgeInsets.symmetric(horizontal: paddingNews),
    this.textStyle = KfontConstant.defaultStyle,
    this.onTapUrl,
  }) : super(key: key);

  final BodyRow row;
  final EdgeInsets padding;
  final TextStyle textStyle;
  final ValueChanged<String> onTapUrl;

  @override
  Widget build(BuildContext context) {
    return row?.value?.isNotEmpty ?? false
        ? Padding(
            padding: padding,
            child: Align(
              alignment: Alignment.centerLeft,
              child: HtmlWidget(
                row?.value,
                textStyle: textStyle,
                onErrorBuilder: (context, element, error) {
                  return Offstage();
                },
                onTapUrl: (url) {
                  onTapUrl?.call(url);
                  return true;
                },
              ),
            ),
          )
        : Offstage();
  }
}
