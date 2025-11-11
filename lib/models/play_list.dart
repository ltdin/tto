import 'package:news/base/app_helpers.dart';
import 'package:news/models/article_model.dart';

class PlayList {
  final String topic;
  final String url;
  final List<Article> articles;

  const PlayList({this.topic, this.url, this.articles});

  factory PlayList.fromJson(Map<String, dynamic> json) {
    if (json == null || (json?.isEmpty ?? false)) {
      return null;
    }

    return PlayList(
      topic: lookup<String>(json, ['title'] ?? ''),
      url: lookup<String>(json, ['url'] ?? ''),
      articles: lookup<List>(json, ['videos'])
              ?.map<Article>((o) => Article.fromJson(o))
              ?.toList() ??
          <Article>[],
    );
  }

  Map<String, dynamic> toJson() => {
        "NewsId": topic,
        "Title": url,
        "videos": articles,
      };
}
