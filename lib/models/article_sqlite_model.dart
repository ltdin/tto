import 'dart:convert';
import 'package:news/constant/number.dart';
import 'package:news/models/article_model.dart';

class ArticleSqlite {
  const ArticleSqlite({
    this.idCategory,
    this.isUpdate,
    this.articles,
  });
  final String idCategory;
  final int isUpdate;
  final List<Article> articles;

  factory ArticleSqlite.fromJson(Map<String, dynamic> jsonParse) {
    if (jsonParse == null) {
      return null;
    }
    final mapsArticles = json.decode(jsonParse['content']);
    return ArticleSqlite(
      idCategory: jsonParse['idCategory'],
      isUpdate: jsonParse['isUpdate'] ?? IS_UPDATE,
      articles: mapsArticles['data']
              ?.map<Article>((o) => Article.fromJson(o))
              ?.toList() ??
          <Article>[],
    );
  }
}
