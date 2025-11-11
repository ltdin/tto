import 'package:flutter/material.dart';
import 'package:news/base/app_helpers.dart';
import 'package:news/constant/font.dart';
import 'package:news/models/article_model.dart';
import 'package:news/widgets/ariticle_detail/push_to_detail.dart';

class SmallNewsTitle extends StatelessWidget {
  const SmallNewsTitle({
    Key key,
    @required this.article,
  }) : super(key: key);

  final Article article;

  @override
  Widget build(BuildContext context) {
    printDebug("Build news : ${article.title}");

    return InkWell(
      child:
          // Title news
          Align(
        alignment: Alignment.centerLeft,
        child: Text(
          article.title,
          style: KfontConstant.styleOfSmallTitle,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
      ),
      onTap: () => pushToDetail(article: article, context: context),
    );
  }
}
