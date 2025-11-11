import 'package:news/api/apis.dart';
import 'package:news/base/app_helpers.dart';

class ClassiFieds {
  const ClassiFieds({
    this.title,
    this.thumb,
    this.url,
    this.price,
    this.location,
  });

  final String title;
  final String thumb;
  final String url;
  final String price;
  final String location;

  // Get
  String get getTitle => title ?? "";
  String get getUrl => url ?? Apis.raovat;
  String get getPrice => price ?? "Liên hệ chi tiết ";

  factory ClassiFieds.fromJson(Map<String, dynamic> json) {
    if (json == null || (json?.isEmpty ?? false)) {
      return null;
    }

    return ClassiFieds(
      title: lookup<String>(json, ['title']) ?? '',
      thumb: lookup<String>(json, ['thumb']) ?? '',
      url: lookup<String>(json, ['url']) ?? '',
      price: lookup<String>(json, ['price']) ?? '',
      location: lookup<String>(json, ['location']) ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        "title": title,
        "thumb": thumb,
        "url": url,
        "price": price,
        "location": location,
      };
}
