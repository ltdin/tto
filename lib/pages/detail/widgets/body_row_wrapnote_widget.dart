import 'package:flutter/material.dart';
import 'package:news/constant/color.dart';
import 'package:news/constant/length.dart';
import 'package:news/constant/string.dart';
import 'package:news/models/body_row.dart';
import 'package:news/pages/detail/widgets/body_row_h1_widget.dart';
import 'package:news/pages/detail/widgets/body_row_h2_widget.dart';
import 'package:news/pages/detail/widgets/body_row_h3_widget.dart';
import 'package:news/pages/detail/widgets/body_row_h4_widget.dart';
import 'package:news/pages/detail/widgets/body_row_p_widget.dart';
import 'package:news/pages/detail/widgets/body_row_photo_widget.dart';

class BodyRowWrapnoteWidget extends StatelessWidget {
  const BodyRowWrapnoteWidget({
    Key key,
    @required this.row,
    @required this.textSize,
    this.onTapUrl,
  }) : super(key: key);

  final BodyRow row;
  final int textSize;
  final ValueChanged<String> onTapUrl;

  @override
  Widget build(BuildContext context) {
    final wrapNotes = row?.wrapNotes;
    final _paddingH = const EdgeInsets.symmetric(vertical: paddingNews);

    return wrapNotes?.isNotEmpty ?? false
        ? Container(
            margin: const EdgeInsets.symmetric(
              horizontal: paddingNews,
              vertical: paddingNews,
            ),
            padding: const EdgeInsets.all(paddingNewsTitle + 2),
            child: Column(
              children: List<Widget>.generate(wrapNotes.length, (index) {
                switch (wrapNotes.elementAt(index).type) {

                  //
                  case KString.STR_BODY_ROW_TYPE_PHOTO:
                    return BodyRowPhotoWidget(
                      textSize: textSize,
                      row: wrapNotes.elementAt(index),
                    );
                    break;

                  case KString.STR_BODY_ROW_TYPE_P:
                    return BodyRowPWidget(
                      row: wrapNotes.elementAt(index),
                      textSize: textSize + 4,
                      onTapUrl: onTapUrl,
                    );
                    break;

                  case KString.STR_BODY_ROW_TYPE_H1:
                    return BodyRowH1Widget(
                      padding: _paddingH,
                      textSize: textSize,
                      row: wrapNotes.elementAt(index),
                    );
                    break;

                  case KString.STR_BODY_ROW_TYPE_H2:
                    return BodyRowH2Widget(
                      padding: _paddingH,
                      textSize: textSize,
                      row: wrapNotes.elementAt(index),
                    );
                    break;

                  case KString.STR_BODY_ROW_TYPE_H3:
                    return BodyRowH3Widget(
                      padding: _paddingH,
                      textSize: textSize,
                      row: wrapNotes.elementAt(index),
                    );
                    break;

                  case KString.STR_BODY_ROW_TYPE_H4:
                    return BodyRowH4Widget(
                      padding: _paddingH,
                      textSize: textSize,
                      row: wrapNotes.elementAt(index),
                    );
                    break;

                  default:
                    return Offstage();
                    break;
                }
              }),
            ),
            decoration: BoxDecoration(
              color: CL_DETAIL_BACKGROUND_WRAPNOTE,
              border: Border.all(color: CL_DETAIL_BACKGROUND_WRAPNOTE_BORDER),
            ),
          )
        : Offstage();
  }
}
