import 'package:flutter/material.dart';
import 'package:news/models/article_model.dart';
import 'package:news/widgets/item_small_article.dart';

class ListNewsRelation extends StatelessWidget {
  ListNewsRelation(
      {Key key, @required this.newsRelations, this.onClickItemRelationsNews})
      : super(key: key);

  final List<Article> newsRelations;
  final ValueChanged<Article> onClickItemRelationsNews;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: newsRelations.length,
      itemBuilder: (BuildContext ctxt, int index) {
        return InkWell(
          child: ItemSmallArticle(article: newsRelations.elementAt(index)),
          onTap: () =>
              onClickItemRelationsNews.call(newsRelations.elementAt(index)),
        );
      },
    );
  }
}
