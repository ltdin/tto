import 'package:flutter/material.dart';
import 'package:news/constant/font.dart';
import 'package:news/constant/length.dart';
import 'package:news/models/article_model.dart';
import 'package:news/widgets/ariticle_detail/push_to_detail.dart';

class SmallNewsTimeTitleHorizontal extends StatelessWidget {
  const SmallNewsTimeTitleHorizontal({
    Key key,
    @required this.article,
    this.type,
    this.isShowDivider = false,
  }) : super(key: key);

  final String type;
  final Article article;
  final bool isShowDivider;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        width: MediaQuery.of(context).size.width - (paddingNews32 * 2),
        padding: EdgeInsets.all(paddingNews),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Time
            Text(
              article.getDayMonth,
              style: KfontConstant.styleOfTitleSmallTimeGetTime,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.right,
            ),

            // Title news
            Text(
              article.title,
              style: KfontConstant.styleOfTitleLargeType4,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
      onTap: () => pushToDetail(article: article, context: context),
    );
  }
}
