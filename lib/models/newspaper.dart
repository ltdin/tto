import 'package:news/base/app_helpers.dart';

List<Newspaper> listNewspaperFromJson(dynamic str) {
  return lookup<List>(str, ['data', 'list'])
          ?.map<Newspaper>((o) => Newspaper.fromJson(o))
          ?.toList() ??
      <Newspaper>[];
}

List<Newspaper> newspaperFromJson(dynamic str) {
  return lookup<List>(str, ['data', 'list'])
          ?.map<Newspaper>((o) => Newspaper.fromJson(o))
          ?.toList() ??
      <Newspaper>[];
}

class Newspaper {
  final int id;
  final int publishedAt;
  final int dateRead;
  final String type;
  final int pageNumber;
  final String author;
  final String appId;
  final Resource resource;

  const Newspaper({
    this.id,
    this.publishedAt,
    this.dateRead,
    this.type,
    this.pageNumber,
    this.author,
    this.appId,
    this.resource,
  });

  // Get
  String get getUrlImage => resource?.getUrlImage;
  String get getDayMiliSeconds =>
      publishedAt != null ? publishedAt.toString() : getDateRead;
  String get getAppId => appId.toString();
  String get getDateRead => dateRead.toString();
  String get getStrDayFromMiliSeconds =>
      AppHelpers.getStrDayFromMiliSeconds(int.tryParse(getDayMiliSeconds));

  factory Newspaper.fromJson(Map<String, dynamic> json) => Newspaper(
        id: json["id"],
        publishedAt: json["published_at"],
        type: json["type"],
        pageNumber: json["page_number"],
        author: json["author"],
        appId: lookup<String>(json, ['app_id'] ?? ''),
        resource: Resource.fromJson(json["resource"]),
      );

  factory Newspaper.fromListNewspaperJson(Map<String, dynamic> json) =>
      Newspaper(
        id: json["id"],
        publishedAt: json["published_at"],
        dateRead: json["date_read"],
        type: json["type"],
        pageNumber: json["page_number"],
        author: json["author"],
        appId: lookup<String>(json, ['app_id'] ?? ''),
        resource: Resource.fromJson(json['thumbnail']),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "published_at": publishedAt,
        "type": type,
        "page_number": pageNumber,
        "author": author,
        "app_id": appId,
        "resource": resource.toJson(),
      };
}

class Resource {
  const Resource({this.id, this.type, this.name, this.status, this.path});

  final int id;
  final String type;
  final String name;
  final int status;
  final String path;

  factory Resource.fromJson(Map<String, dynamic> json) => Resource(
        id: lookup<int>(json, ['id'] ?? 0),
        type: lookup<String>(json, ['type'] ?? ''),
        name: lookup<String>(json, ['name'] ?? ''),
        status: lookup<int>(json, ['status'] ?? 0),
        path: lookup<String>(json, ['path'] ?? ''),
      );

  // Get
  String get getUrlImage => path ?? '';

  Map<String, dynamic> toJson() => {
        "id": id,
        "type": type,
        "name": name,
        "status": status,
        "path": path,
      };
}
