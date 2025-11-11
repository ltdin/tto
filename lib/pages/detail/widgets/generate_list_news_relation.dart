import 'package:flutter/material.dart';
import 'package:news/constant/color.dart';
import 'package:news/constant/length.dart';
import 'package:news/models/article_model.dart';
import 'package:news/widgets/small_news/small_news_type_1.dart';

class GenerateListNewsRelation extends StatelessWidget {
  const GenerateListNewsRelation({
    Key key,
    @required this.newsRelations,
    this.onClickItemRelationsNews,
  }) : super(key: key);

  final List<Article> newsRelations;
  final ValueChanged<Article> onClickItemRelationsNews;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: paddingNews),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: newsRelations.length,
      itemBuilder: (BuildContext ctxt, int index) {
        return SmallNewsType1(
          article: newsRelations.elementAt(index),
          isSolidDivider: true,
          colorDivider: dividerColor,
          OnTap: () =>
              onClickItemRelationsNews.call(newsRelations.elementAt(index)),
        );
      },
    );
  }
}
