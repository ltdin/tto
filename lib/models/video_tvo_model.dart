import 'dart:convert';
import 'package:news/base/app_helpers.dart';
import 'package:news/constant/number.dart';
import 'package:news/constant/string.dart';
import 'package:news/models/article_model.dart';

VideoTvoModel videoTvoFromJson(String str) {
  final jsonData = json.decode(str);
  return VideoTvoModel.fromJson(lookup<dynamic>(jsonData, ['data', 'Videos']));
}

// String urlVideoFromJson(String str) {
//   final jsonData = json.decode(str);
//   String urlVideo = '';

//   final urlHtml5 = lookup<String>(jsonData, ['html5', 0]) ?? '';
//   if (urlHtml5?.isNotEmpty ?? false) {
//     urlVideo = urlHtml5;
//   } else {
//     urlVideo = lookup<String>(jsonData, ['mp4']) ?? '';
//   }

//   return urlVideo;
// }
String urlVideoFromJson(String str) {
  final jsonData = json.decode(str);
  String urlVideo = '';

  if (jsonData.containsKey('mhls') && jsonData['mhls'].isNotEmpty) {
    urlVideo = jsonData['mhls']; // Ưu tiên mhls nếu có
  } else if (jsonData.containsKey('hls') && jsonData['hls'].isNotEmpty) {
    urlVideo = jsonData['hls']; // Nếu không có mhls thì lấy hls
  } else if (jsonData['html5'] != null && jsonData['html5'] is List && jsonData['html5'].isNotEmpty) {
    urlVideo = jsonData['html5'][0]; // Nếu không có hls, lấy html5
  } else {
    urlVideo = jsonData['mp4'] ?? ''; // Nếu không có gì, fallback về mp4
  }

  return urlVideo;
}
class VideoTvoModel {
  const VideoTvoModel({
    this.newsId,
    this.title,
    this.avatar,
    this.url,
    this.sapo,
    this.hlsInfo,
    this.videoRelations,
  });

  final String newsId;
  final String title;
  final String avatar;
  final String url;
  final String sapo;
  final String hlsInfo;
  final List<VideoTvoModel> videoRelations;

  // Get , set
  String get videoID => newsId;
  String get getUrlVideo => url ?? KString.TVO_URL;
  String get getTitle => title ?? '';

  factory VideoTvoModel.fromJson(Map<String, dynamic> json) {
    if (json == null) {
      return null;
    }
    return VideoTvoModel(
      newsId: lookup<String>(json, ['NewsId']) ?? '',
      title: lookup<String>(json, ['Name']) ??
          lookup<String>(json, ['Title']) ??
          '',
      avatar: lookup<String>(json, ['Avatar']) ?? '',
      url: lookup<String>(json, ['Url']) ?? '',
      sapo: lookup<String>(json, ['Description']) ??
          lookup<String>(json, ['Sapo']) ??
          '',
      hlsInfo: lookup<String>(json, ['HLSInfo']) ?? '',
      videoRelations: lookup<List>(json, ['VideoRelation'])
              ?.map<VideoTvoModel>((o) => VideoTvoModel.fromJson(o))
              ?.toList() ??
          <VideoTvoModel>[],
    );
  }

  Map<String, dynamic> toJson() => {
        "NewsId": newsId,
        "Name": title,
        "Avatar": avatar,
        "Url": url,
        "Description": sapo,
        "HLSInfo": hlsInfo,
        "VideoRelation": videoRelations,
      };

  Article toArticle() => Article(
        newsId: newsId,
        title: title,
        avatar: avatar,
        url: url,
        sapo: sapo,
        type: TTO_VIDEO_NEWS,
      );
}
