import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:news/api/apis.dart';
import 'package:news/api/http_utility.dart';
import 'package:news/models/article_model.dart';
import 'package:news/models/request_model.dart';

class SearchProvider {
  final _service = Service();

  Future<List<Article>> fetchSearchList(String keyword, int pageIndex) async {
    try {
      final request = RequestModel(
        method: Method.POST,
        urlApi: Apis.searchList,
        params: {
          'secret_key': Apis.secretKey,
          'key_word': keyword.toString(),
          'page_index': pageIndex.toString()
        },
        headers: {},
      );

      final response = await _service.postRequest(request);

      return compute(searchFromJson, response);
    } catch (_) {
      return [];
    }
  }
}
