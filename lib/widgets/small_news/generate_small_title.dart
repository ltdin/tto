import 'package:flutter/material.dart';
import 'package:news/models/article_model.dart';
import 'package:news/widgets/divider_widget.dart';
import 'package:news/widgets/small_news/small_news_title.dart';

class GenerateSmallTitle extends StatelessWidget {
  const GenerateSmallTitle({
    Key key,
    this.articles,
    this.padding = EdgeInsets.zero,
    this.hasDividerAtBottom = false,
    this.subtractDivider = 0.0,
  }) : super(key: key);

  final List<Article> articles;
  final EdgeInsets padding;
  final bool hasDividerAtBottom;
  final double subtractDivider;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        padding: padding,
        shrinkWrap: true,
        itemCount: articles.length,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, int index) {
          return Column(
            children: [
              DividerWidget(subtract: subtractDivider),
              SmallNewsTitle(article: this.articles[index]),
              if (index == articles.length - 1 && hasDividerAtBottom)
                DividerWidget(subtract: subtractDivider),
            ],
          );
        });
  }
}
