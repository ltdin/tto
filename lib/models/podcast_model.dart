import 'package:news/base/app_helpers.dart';
import 'package:news/constant/string.dart';
import 'package:news/models/article_model.dart';

class PodcastModel {
  final String audioId;
  final String avatar;
  final String zoneId;
  final String zoneName;
  final String title;
  final String sapo;
  final String url;
  final String distributionDate;
  final int type;
  final String author;
  final String filemp3;
  final String mobileAvatar;

  const PodcastModel({
    this.audioId,
    this.avatar,
    this.zoneId,
    this.zoneName,
    this.title,
    this.sapo,
    this.url,
    this.distributionDate,
    this.type,
    this.author,
    this.filemp3,
    this.mobileAvatar,
  });

  //
  String get getTitle => title ?? '';
  String get getUrl => url ?? KString.PODCAST_URL;
  String get getAvata => avatar ?? mobileAvatar ?? '';

  factory PodcastModel.fromJson(Map<String, dynamic> json) {
    if (json == null || (json?.isEmpty ?? false)) {
      return null;
    }
    return PodcastModel(
      audioId: lookup<String>(json, ['AudioId']),
      avatar: lookup<String>(json, ['Avatar']),
      zoneId: lookup<String>(json, ['ZoneId']) ?? '',
      zoneName: lookup<String>(json, ['ZoneName']) ?? '',
      title: lookup<String>(json, ['Title']),
      sapo: lookup<String>(json, ['Sapo']),
      url: lookup<String>(json, ['Url']) ?? '',
      distributionDate: lookup<String>(json, ['DistributionDate']) ?? '',
      type: lookup<int>(json, ['Type'] ?? 0),
      author: lookup<String>(json, ['Author']) ?? '',
      filemp3: lookup<String>(json, ['FileName']) ?? '',
      mobileAvatar: lookup<String>(json, ['MobileAvatar']),
    );
  }

  String get timeCreateNews =>
      ('Tin mới | ' + distributionDate.substring(0, 10)).toUpperCase();

  Article get toArticle => Article(
        newsId: audioId ?? '',
        zoneId: zoneId ?? '',
        zoneName: zoneName ?? '',
        title: title ?? '',
        avatar: avatar ?? '',
        defaultAvatar: avatar ?? '',
        url: url ?? '',
      );

  Map<String, dynamic> toJson() => {
        "AudioId": audioId,
        "Title": title,
        "Sapo": sapo,
        "Avatar": avatar,
        "Url": url,
        "ZoneId": zoneId,
        "ZoneName": zoneName,
        "CommentCount": filemp3,
        "DistributionDate": distributionDate,
        "Type": type,
        "Author": author,
        "FileName": filemp3,
        "MobileAvatar": mobileAvatar,
      };
}
