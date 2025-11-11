import 'package:flutter/material.dart';
import 'package:news/constant/color.dart';
import 'package:news/models/body_row.dart';
import 'package:news/pages/detail/widgets/detail_image_widget.dart';

class BodyRowPhotoWidget extends StatelessWidget {
  const BodyRowPhotoWidget({
    Key key,
    @required this.textSize,
    @required this.row,
  }) : super(key: key);

  final int textSize;
  final BodyRow row;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        children: [
          // Detail image
          DetailImageWidget(img: row?.img),

          // Caption image
          if (row?.isShowCaption) ...[
            Container(
              width: double.infinity,
              color: cardNewsBorderColor.withOpacity(0.618),
              padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
              child: Text(
                row?.caption ?? '',
                style: TextStyle(
                  fontSize: textSize.toDouble(),
                  height: 1.6,
                  color: textVoteColor,
                ),
                textAlign: TextAlign.center,
              ),
            )
          ]
        ],
      ),
    );
  }
}
