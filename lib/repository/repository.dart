import 'dart:async';
import 'package:news/constant/enum.dart';
import 'package:news/models/article_model.dart';
import 'package:news/models/article_native.dart';
import 'package:news/models/classifieds.dart';
import 'package:news/models/comment_model.dart';
import 'package:news/models/home_model.dart';
import 'package:news/models/podcast_model.dart';
import 'package:news/models/tto_news.dart';
import 'package:news/models/video_tvo_model.dart';
import 'package:news/models/zone_model.dart';
import 'package:news/repository/account_provider.dart';
import 'package:news/repository/article_provider.dart';
import 'package:news/repository/category_provider.dart';
import 'package:news/repository/home_provider.dart';
import 'package:news/repository/news_provider.dart';
import 'package:news/repository/search_provider.dart';
import 'package:news/repository/zone_provider.dart';

class Repository {
  final homeProvider = HomeProvider();
  final articleProvider = ArticleProvider();
  final categoryProvider = CategoryProvider();
  final searchProvider = SearchProvider();
  final zoneProvider = ZoneProvider();
  final accountProvider = TTOAccountProvider();
  final newsProvider = TTONewsProvider();

  // ---------------- HOME ------------------//
  Future<HomeStruct> fetchAllHome() => homeProvider.fetchHomeList();
  Future<List<ClassiFieds>> getClassiFieds() => homeProvider.getClassiFieds();
  Future<List<TtoNews>> getTtNews() => homeProvider.getTtNews();
  Future<List<Article>> getHomePaging(int pageIndex) =>
      homeProvider.fetchHomePagingList(pageIndex);
  Future<bool> sendTheQuestion(
    String name,
    String email,
    String content,
    TypeQuestion type,
  ) =>
      homeProvider.sendTheQuestion(name, email, content, type);

  // ---------------- ARTICLE ------------------//
  Future<Article> getArticleDetail(String newsId) =>
      articleProvider.fetchArticleDetail(newsId);

  Future<ArticleNative> getArticleDetailNative(String newsId) =>
      articleProvider.fetchArticleDetailNative(newsId);

  Future<VideoTvoModel> getArticleTvoDetail(String newsId) =>
      articleProvider.videoTvoDetail(newsId: newsId);

  Future<String> getUrlVideoTvoDetail(String link) =>
      articleProvider.getLinkVideo(link: link);

  Future<List<Article>> getNewsInterest(String zoneId) =>
      articleProvider.getNewInterest(zoneId);

  Future<List<Article>> getNewsLastest(int page) =>
      articleProvider.getNewLastest(page);

  Future<List<Article>> getNewsStars(int page) =>
      articleProvider.getNewStars(page);

  Future<List<Article>> getNewstRecommend() =>
      articleProvider.getNewstRecommend();

  Future<List<Article>> getTagNews(String tagUrl) =>
      articleProvider.getTagNews(tagUrl);

  // ---------------- CATEGORY ------------------//
  Future<List<ZoneList>> fetchAllZoneList() => categoryProvider.fetchZoneList();

  Future<List<PodcastModel>> fetchAllPostcastList() =>
      categoryProvider.fetchPodcastList();

  Future<List<Article>> fetchAllVideoList() =>
      categoryProvider.fetchVideoList();

  Future<List<Article>> fetchListingByZone(String zoneId) =>
      categoryProvider.fetchListingByZone(zoneId);

  Future<List<Article>> fetchZonePaging(String zoneId, int pageIndex) =>
      zoneProvider.fetchZonePaging(zoneId, pageIndex);

  // ---------------- SEARCH ------------------//
  Future<List<Article>> fetchAllSearchList(String keyword, int pageIndex) =>
      searchProvider.fetchSearchList(keyword, pageIndex);

  // ---------------- ACCOUNT ------------------//
  Future<List<TTOCommentJSONModel>> newsGetComment(String newsId) =>
      newsProvider.newsGetComment(newsId);

  Future<bool> accountAddComment(TTOAddCommentParams params) =>
      accountProvider.accountAddComment(params);
}
