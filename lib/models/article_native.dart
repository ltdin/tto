import 'dart:convert';
import 'package:diacritic/diacritic.dart';
import 'package:news/constant/number.dart';
import 'package:news/constant/string.dart';
import 'package:news/models/article_model.dart';
import 'package:news/models/body_row.dart';
import 'package:news/models/tag.dart';
import 'package:news/util/avatar_util.dart';
import 'package:news/api/apis.dart';
import 'package:news/base/app_helpers.dart';

ArticleNative articleNativeFromJson(String str) {
  final jsonData = json.decode(str);

  return ArticleNative.fromJson(lookup<dynamic>(jsonData, ['data', 'News']));
}

class ArticleNative {
  final String newsId;
  final String title;
  final String avatar;
  final String defaultAvatar;
  final String url;
  final String urlShare;
  final String shareUrl;
  final String zoneId;
  final String zoneName;
  final int commentCount;
  final List<BodyRow> body;
  final List<Article> newsRelation;
  final List<Tag> tags;
  final String distributionDate;
  final String sapo;
  final String author;
  final int type;
  final int webViewType;
  final String urlWebView;
  final String audioUrl;
  final int starCount;
  final int heartCount;
  final String likeCount;

  const ArticleNative({
    this.newsId,
    this.title,
    this.avatar,
    this.defaultAvatar,
    this.url,
    this.urlShare,
    this.shareUrl,
    this.zoneId,
    this.zoneName,
    this.commentCount,
    this.body,
    this.newsRelation,
    this.tags,
    this.distributionDate,
    this.sapo,
    this.author,
    this.type,
    this.webViewType = IS_NOT_WEBVIEW_TYPE,
    this.urlWebView,
    this.audioUrl,
    this.starCount,
    this.heartCount,
    this.likeCount,
  });

  factory ArticleNative.fromJson(Map<String, dynamic> json) {
    if (json == null || (json?.isEmpty ?? false)) {
      return null;
    }

    return ArticleNative(
      newsId: lookup<String>(json, ['NewsId']),
      title: lookup<String>(json, ['Title']),
      avatar: AvatarUtil.avatarGifToPng(
        (json["Avatar"] != null && json["Avatar"].indexOf("http") == 0)
            ? json["Avatar"].toString()
            : Apis.basePhotoUrl + json["Avatar"].toString(),
      ),
      defaultAvatar:
          AvatarUtil.avatarGifToPng(lookup<String>(json, ['DefaultAvatar'])) ??
              '',
      url: lookup<String>(json, ['Url']) ?? '',
      urlShare: lookup<String>(json, ['UrlShare']),
      shareUrl: lookup<String>(json, ['ShareUrl']),
      zoneId: lookup<String>(json, ['ZoneId']) ?? '',
      zoneName: lookup<String>(json, ['ZoneName']) ?? '',
      commentCount: lookup<int>(json, ['CommentCount']) ?? 0,
      body: lookup<List>(json, ['Body'])
              ?.map<BodyRow>((o) => BodyRow.fromJson(o))
              ?.toList() ??
          <BodyRow>[],
      newsRelation: lookup<List>(json, ['NewsRelation'])
              ?.map<Article>((o) => Article.fromJson(o))
              ?.toList() ??
          <Article>[],
      tags: lookup<List>(json, ['Tags'])
              ?.map<Tag>((o) => Tag.fromJson(o))
              ?.toList() ??
          <Tag>[],
      distributionDate: lookup<String>(json, ['DistributionDate']) ?? '',
      author: lookup<String>(json, ['Author']) ?? '',
      sapo: lookup<String>(json, ['Sapo']) ?? '',
      likeCount: lookup<String>(json, ['LikeCount']) ?? '0',
      heartCount: lookup<int>(json, ['HeartCount']) ?? 0,
      starCount: lookup<int>(json, ['StarCount']) ?? 0,
      type: lookup<int>(json, ['Type'] ?? 0),
      webViewType: lookup<int>(json, ['WebViewType'] ?? IS_NOT_WEBVIEW_TYPE),
      urlWebView: lookup<String>(json, ['UrlWebView']) ?? KString.TTO_URL,
      audioUrl: lookup<String>(json, ['AudioUrl'] ?? ''),
    );
  }

  Map<String, dynamic> toJson() => {
        "NewsId": newsId,
        "Title": title,
        "Avatar": avatar,
        "DefaultAvatar": defaultAvatar,
        "Url": url,
        "UrlShare": urlShare,
        "ZoneId": zoneId,
        "ZoneName": zoneName,
        "CommentCount": commentCount,
        "Body": body,
        "DistributionDate": distributionDate,
        "Author": author,
        "Sapo": sapo,
        "LikeCount": likeCount,
        "HeartCount": heartCount,
        "StarCount": starCount,
        "Type": type,
        "WebViewType": webViewType,
        "UrlWebView": urlWebView,
        "AudioUrl": audioUrl,
        "Tags": tags,
      };

  Article toArticle() => Article(
        newsId: newsId,
        title: title,
        avatar: avatar,
        defaultAvatar: avatar,
        url: url,
        urlShare: urlShare,
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

  // Get
  String get getStrTags {
    if (tags == null) {
      return '';
    }

    List<String> listStrTags = tags.map((model) => model.getTagName).toList();
    return listStrTags.join(';');
  }

  String get getShareUrl => shareUrl ?? urlShare ?? '';
  String get getPageCategory => zoneName != null
      ? removeDiacritics(zoneName?.replaceAll(' ', '-')).toLowerCase()
      : '';
}
