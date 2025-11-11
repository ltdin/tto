import 'package:flutter/material.dart';
import 'package:news/base/app_helpers.dart';
import 'package:news/constant/length.dart';
import 'package:news/constant/string.dart';
import 'package:news/models/body_row.dart';
import 'package:news/pages/detail/widgets/body_row_h1_widget.dart';
import 'package:news/pages/detail/widgets/body_row_h2_widget.dart';
import 'package:news/pages/detail/widgets/body_row_h3_widget.dart';
import 'package:news/pages/detail/widgets/body_row_h4_widget.dart';
import 'package:news/pages/detail/widgets/body_row_p_widget.dart';
import 'package:news/pages/detail/widgets/body_row_photo_widget.dart';
import 'package:news/pages/detail/widgets/body_row_video_widget.dart';
import 'package:news/pages/detail/widgets/body_row_wrapnote_widget.dart';

class GenerateNativeBody extends StatelessWidget {
  const GenerateNativeBody({
    Key key,
    @required this.body,
    this.textSize,
    this.onTapUrl,
  }) : super(key: key);

  final List<BodyRow> body;
  final int textSize;
  final ValueChanged<String> onTapUrl;

  @override
  Widget build(BuildContext context) {
    printDebug('\n-------- Build : GenerateNativeBody ------- ');

    final realBody = List<Widget>.generate(body.length, (index) {
      switch (body.elementAt(index).type) {

        //
        case KString.STR_BODY_ROW_TYPE_PHOTO:
          return BodyRowPhotoWidget(
            textSize: textSize,
            row: body.elementAt(index),
          );
          break;

        case KString.STR_BODY_ROW_TYPE_P:
          return BodyRowPWidget(
            row: body.elementAt(index),
            textSize: textSize + 4,
            padding: const EdgeInsets.symmetric(
              horizontal: paddingNews,
              vertical: paddingNewsTitle,
            ),
            onTapUrl: onTapUrl,
          );
          break;

        case KString.STR_BODY_ROW_TYPE_H1:
          return BodyRowH1Widget(
            textSize: textSize,
            row: body.elementAt(index),
          );
          break;

        case KString.STR_BODY_ROW_TYPE_H2:
          return BodyRowH2Widget(
            textSize: textSize,
            row: body.elementAt(index),
          );
          break;

        case KString.STR_BODY_ROW_TYPE_H3:
          return BodyRowH3Widget(
            textSize: textSize,
            row: body.elementAt(index),
          );
          break;

        case KString.STR_BODY_ROW_TYPE_H4:
          return BodyRowH4Widget(
            textSize: textSize,
            row: body.elementAt(index),
          );
          break;

        case KString.STR_BODY_ROW_TYPE_VIDEO:
          return BodyRowVideoWidget(
            textSize: textSize,
            row: body.elementAt(index),
          );
          break;

        case KString.STR_BODY_ROW_TYPE_VIDEO_SQUARE:
          return BodyRowVideoWidget(
            textSize: textSize,
            row: body.elementAt(index),
          );
          break;

        case KString.STR_BODY_ROW_TYPE_WRAPNOTE:
          return BodyRowWrapnoteWidget(
            textSize: textSize,
            row: body.elementAt(index),
            onTapUrl: onTapUrl,
          );
          break;

        default:
          return Offstage();
          break;
      }
    });

    return Column(children: realBody);
  }
}
