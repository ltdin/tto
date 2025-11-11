import 'package:news/constant/string.dart';

class Tag {
  const Tag({this.id, this.name, this.url});

  final int id;
  final String name;
  final String url;

  // Get
  String get getUrlTag => '${KString.TTO_URL}/$url.html';
  String get getTagSearch => url;
  String get getTagName => name ?? getTagSearch;
  bool get isUrl => url.endsWith("htm");

  factory Tag.fromJson(Map<String, dynamic> json) => Tag(
        id: json["Id"],
        name: json["Name"],
        url: json["Url"],
      );

  Map<String, dynamic> toJson() => {"Id": id, "Name": name, "Url": url};
}
