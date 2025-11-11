import 'dart:async';

import                                                                                                                                                                                                                                                            'package:news/api/apis.dart';
import 'package:news/constant/enum.dart';
import 'package:news/models/article_model.dart';
import 'package:news/models/article_native.dart';
import 'package:news/models/classifieds.dart';
import 'package:news/models/comment_model.dart';
import 'package:news/models/daily_newspaper.dart';
import 'package:news/models/home_model.dart';
import 'package:news/models/list_newspaper.dart';
import 'package:news/models/newspaper.dart';
import 'package:news/models/podcast_model.dart';
import 'package:news/models/tto_news.dart';
import 'package:news/models/video_tvo_model.dart';
import 'package:news/models/zone_model.dart';
import 'package:news/repository/article_provider.dart';
import 'package:news/repository/home_provider.dart';
import 'package:news/repository/repository.dart';

import '../models/thread_model.dart';
import 'package:news/base/app_netcore.dart';

class NewsBloc {
  final _repository = Repository();
  final _articleProvider = ArticleProvider();
  final _homeProvider = HomeProvider();




  // ---------------- HOME ------------------//
  Future<HomeStruct> fetchAllHome() async {
    return await _repository.fetchAllHome();
  }

  Future<List<ClassiFieds>> getClassiFieds() async {
    return await _repository.getClassiFieds();
  }

  Future<List<DailyNewspaper>> getLatestNewspaper() async {
    return await _homeProvider.getLatestNewspaper();
  }

  Future<List<DailyNewspaper>> getLatestSpecialtyNews() async {
    return await _homeProvider.getLatestSpecialtyNews();
  }

  Future<List<DailyNewspaper>> getDailyAndSpecialtyNews() async {
    return await _homeProvider.getDailyAndSpecialtyNews();
  }

  Future<List<TtoNews>> getTtNews() async {
    return await _repository.getTtNews();
  }

  Future<List<Article>> fetchHomePaging(int pageIndex) async {
    return await _repository.getHomePaging(pageIndex);
  }
  // Future<List<ThreadModel>> getThreadPaging(int pageIndex) =>
  //     _homeProvider.fetchThreadsPaging(pageIndex: pageIndex);
  Future<List<ThreadModel>> getThreads({
    int pageIndex = 1,
    int zoneId,
    int threadId,
    String keyword = ''
  }) =>
      _homeProvider.fetchThreadsPaging(
        pageIndex: pageIndex,
        zoneId: zoneId,
        threadId: threadId,
        keyword: keyword,
      );


  Future<List<ThreadModel>> getThreadDetail(int threadId, int pageIndex, ) =>
      _homeProvider.fetchThreadDetail(threadId: threadId,pageIndex: pageIndex);

  Future<List<ThreadModel>> searchThreads(String keyword) =>
      _homeProvider.fetchSearchedThreads(keyword: keyword);


  // Future<ThreadModel> getThreadDetail(String threadId) =>
  //    _homeProvider.fetchThreadDetail(threadId);



  // Future<List<Article>> fetchThreadPaging(int pageIndex) async {
  //   return await _repository.getThreadPaging(pageIndex);
  // }
  // Future<List<Article>> fetchAllThreadsPage(int pageIndex) async {
  //   return await _repository.getThreadPaging(pageIndex);
  // }


  Future<bool> sendTheQuestion(
      String name,
      String email,
      String content,
      TypeQuestion type,
      ) async {
    return await _repository.sendTheQuestion(name, email, content, type);
  }

  // ---------------- ARTICLE ------------------//

  Future<VideoTvoModel> getArticleTvoDetail(String _newsId) async {
    VideoTvoModel article = await _repository.getArticleTvoDetail(_newsId);
    return article;
  }

  Future<String> getUrlVideoTvoDetail(String link) async {
    return await _repository.getUrlVideoTvoDetail(link);
  }

  Future<Article> getArticleDetail(String _newsId) async {
    return await _repository.getArticleDetail(_newsId);
  }

  Future<ArticleNative> getArticleDetailNative(String _newsId) async {
    return await _repository.getArticleDetailNative(_newsId);
  }

  Future<List<Article>> getNewsInterest(String _zoneId) async {
    return await _repository.getNewsInterest(_zoneId);
  }

  Future<List<Article>> getNewsLastest({int page}) async {
    return await _repository.getNewsLastest(page);
  }

  Future<List<Article>> getNewsStars({int page}) async {
    return await _repository.getNewsStars(page);
  }

  Future<List<Article>> getNewstRecommend() async {
    return await _repository.getNewstRecommend();
  }

  Future<List<Article>> getTagNews({String tagUrl}) async {
    return await _repository.getTagNews(tagUrl);
  }

  Future<List<Article>> getAuthorNews({String authorId}) async {
    return await _articleProvider.getAuthorNews(authorId);
  }

  // ---------------- CATEGORY ------------------//
  Future<List<ZoneList>> fetchZoneList() async {
    List<ZoneList> zoneList = await _repository.fetchAllZoneList();
    if (zoneList.length > 0) {
      // remove cate video
      zoneList.removeWhere((item) => item.zoneId == 112794);
    }
    return zoneList;
  }

  Future<List<Article>> fetchVideoList() async {
    List<Article> videoList = await _repository.fetchAllVideoList();
    return videoList;
  }

  Future<List<PodcastModel>> fetchPodcastList() async {
    List<PodcastModel> podcastList = await _repository.fetchAllPostcastList();
    return podcastList;
  }

  Future<List<Article>> fetchListingByZone({String zoneId}) async {
    return await _repository.fetchListingByZone(zoneId);
  }

  Future<List<Article>> fetchZonePaging({String zoneId, int pageIndex}) async {
    return await _repository.fetchZonePaging(zoneId, pageIndex);
  }

  // ---------------- SEARCH ------------------//
  Future<List<Article>> fetchSearchList({
    String keyword,
    int pageIndex = 1,
  }) async {
    return await _repository.fetchAllSearchList(keyword, pageIndex);
  }

  // ---------------- ACCOUNT ------------------//
  Future<List<TTOCommentJSONModel>> newsGetComment(String newsId) async {
    return await _repository.newsGetComment(newsId);
  }

  Future<bool> accountAddComment(TTOAddCommentParams params) async {
    return await _repository.accountAddComment(params);
  }

  // ---------------- DAILY NEWSPAPER ------------------//
  Future<List<Newspaper>> getListPageOfNewsPaper(
      String publishedAt, String appId) =>
      _homeProvider.getListPageOfNewsPaper(publishedAt, appId);

  FutureOr<Newspaper> getPageOfNewsPaper(Newspaper item, int page) =>
      _homeProvider.getPageOfNewsPaper(item, page);

  Future<ListNewspaper> getListNewsPaper(String appId, String page) =>
      _homeProvider.getListNewsPaper(appId, page);
  Future<ListNewspaper> getFirstItemListNewsPaper(String appId) =>
      _homeProvider.getFirstItemListNewsPaper(appId);


}

final bloc = new NewsBloc();
