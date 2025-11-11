import 'package:flutter/material.dart';
import 'package:news/base/app_helpers.dart';
import 'package:news/models/article_model.dart';
import 'package:news/widgets/large_news/special_type_1.dart';
import 'package:news/widgets/large_news/special_type_2.dart';
import 'package:news/widgets/large_news/special_type_3.dart';

class SpecialArticle {
  final String threadName;
  final int displayStyle;
  final List<Article> newsThreadItems;
  final List<Article> newsRelations;
  final Article article;

  const SpecialArticle({
    this.threadName,
    this.displayStyle,
    this.newsThreadItems,
    this.newsRelations,
    this.article,
  });

  // Get set
  Widget get getUIWidget {
    switch (displayStyle) {
      case 1:
        return SpecialType1(
          specialArticles: this,
          isShowDivider: true,
        );
        break;

      case 2:
        return SpecialType2(
          specialArticles: this,
          isShowDivider: true,
        );
        break;

      case 3:
        return SpecialType3(
          specialArticles: this,
          isShowDivider: true,
        );
        break;

      default:
        return SpecialType1(
          specialArticles: this,
          isShowDivider: true,
        );
    }
  }

  //
  factory SpecialArticle.fromJson(Map<String, dynamic> json) {
    if (json == null || (json?.isEmpty ?? false)) {
      return null;
    }

    return SpecialArticle(
      article: Article.fromJson(json),
      displayStyle: lookup<int>(json, ['DisplayStyle'] ?? 1),
      threadName: lookup<String>(json, ['ThreadName'] ?? ''),
      newsThreadItems: lookup<List>(json, ['NewsThreadItems'])
              ?.map<Article>((o) => Article.fromJson(o))
              ?.toList() ??
          <Article>[],
      newsRelations: lookup<List>(json, ['NewsRelation'])
              ?.map<Article>((o) => Article.fromJson(o))
              ?.toList() ??
          <Article>[],
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = article.toJson();
    map.addEntries({
      "DisplayStyle": displayStyle,
      "ThreadName": threadName,
      "NewsThreadItems": newsThreadItems,
      "NewsRelation": newsRelations,
    }.entries);

    return map;
  }
}
