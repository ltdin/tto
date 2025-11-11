import 'package:news/api/apis.dart';
import 'package:news/base/app_helpers.dart';

class DailyNewspaper {
  const DailyNewspaper({
    this.thumbnailUrl,
    this.appId,
    this.publishedAt,
    this.soBao,
    this.isBought = true,
  });

  final String thumbnailUrl;
  final int appId;
  final int publishedAt;
  final String soBao;
  final bool isBought;

  // Get
  String get getUrlWithToken {
    return '$appId';
  }

  String get getHomeUrlWithToken {
    return '${Apis.nhatbao}';
  }

  String get getStrPublishedAt => publishedAt.toString();
  String get getStrAppId => appId.toString();
  int get getIntPublishedAt => publishedAt;
  bool get isHideDacSan => appId == 18 && isBought == false;
  bool get isDacSan => appId == 18;

  factory DailyNewspaper.fromJson(Map<String, dynamic> json) => DailyNewspaper(
        thumbnailUrl: json["thumbnail"],
        appId: json["app_id"],
        publishedAt: json["published_at"],
        soBao: json["issue"],
        isBought: lookup<bool>(json, ['is_bought']) ?? false,
      );

  Map<String, dynamic> toJson() => {
        "thumbnail": thumbnailUrl,
        "app_id": appId,
        "published_at": publishedAt,
        "issue": soBao,
        "is_bought": isBought,
      };
}
