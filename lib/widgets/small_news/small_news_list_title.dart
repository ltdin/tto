import 'package:flutter/material.dart';
import 'package:news/constant/font.dart';
import 'package:news/constant/length.dart';
import 'package:news/models/article_model.dart';
import 'package:news/widgets/ariticle_detail/push_to_detail.dart';

class SmallNewsListTitle extends StatelessWidget {
  const SmallNewsListTitle({
    Key key,
    @required this.article,
    this.type,
    this.isSolidDivider = false,
  }) : super(key: key);

  final String type;
  final Article article;
  final bool isSolidDivider;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child:
          // Title news
          Padding(
        padding: const EdgeInsets.symmetric(
          vertical: paddingNewsTitle,
          horizontal: paddingNews,
        ),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            '▪  ' + article.title,
            style: KfontConstant.styleOfSmallTitle,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
      onTap: () => pushToDetail(article: article, context: context),
    );
  }
}
