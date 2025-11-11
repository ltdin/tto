import 'package:flutter/material.dart';
import 'package:news/models/article_model.dart';
import 'package:news/widgets/ariticle_detail/push_to_detail.dart';
import 'package:news/widgets/small_news/small_news_type_1.dart';

class ArticleListBasicWidget extends StatelessWidget {
  const ArticleListBasicWidget(
      {Key key, this.type, this.articles, this.indexSolidDivider = 0})
      : super(key: key);

  final String type;
  final List<Article> articles;
  final int indexSolidDivider;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      itemCount: articles.length,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, int index) {
        return InkWell(
          child: SmallNewsType1(
            article: this.articles[index],
            isSolidDivider: index == indexSolidDivider,
          ),
          onTap: () =>
              pushToDetail(article: this.articles[index], context: context),
        );
      },
    );
  }
}
