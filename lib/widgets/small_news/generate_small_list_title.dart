import 'package:flutter/material.dart';
import 'package:news/constant/color.dart';
import 'package:news/constant/length.dart';
import 'package:news/constant/number.dart';
import 'package:news/models/article_model.dart';
import 'package:news/widgets/divider_widget.dart';
import 'package:news/widgets/small_news/small_news_list_title.dart';

class GenerateSmallListTitle extends StatelessWidget {
  const GenerateSmallListTitle({Key key, this.articles}) : super(key: key);

  final List<Article> articles;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: paddingNews),
      child: ListView.builder(
          padding: EdgeInsets.symmetric(vertical: paddingNewsTitle * 2),
          shrinkWrap: true,
          itemCount: articles.length,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, int index) {
            return (index == FIRST_INDEX)
                ? SmallNewsListTitle(article: this.articles[index])
                : Column(
                    children: [
                      DividerWidget(
                        color: cardNewsBorderColor,
                        subtract: paddingDivider * 4,
                      ),
                      SmallNewsListTitle(article: this.articles[index])
                    ],
                  );
          }),
      decoration: BoxDecoration(
        color: cardNewsBackgroundColor,
        border: Border.all(color: cardNewsBorderColor),
        borderRadius: BorderRadius.circular(radius8),
      ),
    );
  }
}
