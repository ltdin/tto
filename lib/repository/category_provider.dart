import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' show Client;
import 'package:news/api/apis.dart';
import 'package:news/base/app_helpers.dart';
import 'package:news/constant/number.dart';
import 'package:news/models/article_model.dart';
import 'package:news/models/podcast_model.dart';
import 'package:news/models/video_model.dart';
import 'package:news/models/zone_model.dart';

class CategoryProvider {
  Client client = Client();
  static final _headers = {
    "Content-Type": "application/x-www-form-urlencoded",
    'user_agent': Platform.isIOS ? 'ios' : 'android',
  };

  Future<List<ZoneList>> fetchZoneList() async {
    var _body = {'secret_key': Apis.secretKey};

    final response = await client.post(
      Uri.tryParse(Apis.zoneList),
      headers: _headers,
      body: _body,
    );
    if (response.statusCode == 200) {
      return compute(zoneFromJson, response.body);
    } else {
      throw Exception('Failed to Load');
    }
  }

  // Get list video
  Future<List<Article>> fetchVideoList() async {
    var _body = {'secret_key': Apis.secretKey};

    try {
      final response = await client.post(
        Uri.tryParse(Apis.videoList),
        headers: _headers,
        body: _body,
      );
      if (response.statusCode == 200) {
        return compute(videoListFromJson, response.body);
      } else {
        return [];
      }
    } catch (_) {
      return [];
    }
  }

  // Get Podcast list
  Future<List<PodcastModel>> fetchPodcastList() async {
    var _body = {'secret_key': Apis.secretKey};

    try {
      final response = await client.post(
        Uri.tryParse(Apis.podcastList),
        headers: _headers,
        body: _body,
      );

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);

        // Parse list Podcast
        final List<PodcastModel> podcasts =
            lookup<List>(jsonData, ['data', 'Podcast'])
                    ?.map<PodcastModel>((o) => PodcastModel.fromJson(o))
                    ?.toList() ??
                <PodcastModel>[];

        return podcasts;
      } else {
        return [];
      }
    } catch (_) {
      return [];
    }
  }

  // Get listing by zone
  Future<List<Article>> fetchListingByZone(String zoneId) async {
    final _body = {
      'secret_key': Apis.secretKey,
      'zone_id': zoneId.toString(),
    };

    try {
      final response = await client
          .post(
            Uri.tryParse(Apis.listingByZone),
            headers: _headers,
            body: _body,
          )
          .timeout(REQUEST_TIME_OUT);

      if (response.statusCode == 200) {
        final zoneStruct = await compute(listingByZoneFromJson, response.body);
        final listNews = zoneStruct?.listArticle ?? [];
        return listNews;
      } else {
        throw Exception('Failed to Load');
      }
    } catch (_) {
      printDebug('Catch response ' + Apis.listingByZone);
      return null;
    }
  }
}
