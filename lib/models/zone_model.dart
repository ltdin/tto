import 'dart:convert';

import 'package:diacritic/diacritic.dart';
import 'package:news/api/apis.dart';
import 'package:news/models/article_model.dart';
import 'package:news/base/app_helpers.dart';

// Get list zone
List<ZoneList> zoneFromJson(String str) {
  final jsonData = json.decode(str);
  return lookup<List>(jsonData, ['data'])
          ?.map<ZoneList>((o) => ZoneList.fromJson(o))
          ?.toList() ??
      <ZoneList>[];
}

class ZoneList {
  const ZoneList({
    this.zoneId,
    this.name,
    this.shortUrl,
    this.slug,
    this.childZone,
    this.description,
    this.admChannel
  });

  final int zoneId;
  final String name;
  final String shortUrl;
  final String slug;
  final String description;
  final String admChannel;
  final List<ZoneList> childZone;

  // Get
  String get getUrlRaoVatForZone => '${Apis.raovat}/$slug';
  String get getUrlTVO =>
      shortUrlNotEmplty ? '${Apis.tvo}/$shortUrl.htm' : Apis.tvo;
  String get getSlug =>
      slug ?? removeDiacritics(name.replaceAll(' ', '-')).toLowerCase();
  String get getShortUrl => shortUrl.contains('https://')
      ? shortUrl
      : 'https://tuoitre.vn/$shortUrl.htm';
  String get getTag =>
      removeDiacritics(name.replaceAll(' ', '_')).toLowerCase();
  String get getUrlForCategory =>
      shortUrlNotEmplty ? getShortUrl : 'https://tuoitre.vn/$getSlug.htm';
  bool get shortUrlNotEmplty => (shortUrl?.isNotEmpty ?? false);
  String get getAdmChannel => admChannel ??  "";//"/home/"

  factory ZoneList.fromJson(Map<String, dynamic> json) => ZoneList(
        description: json["Description"] ?? '',
        zoneId: json["Id"],
        name: json["Name"],
        shortUrl: json["ShortUrl"],
      );

  Map<String, dynamic> toJson() => {
        "Id": zoneId,
        "Name": name,
        "ShortURL": shortUrl,
        "Slug": slug,
        "Description": description,
      };
}

ListingByZoneStruct listingByZoneFromJson(String str) {
  final jsonData = json.decode(str);
  return ListingByZoneStruct.fromJson(
    lookup<dynamic>(jsonData, ['data']) ?? null,
  );
}

class ListingByZoneStruct {
  ListingByZoneStruct({this.boxFeatures, this.newsStream, this.boxVideos});

  final List<Article> boxFeatures;
  final List<Article> newsStream;
  final List<Article> boxVideos;

  factory ListingByZoneStruct.fromJson(Map<String, dynamic> json) {
    if (json == null) {
      return null;
    }

    return ListingByZoneStruct(
      boxFeatures: lookup<List>(json, ['BoxFeatured'])
              ?.map<Article>((o) => Article.fromJson(o))
              ?.toList() ??
          <Article>[],
      boxVideos: lookup<List>(json, ['BoxVideos'])
              ?.map<Article>((o) => Article.fromJson(o))
              ?.toList() ??
          <Article>[],
      newsStream: lookup<List>(json, ['NewsStream'])
              ?.map<Article>((o) => Article.fromJson(o))
              ?.toList() ??
          <Article>[],
    );
  }

  Map<String, dynamic> toJson() => {
        "BoxFeatures": boxFeatures,
        "NewsStream": newsStream,
        "BoxVideos": boxVideos,
      };

  List<Article> get listArticle {
    final List<Article> articles = [];
    articles.addAll(boxFeatures);

    // Filter list boxVideos
    for (final item in boxVideos) {
      final exist = articles.firstWhere(
        (element) => element.newsId == item.newsId,
        orElse: () => null,
      );
      if (exist == null) {
        articles.add(item);
      }
    }

    // Filter list newsStream
    for (final item in newsStream) {
      final exist = articles.firstWhere(
        (element) => element.newsId == item.newsId,
        orElse: () => null,
      );
      if (exist == null) {
        articles.add(item);
      }
    }

    return articles;
  }
}
