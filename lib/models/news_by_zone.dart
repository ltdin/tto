import 'package:news/base/app_helpers.dart';
import 'package:news/models/article_model.dart';
import 'package:news/models/zone_model.dart';

class NewsByZone {
  final ZoneList zone;
  final List<ZoneList> subZones;
  final List<Article> data;

  const NewsByZone({this.data, this.zone, this.subZones});

  factory NewsByZone.fromJson(Map<String, dynamic> json) {
    if (json == null || (json?.isEmpty ?? false)) {
      return null;
    }

    return NewsByZone(
      zone: ZoneList.fromJson(lookup<dynamic>(json, ['Zone'])),
      subZones: lookup<List>(json, ['SubZones'])
              ?.map<ZoneList>((o) => ZoneList.fromJson(o))
              ?.toList() ??
          <ZoneList>[],
      data: lookup<List>(json, ['Data'])
              ?.map<Article>((o) => Article.fromJson(o))
              ?.toList() ??
          <Article>[],
    );
  }

  Map<String, dynamic> toJson() => {
        "Zone": zone,
        "Zones": subZones,
        "Data": data,
      };
}
