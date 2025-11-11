import 'package:flutter/material.dart';
import 'package:news/constant/font.dart';
import 'package:news/models/article_model.dart';
import 'package:news/widgets/small_news/small_image_widget.dart';

class SmallNewsType2 extends StatelessWidget {
  const SmallNewsType2({
    Key key,
    @required this.article,
    this.type,
  }) : super(key: key);

  final String type;
  final Article article;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        // Image small
        Expanded(
          flex: 4,
          child: SmallImageWidget(article: article, type: type),
        ),

        // Infomation news
        Expanded(
          flex: 6,
          child: Container(
            padding: EdgeInsets.only(left: 12),
            child: Align(
              alignment: Alignment.topLeft,
              child: Text(
                article.title,
                style: KfontConstant.styleOfTitleSmallType2,
                maxLines: 4,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        )
      ],
    );
  }
}
