import 'package:flutter/material.dart';
import 'package:news/models/article_model.dart';
import 'package:news/widgets/large_news/large_news_type_2.dart';

class GenerateLargeListType2 extends StatelessWidget {
  const GenerateLargeListType2({
    Key key,
    this.type,
    this.articles,
    this.indexSolidDivider = 0,
  }) : super(key: key);

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
        return LargeNewsType2(
          article: this.articles[index],
          isShowDivider: true,
        );
      },
    );
  }
}
