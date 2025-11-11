import 'dart:convert';

import 'package:news/models/article_model.dart';
import 'package:news/base/app_helpers.dart';

// get list video
List<Article> videoListFromJson(String str) {
  final jsonData = json.decode(str);

  // add list TVO
  List<Article> boxTvo = lookup<List>(jsonData, ['data', 'BoxVideoNewUpdate'])
          ?.map<Article>((o) => Article.fromJson(o))
          ?.toList() ??
      <Article>[];

  List<Article> articles = boxTvo;

  // add boxFeatures
  List<Article> boxFeatures = lookup<List>(jsonData, ['data', 'BoxFeatured'])
          ?.map<Article>((o) => Article.fromJson(o))
          ?.toList() ??
      <Article>[];

  articles.addAll(boxFeatures);

  // add BoxMostView
  List<Article> boxMostView = lookup<List>(jsonData, ['data', 'BoxMostView'])
          ?.map<Article>((o) => Article.fromJson(o))
          ?.toList() ??
      <Article>[];

  for (var i = 0; i < boxMostView.length; i++) {
    var a =
        articles.where((article) => article.newsId == boxMostView[i].newsId);
    if (a.length == 0) {
      articles.add(boxMostView[i]);
    }
  }

  List<Article> boxLastest = lookup<List>(jsonData, ['data', 'BoxLastest'])
          ?.map<Article>((o) => Article.fromJson(o))
          ?.toList() ??
      <Article>[];

  for (var i = 0; i < boxLastest.length; i++) {
    var a = articles.where((article) => article.newsId == boxLastest[i].newsId);
    if (a.length == 0) {
      articles.add(boxLastest[i]);
    }
  }

  return articles;
}
