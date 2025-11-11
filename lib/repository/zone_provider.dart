import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' show Client;
import 'package:news/api/apis.dart';
import 'package:news/models/article_model.dart';
import 'package:news/models/video_model.dart';
import 'package:news/models/zone_model.dart';

class ZoneProvider {
  Client client = Client();
  static final _headers = {
    "Content-Type": "application/x-www-form-urlencoded",
    'user_agent': Platform.isIOS ? 'ios' : 'android',
  };

  Future<List<ZoneList>> fetchZoneList() async {
    var _body = {'secret_key': Apis.secretKey};

    final response = await client.post(Uri.tryParse(Apis.zoneList),
        headers: _headers, body: _body);
    if (response.statusCode == 200) {
      return compute(zoneFromJson, response.body);
    } else {
      throw Exception('Failed to Load');
    }
  }

  // zone paging
  Future<List<Article>> fetchZonePaging(String zoneId, int page) async {
    var _body = {
      'secret_key': Apis.secretKey,
      'zone_id': zoneId,
      'page_index': page.toString()
    };

    final response = await client.post(
      Uri.tryParse(Apis.zoneListPaging),
      headers: _headers,
      body: _body,
    );

    if (response.statusCode == 200) {
      return compute(defaultListFromJson, json.decode(response.body));
    } else {
      return null;
    }
  }

  // get list video
  Future<List<Article>> fetchVideoList() async {
    var _body = {'secret_key': Apis.secretKey};

    final response = await client.post(Uri.tryParse(Apis.videoList),
        headers: _headers, body: _body);
    if (response.statusCode == 200) {
      return compute(videoListFromJson, response.body);
    } else {
      throw Exception('Failed to Load');
    }
  }
}
