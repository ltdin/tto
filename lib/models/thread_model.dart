import 'article_model.dart';

class ThreadModel {
  final int id;
  final String name;
  final String url;

  /// 📰 Danh sách bài viết (News)
  final List<Article> articles;

  /// 🆕 Danh sách tin bài dạng đơn giản — dùng để xử lý DistributionDate
  final List<NewsModel> news;

  /// 🏷️ Thông tin chuyên mục (nếu có)
  final int zoneId;
  final String zoneName;

  ThreadModel({
    this.id,
    this.name,
    this.url,
    this.articles = const [],
    this.news = const [],
    this.zoneId,
    this.zoneName,
  });

  /// 🖼 Ảnh đại diện (nếu có)
  String get coverImage {
    if (articles.isNotEmpty) {
      return articles.first.defaultAvatar ?? '';
    }
    return '';
  }

  /// 🧠 Parse từ JSON của API
  factory ThreadModel.fromJson(Map<String, dynamic> json) {
    final thread = json['Thread'] ?? {};

    // 🗞 Lấy danh sách bài viết (News)
    final newsList = (json['News'] as List ?? [])
        .map((e) => Article.fromJson(e))
        .toList();

    // 🔄 Đồng thời chuyển sang dạng NewsModel để dễ lọc DistributionDate
    final newsModels = (json['News'] as List ?? [])
        .map((e) => NewsModel.fromJson(e))
        .toList();

    return ThreadModel(
      id: thread['Id'],
      name: thread['Name'],
      url: thread['Url'],
      articles: newsList,
      news: newsModels,
      zoneId: thread['ZoneId'],
      zoneName: thread['ZoneName'],
    );
  }
}

/// 🔹 Model nhỏ gọn để lấy DistributionDate
class NewsModel {
  final String title;
  final String distributionDate;
  final String url;
  final String avatar;

  NewsModel({
    this.title,
    this.distributionDate,
    this.url,
    this.avatar,
  });

  factory NewsModel.fromJson(Map<String, dynamic> json) {
    return NewsModel(
      title: json['Title'] ?? '',
      distributionDate: json['DistributionDate'] ?? '',
      url: json['Url'] ?? '',
      avatar: json['DefaultAvatar'] ?? '',
    );
  }
}
