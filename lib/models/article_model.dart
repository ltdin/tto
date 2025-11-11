import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:news/constant/enum.dart';
import 'package:news/constant/number.dart';
import 'package:news/constant/string.dart';
import 'package:news/api/apis.dart';
import 'package:news/base/app_helpers.dart';
import 'package:news/models/article_native.dart';
import 'package:news/widgets/large_news/big_image_widget.dart';
import 'package:news/widgets/small_news/small_image_type_1.dart';
import 'package:news/widgets/stack_icon_ride_big_image.dart';
import 'package:news/widgets/stack_icon_ride_small_image.dart';

Article articleFromJson(String str) {
  final jsonData = json.decode(str);
  return Article.fromJson(lookup<dynamic>(jsonData, ['data', 'News']));
}

List<Article> searchFromJson(dynamic json) {
  return lookup<List>(json, ['data', 'data'])
          ?.map<Article>((o) => Article.fromJson(o))
          ?.toList() ??
      <Article>[];
}

List<Article> defaultListFromJson(dynamic jsonData) {
  return lookup<List>(jsonData, ['data', 'News'])
          ?.map<Article>((o) => Article.fromJson(o))
          ?.toList() ??
      <Article>[];
}

List<Article> tagsFromJson(dynamic jsonData) {
  return lookup<List>(jsonData, ['data'])
          ?.map<Article>((o) => Article.fromJson(o))
          ?.toList() ??
      <Article>[];
}

List<Article> authorFromJson(dynamic jsonData) {
  return lookup<List>(jsonData, ['data', 'NewsByAuthor'])
          ?.map<Article>((o) => Article.fromJson(o))
          ?.toList() ??
      <Article>[];
}

class Article {
  final String newsId;
  final String title;
  final String avatar;
  final String avatar1;
  final String avatar2;
  final String avatar3;
  final String defaultAvatar;
  final String verticalSpecialAvatar;
  final String url;
  final String urlShare;
  final String zoneId;
  final String zoneName;
  final int commentCount;
  final String body;
  final String distributionDate;
  final String sapo;
  final String urlWebView;
  final String likeCount;
  final int starCount;
  final int heartCount;
  final int type;
  final int typeLive;
  final int isVideo;
  final String audioUrl;

  const Article({
    this.newsId,
    this.title,
    this.avatar,
    this.avatar1,
    this.avatar2,
    this.avatar3,
    this.defaultAvatar,
    this.verticalSpecialAvatar,
    this.url,
    this.urlShare,
    this.zoneId,
    this.zoneName,
    this.commentCount,
    this.body,
    this.distributionDate,
    this.sapo,
    this.urlWebView,
    this.likeCount,
    this.starCount,
    this.heartCount,
    this.type,
    this.typeLive,
    this.isVideo,
    this.audioUrl,
  });

  // Get
  String get getUrlForOpenWebview =>
      isTtoNews ? _getTtoUrlWebview : getTvoUrlVideo;
  bool get isTtoNews => (newsId?.length ?? 0) > 8;
  bool get isTvoNews => isVideo == IS_TVO_NEWS;
  bool get isTtoVideoNews => type == TTO_VIDEO_NEWS;
  bool get isTvoLiveNews =>
      isTvoNews && ((type == TYPE_LIVE_NEWS) ?? false || isTtoLiveNews);
  bool get isTtoLiveNews => (typeLive == TYPE_LIVE_NEWS) ?? false;
  String get getTitle => title ?? '';
  String get getTtoUrl => url ?? KString.TTO_URL;
  String get _getTtoUrlWebview {
    if (url.contains('https'))
      return url.replaceFirst(
        RegExp(
          '${KString.TTO_URL}|${KString.TECH_TTO_URL}|${KString.SPORT_TTO_URL}|${KString.TRAVEL_TTO_URL}',
        ),
        KString.APP_TTO_URL,
      );
    else
      return KString.APP_TTO_URL + url;
  }

