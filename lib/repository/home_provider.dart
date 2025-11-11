import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' show Client;
import 'package:news/api/apis.dart';
import 'package:news/api/http_utility.dart';
import 'package:news/base/app_helpers.dart';
import 'package:news/blocs/user_bloc.dart';
import 'package:news/constant/enum.dart';
import 'package:news/constant/number.dart';
import 'package:news/models/article_model.dart';
import 'package:news/models/classifieds.dart';
import 'package:news/models/daily_newspaper.dart';
import 'package:news/models/home_model.dart';
import 'package:news/models/list_newspaper.dart';
import 'package:news/models/newspaper.dart';
import 'package:news/models/request_model.dart';
import 'package:news/models/tto_news.dart';

import '../models/thread_model.dart';

class HomeProvider {
  final _service = Service();
  Client _client = Client();

  static final _headers = {
    "Content-Type": "application/x-www-form-urlencoded",
    'user_agent': Platform.isIOS ? 'ios' : 'android',
  };

  Future<HomeStruct> fetchHomeList() async {
    var _body = {'secret_key': Apis.secretKey};

    try {
      final response = await _client
          .post(
        Uri.parse(Apis.homeData),
        headers: _headers,
        body: _body,
      )
          .timeout(REQUEST_TIME_OUT);

      if (response.statusCode == 200) {
        return compute(homeFromJson, response.body);
      } else {
        return HomeStruct();
      }
    } catch (_) {
      return HomeStruct();
    }
  }

  // ClassiFieds
  Future<List<ClassiFieds>> getClassiFieds() async {
    try {
      final response = await _client
          .get(
        Uri.parse(Apis.classiFieds),
        headers: _headers,
      )
          .timeout(REQUEST_TIME_OUT);

      if (response.statusCode == 200) {
        return compute(classiFiedsFromJson, response.body);
      } else {
        return <ClassiFieds>[];
      }
    } catch (_) {
      return <ClassiFieds>[];
    }
  }

  // DailyNewspaper
  Future<List<DailyNewspaper>> getLatestNewspaper() async {
    try {
      final response = await _client
          .get(
        Uri.parse(Apis.latestNewspaper),
        headers: _headers,
      )
          .timeout(REQUEST_TIME_OUT);
      if (response.statusCode == 200) {
        return compute(dailyNewspaperFromJson, response.body);
      } else {
        return <DailyNewspaper>[];
      }
    } on TimeoutException catch (e) {
      //*printDebug("Error : TimeoutException $e");
      return [];
    } catch (e) {
      return [];
    }
  }

  // GetSpecialtyNews
  Future<List<DailyNewspaper>> getLatestSpecialtyNews() async {
    try {
      final response = await _client.get(
        Uri.parse(Apis.latestSpecialtyNews),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${userBloc.jwtToken}'
        },
      ).timeout(REQUEST_TIME_OUT);

      if (response.statusCode == 200) {
        return compute(dailyNewspaperFromJson, response.body);
      } else {
        return <DailyNewspaper>[];
      }
    } on TimeoutException catch (e) {
      //*printDebug("Error : TimeoutException $e");
      return [];
    } catch (e) {
      return [];
    }
  }

  // Get Daily and Specialty News
  Future<List<DailyNewspaper>> getDailyAndSpecialtyNews() async {
    List<DailyNewspaper> allItems = [];

    try {
      await Future.wait([getLatestNewspaper(), getLatestSpecialtyNews()])
          .then((v) {
        for (var item in v) {
          allItems.addAll(item);
        }
      });

      return allItems;
    } on TimeoutException catch (e) {
      //*printDebug("Error : TimeoutException $e");
      return [];
    } catch (e) {
      return [];
    }
  }

  // GetTtNews
  Future<List<TtoNews>> getTtNews() async {
    try {
      final response = await _client
          .get(
        Uri.parse(Apis.ttNews),
        headers: _headers,
      )
          .timeout(REQUEST_TIME_OUT);

      if (response.statusCode == 200) {
        return compute(ttoNewsFromJson, response.body);
      } else {
        return <TtoNews>[];
      }
    } catch (_) {
      return <TtoNews>[];
    }
  }

  // Get home paging
  Future<List<Article>> fetchHomePagingList(int pageIndex) async {
    var _body = {
      'secret_key': Apis.secretKey,
      'page_index': pageIndex.toString()
    };

    try {
      final response = await _client
          .post(Uri.parse(Apis.homePaging), headers: _headers, body: _body)
          .timeout(REQUEST_TIME_OUT);

      if (response.statusCode == 200) {
        return compute(defaultListFromJson, json.decode(response.body));
      } else {
        return [];
      }
    } catch (_) {
      return [];
    }
  }

  // Future<List<ThreadModel>> fetchThreadsPaging({
  //   int pageIndex = 1,
  //   int zoneId,
  //   int threadId,
  // }) async {
  //   final body = {
  //     'secret_key': Apis.secretKey,
  //     'page_index': pageIndex.toString(),
  //     'page_size': '20',
  //     if (zoneId != null) 'zone_id': zoneId.toString(),
  //     if (threadId != null) 'thread_id': threadId.toString(),
  //   };
  //
  //   final response = await _client
  //       .post(Uri.parse(Apis.threadPaging), headers: _headers, body: body)
  //       .timeout(REQUEST_TIME_OUT);
  //
  //   if (response.statusCode == 200) {
  //     final jsonData = json.decode(response.body);
  //     final List list = jsonData['data']['Thread'];
  //     return list.map((e) => ThreadModel.fromJson(e)).toList();
  //   } else {
  //     throw Exception("Failed to load threads");
  //   }
  // }
  Future<List<ThreadModel>> fetchThreadsPaging({
    int pageIndex = 1,
    int zoneId,
    int threadId,
    String keyword = '',
  }) async {
    final body = {
      'secret_key': Apis.secretKey,
      'page_index': pageIndex.toString(),
      'page_size': '20',
      if (keyword.isNotEmpty) 'keyword': keyword,
    };
    if (zoneId != null) body['zone_id'] = zoneId.toString();
    if (threadId != null) body['thread_id'] = threadId.toString();

    final response = await _client
        .post(Uri.parse(Apis.threadPaging), headers: _headers, body: body)
        .timeout(REQUEST_TIME_OUT);

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      final List list = jsonData['data']['Thread'];
      return list.map((e) => ThreadModel.fromJson(e)).toList();
    } else {
      throw Exception("Failed to load threads");
    }
  }


