import 'package:flutter/material.dart';
import 'package:news/constant/font.dart';
import 'package:news/constant/length.dart';
import 'package:news/models/article_model.dart';
import 'package:news/widgets/ariticle_detail/push_to_detail.dart';

class SmallNewsTimeTitle extends StatelessWidget {
  const SmallNewsTimeTitle({
    Key key,
    @required this.article,
    this.type,
    this.isSolidDivider = false,
  }) : super(key: key);

  final String type;
  final Article article;
  final bool isSolidDivider;

  String rev(String s) {
    return String.fromCharCodes(s.runes.toList().reversed);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Time
          Padding(
            padding: const EdgeInsets.only(left: paddingNews),
            child: Text(
              article.getDayMonth,
              style: KfontConstant.styleOfTitleSmallTimeGetTime,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.right,
            ),
          ),

          // Title news
          Expanded(
            flex: 8,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: paddingNews,
              ),
              child: Text(
                article.title,
                style: KfontConstant.styleOfTitleSmallTime,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ],
      ),
      onTap: () => pushToDetail(article: article, context: context),
    );
  }
}
