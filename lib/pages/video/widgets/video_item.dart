import 'package:flutter/material.dart';
import 'package:news/base/app_helpers.dart';
import 'package:news/constant/font.dart';
import 'package:news/constant/length.dart';
import 'package:news/constant/number.dart';
import 'package:news/models/article_model.dart';
import 'package:news/widgets/ariticle_detail/push_to_detail.dart';
import 'package:news/widgets/large_news/big_image_widget.dart';
import 'package:news/widgets/divider_widget.dart';

class VideoItem extends StatelessWidget {
  const VideoItem({
    Key key,
    @required this.index,
    @required this.article,
  }) : super(key: key);

  final int index;
  final Article article;

  @override
  Widget build(BuildContext context) {
    printDebug('Build item ${article.title}');

    return InkWell(
      child: Padding(
        padding: EdgeInsets.only(
          top: index == FIRST_INDEX ? paddingNews : 0,
        ),
        child: Column(
          children: <Widget>[
            if (index > FIRST_INDEX) ...[
              DividerWidget(),
            ],

            // Title
            Container(
              padding: EdgeInsets.only(bottom: paddingNews),
              alignment: Alignment.topLeft,
              child: Text(
                article.title,
                maxLines: 4,
                overflow: TextOverflow.ellipsis,
                style: KfontConstant.styleOfTitleLargeType1,
              ),
            ),

            // Image & button play
            Stack(
              children: <Widget>[
                BigImageWidget(urlImage: article.getImageNews),
                Positioned(
                  left: 10.0,
                  bottom: 10.0,
                  child: Image.asset(
                    'assets/images/buttonplay.png',
                    width: kToolbarHeight,
                    height: kToolbarHeight,
                  ),
                )
              ],
            ),
          ],
        ),
      ),
      onTap: () => pushToDetail(article: article, context: context),
    );
  }
}