//tin bài togn chủdde

  Future<List<ThreadModel>> fetchThreadDetail({int pageIndex = 1, int threadId}) async {

    final body = {
      'secret_key': Apis.secretKey,
      'page_index': pageIndex.toString(),
      'page_size': '20',
    };

    final response = await _client
        .post(Uri.parse(Apis.threadPaging), headers: _headers, body: body)
        .timeout(REQUEST_TIME_OUT);

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      final List list = jsonData['data']['Thread'];
      return list.map((e) => ThreadModel.fromJson(e)).toList();
    } else {
      throw Exception("Failed to load threads");
    }
  }
  // Future<ThreadModel> getThreadById(int id) async {
  //   final path = '${Apis.threadPaging}/$id'; // "/threads/123"
  //   final response = await Apis.get(path);
  //
  //   // Nếu response là Map chứa Thread + News
  //   if (response != null && response is Map<String, dynamic>) {
  //     return ThreadModel.fromJson(response);
  //   } else {
  //     throw Exception('Không tìm thấy chủ đề');
  //   }
  // }
  //tìm kiếm chủ đề
  //
  Future<List<ThreadModel>> fetchSearchedThreads({@required String keyword}) async {
    try {
      final body = {
        'secret_key': Apis.secretKey,
        'page_index': '1',
        'page_size': '20',
        'keyword': keyword.trim(),
      };

      final response = await _client
          .post(Uri.parse(Apis.threadPaging), headers: _headers, body: body)
          .timeout(REQUEST_TIME_OUT);

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        final List list = jsonData['data']['Thread'];
        return list.map((e) => ThreadModel.fromJson(e)).toList();
      } else {
        throw Exception('Search failed with status ${response.statusCode}');
      }
    } catch (e) {
      debugPrint('fetchSearchedThreads error: $e');
      return [];
    }
  }





  // SSO update vote reaction
  Future<bool> sendTheQuestion(
      String name,
      String email,
      String content,
      TypeQuestion type,
      ) async {
    final strType = (type == TypeQuestion.HCSK) ? 'listsk' : 'tuvanphapluat';
    final request = RequestModel(
      urlApi: '${Apis.sendTheQuestion}?c=$strType',
      headers: {},
      params: {
        "name": name,
        "email": email,
        "content": content,
        "captcha": '',
      },
    );

    // Connect api
    final result = await _service.postRequest(request);

    return result != null ? true : true;
  }

  // List page of NewsPaper
  Future<List<Newspaper>> getListPageOfNewsPaper(
      String publishedAt, String appId) async {
    final request = RequestModel(
      urlApi: '${Apis.detailDailyNewsPaper}',
      headers: {},
      params: {
        "published_at": publishedAt,
        "total_item": '100',
        "app_id": appId,
        "token": userBloc.jwtToken,
      },
    );

    // Call api
    final response = await _service.postRequest(request);

    if (response != null) {
      return compute(listNewspaperFromJson, response);
    } else {
      return <Newspaper>[];
    }
  }

  // Get page of NewsPaper
  FutureOr<Newspaper> getPageOfNewsPaper(Newspaper item, int page) async {
    final request = RequestModel(
      urlApi: '${Apis.detailDailyNewsPaper}',
      headers: {},
      params: {
        "published_at": item.getDayMiliSeconds,
        "current_page": page.toString(),
        "app_id": item.getAppId,
        "token": userBloc.jwtToken,
      },
    );

    // Call api
    final response = await _service.postRequest(request);

    if (response != null) {
      final list = await compute(newspaperFromJson, response);
      return list.elementAt(0);
    } else {
      return Newspaper();
    }
  }

  // Get list NewsPaper
  Future<ListNewspaper> getListNewsPaper(String appId, String page) async {
    final request = RequestModel(
      urlApi: '${Apis.listNewspaper}',
      headers: {},
      params: {
        "member_id": userBloc.userInfo.getId,
        "app_id": appId,
        "current_page": page,
        "total_item": '8',
      },
    );

    // Call api
    final response = await _service.postRequest(request);

    if (response != null) {
      return ListNewspaper.fromJson(response['data']);
    } else {
      return ListNewspaper.emplty();
    }
  }

  // Get the first icon in list NewsPaper
  Future<ListNewspaper> getFirstItemListNewsPaper(String appId) async {
    final request = RequestModel(
      urlApi: '${Apis.listNewspaper}',
      headers: {},
      params: {
        "member_id": userBloc.userInfo.getId,
        "app_id": appId,
        "current_page": '1',
        "total_item": '1',
      },
    );

    // Call api
    final response = await _service.postRequest(request);

    if (response != null) {
      return ListNewspaper.fromJson(response['data']);
    } else {
      return ListNewspaper.emplty();
    }
  }
}
