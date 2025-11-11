import 'package:news/models/article_model.dart';

class TtoNews {
  const TtoNews({this.title, this.thumb, this.url});

  final String title;
  final String thumb;
  final String url;

  factory TtoNews.fromJson(Map<String, dynamic> json) => TtoNews(
        title: json["title"],
        thumb: json["thumb"],
        url: json["url"],
      );

  Article toArticle() {
    return Article(
      title: this.title,
      avatar: this.thumb,
      defaultAvatar: this.thumb,
      url: this.url,
    );
  }

  Map<String, dynamic> toJson() => {
        "title": title,
        "thumb": thumb,
        "url": url,
      };
}