  String get getTvoUrlVideo => url ?? KString.TVO_URL;
  bool get avataIsTrue => (avatar != null && avatar.indexOf("http") == 0);
  String get getAvata => avataIsTrue ? avatar : Apis.basePhotoUrl + avatar;
  String get getImageSmall => defaultAvatar ?? getAvata;
  String get getImageLargeType1 =>
      avataIsTrue ? avatar : getUrlImageLarge480x300;
  String get getUrlSpecialImageLarge =>
      Apis.basePhotoUrl600 + verticalSpecialAvatar;
  String get getUrlImageLarge480x300 => Apis.basePhotoUrl480x300 + avatar;
  String get getImageNews => getAvata ?? defaultAvatar;
  bool get isGifImage => getAvata.endsWith('.gif');
  bool get isShowCommentCount =>
      commentCount == null ? false : commentCount > 0;
  String get getShareUrl => urlShare ?? url ?? KString.TTO_URL;
  int get getCommentCount => (commentCount != null) ? commentCount : 0;
  int get getLikeCount =>
      (likeCount?.isNotEmpty ?? false) ? int.tryParse(likeCount) : 0;
  int get getHeart => (heartCount != null) ? heartCount : 0;
  int get getStart => (starCount != null) ? starCount : 0;
  String get getDayMonth {
    if (distributionDate == null) {
      return '';
    }
    final DateTime date = DateTime.parse(distributionDate);
    return DateFormat('dd/MM/yyyy HH:mm').format(date);
  }

  String get getNowFullDay => null;

  // Widgets
  Widget get getSmallImageWidget {
    if (isTvoNews || isTtoVideoNews) {
      return StackIconRideSmallImage(
        type: RideType.LEFTBOTTOM,
        linkImage: getImageSmall,
        rideWidget: Image.asset(
          'assets/images/buttonplay.png',
          width: 24.0,
          height: 24.0,
        ),
      );
    }

    return SmallImageType1(urlImage: getImageSmall);
  }

  Widget get getLargeImageWidget {
    switch (type) {
      case TTO_VIDEO_NEWS:
        return StackIconRideBigImage(
          article: this,
          type: RideType.LEFTBOTTOM,
          rideWidget: Image.asset(
            'assets/images/buttonplay.png',
            width: 24.0,
            height: 24.0,
          ),
        );
        break;
      default:
        return BigImageWidget(urlImage: getImageLargeType1);
        break;
    }
  }

  factory Article.fromJson(Map<String, dynamic> json) {
    if (json == null || (json?.isEmpty ?? false)) {
      return null;
    }

    return Article(
      newsId: lookup<String>(json, ['NewsId']),
      title: lookup<String>(json, ['Title']),
      avatar: lookup<String>(json, ['Avatar']) ?? '',
      defaultAvatar: lookup<String>(json, ['DefaultAvatar']),
      verticalSpecialAvatar:
          lookup<String>(json, ['Avatar5', 'VerticalSpecialAvatar']) ?? '',
      url: lookup<String>(json, ['Url']) ?? '',
      zoneId: lookup<String>(json, ['ZoneId']) ?? '',
      zoneName: lookup<String>(json, ['ZoneName']) ?? '',
      commentCount: lookup<int>(json, ['CommentCount']) ?? 0,
      body: lookup<String>(json, ['Body']),
      distributionDate: lookup<String>(json, ['DistributionDate']) ?? '',
      sapo: lookup<String>(json, ['Sapo']),
      urlWebView: lookup<String>(json, ['UrlWebView']) ?? '',
      likeCount: lookup<String>(json, ['LikeCount']) ?? '0',
      heartCount: lookup<int>(json, ['HeartCount']) ?? 0,
      starCount: lookup<int>(json, ['StarCount']) ?? 0,
      type: lookup<int>(json, ['Type'] ?? 0),
      typeLive: lookup<int>(json, ['TypeLive'] ?? 0),
      isVideo: lookup<int>(json, ['isVideo'] ?? 0),
    );
  }

  Map<String, dynamic> toJson() => {
        "NewsId": newsId,
        "Title": title,
        "Avatar": avatar,
        "DefaultAvatar": defaultAvatar,
        "VerticalSpecialAvatar": verticalSpecialAvatar,
        "Url": url,
        "ZoneId": zoneId,
        "ZoneName": zoneName,
        "CommentCount": commentCount,
        "Body": body,
        "DistributionDate": distributionDate,
        "Sapo": sapo,
        "UrlWebView": urlWebView,
        "LikeCount": likeCount,
        "heartCount": heartCount,
        "starCount": starCount,
        "Type": type,
        "TypeLive": typeLive,
        "isVideo": isVideo,
      };

  ArticleNative toArticleNative() => ArticleNative(
        newsId: newsId,
        title: title,
        avatar: avatar,
        defaultAvatar: avatar,
        url: url,
        urlShare: urlShare,
        shareUrl: urlShare,
        zoneId: zoneId,
        zoneName: zoneName,
        commentCount: commentCount,
        distributionDate: distributionDate,
        sapo: sapo,
        likeCount: likeCount,
        heartCount: heartCount,
        starCount: starCount,
        type: type,
        urlWebView: urlWebView,
        audioUrl: audioUrl,
      );
}
