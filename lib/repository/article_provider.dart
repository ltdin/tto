import 'dart:async';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' show Client;
import 'package:news/api/apis.dart';
import 'package:news/api/http_utility.dart';
import 'package:news/constant/number.dart';
import 'package:news/models/article_model.dart';
import 'package:news/models/article_native.dart';
import 'package:news/models/request_model.dart';
import 'package:news/models/video_tvo_model.dart';

class ArticleProvider {
  final _service = Service();
  final _client = Client();
  static final _headers = {
    "Content-Type": "application/x-www-form-urlencoded",
    'user_agent': Platform.isIOS ? 'ios' : 'android',
  };

  // Get article detail
  Future<Article> fetchArticleDetail(String newsId) async {
    var _body = {'secret_key': Apis.secretKey, 'news_id': newsId};
    try {
      final response = await _client
          .post(
            Uri.tryParse(Apis.articleDetail),
            headers: _headers,
            body: _body,
          )
          .timeout(REQUEST_TIME_OUT);
      if (response.statusCode == 200) {
        return compute(articleFromJson, response.body);
      } else {
        return null;
      }
    } catch (_) {
      return null;
    }
  }

  // Get article detail native
  Future<ArticleNative> fetchArticleDetailNative(String newsId) async {
    var _body = {'secret_key': Apis.secretKey, 'news_id': newsId};

    try {
      final response = await _client
          .post(
            Uri.tryParse(Apis.articleDetailNative),
            headers: _headers,
            body: _body,
          )
          .timeout(REQUEST_TIME_OUT);
      if (response.statusCode == 200) {
        return compute(articleNativeFromJson, response.body);
      } else {
        return null;
      }
    } on dynamic catch (e) {
      print('Error: ${e.toString()}');
      return null;
    }
  }

  // Get new interest
  Future<List<Article>> getNewInterest(String zoneId) async {
    try {
      final request = RequestModel(
        method: Method.POST,
        urlApi: Apis.newsInterest,
        params: {
          'secret_key': Apis.secretKey,
          'zone_id': '0',
          'page_index': '1'
        },
        headers: {},
      );

      final response = await _service.postRequest(request);

      return compute(defaultListFromJson, response);
    } catch (_) {
      return [];
    }
  }

  // Get new lastest
  Future<List<Article>> getNewLastest(int page) async {
    try {
      final request = RequestModel(
        method: Method.POST,
        urlApi: Apis.newsLastest,
        params: {'secret_key': Apis.secretKey, 'page_index': page.toString()},
        headers: {},
      );

      final response = await _service.postRequest(request);

      return compute(defaultListFromJson, response);
    } catch (_) {
      return [];
    }
  }

  // Get new Stars
  Future<List<Article>> getNewStars(int page) async {
    final request = RequestModel(
      method: Method.POST,
      urlApi: Apis.hightViews,
      params: {
        'secret_key': Apis.secretKey,
        'action': "viewsstar",
      },
      headers: {},
    );

    final response = await _service.postRequest(request);

    return compute(defaultListFromJson, response);
  }

  // Get recomend news
  Future<List<Article>> getNewstRecommend() async {
    final request = RequestModel(
      method: Method.POST,
      urlApi: Apis.hightViews,
      params: {
        'secret_key': Apis.secretKey,
        'action': "viewshour36",
      },
      headers: {},
    );

    final response = await _service.postRequest(request);

    return compute(defaultListFromJson, response);
  }

  // Get tag news
  Future<List<Article>> getTagNews(String tagSearch) async {
    final request = RequestModel(
      method: Method.POST,
      urlApi: Apis.searchTag,
      params: {
        'secret_key': Apis.secretKey,
        'page_index': "1",
        'tag_search': tagSearch,
      },
      headers: {},
    );

    final response = await _service.postRequest(request);

    return compute(tagsFromJson, response);
  }

  // Get author news
  Future<List<Article>> getAuthorNews(String authorId) async {
    final request = RequestModel(
      method: Method.POST,
      urlApi: Apis.authorList,
      params: {
        'secret_key': Apis.secretKey,
        'page_index': "1",
        'author_id': authorId,
      },
      headers: {},
    );

    final response = await _service.postRequest(request);

    return compute(authorFromJson, response);
  }

  // POST
  Future<VideoTvoModel> videoTvoDetail({String newsId}) async {
    Client client = Client();

    var _body = {'secret_key': Apis.secretKey, 'video_id': newsId};

    final response = await client
        .post(
          Uri.tryParse(Apis.articleVideoDetail),
          headers: _headers,
          body: _body,
        )
        .timeout(REQUEST_TIME_OUT);

    if (response.statusCode == 200) {
      return compute(videoTvoFromJson, response.body);
    } else {
      return null;
    }
  }

  Future<String> getLinkVideo({String link}) async {
    Client client = Client();

    final response = await client.get(Uri.tryParse(link));
    return compute(urlVideoFromJson, response.body);
  }
}

enum AppError { netWork }
