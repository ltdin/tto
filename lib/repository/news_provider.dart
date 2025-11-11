import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' show Client;
import 'package:news/api/apis.dart';
import 'package:news/models/comment_model.dart';

class TTONewsProvider {
  Client client = Client();
  static final _headers = {
    "Content-Type": "application/x-www-form-urlencoded",
    'user_agent': Platform.isIOS ? 'ios' : 'android',
  };

  /// Get list comments of news
  Future<List<TTOCommentJSONModel>> newsGetComment(String newsId) async {
    var _body = {'secret_key': Apis.secretKey, 'news_id': newsId};

    final response = await client.post(
      Uri.tryParse(Apis.newsGetComment),
      headers: _headers,
      body: _body,
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> responseData = json.decode(response.body);
      if (responseData["status"] == 1) {
        List<TTOCommentJSONModel> commentJSONModels =
            List<TTOCommentJSONModel>.from(
          responseData["data"].map((json) {
            TTOCommentJSONModel jsonModel = TTOCommentJSONModel.fromJson(json);
            return jsonModel;
          }),
        );

        return commentJSONModels;
      }

      return [];
    } else {
      throw Exception('Failed to Load');
    }
  }
}
