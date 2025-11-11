import 'package:news/base/app_helpers.dart';
import 'package:news/models/article_model.dart';
import 'package:news/models/zone_model.dart';

class ZoneData {
  final ZoneList zone;
  final List<Article> datas;

  const ZoneData({this.datas, this.zone});

  factory ZoneData.fromJson(Map<String, dynamic> json) {
    if (json == null || (json?.isEmpty ?? false)) {
      return null;
    }

    return ZoneData(
      zone: ZoneList.fromJson(lookup<dynamic>(json, ['Zone'])),
      datas: lookup<List>(json, ['Data'])
              ?.map<Article>((o) => Article.fromJson(o))
              ?.toList() ??
          <Article>[],
    );
  }

  ZoneData copyWith({ZoneList zone, List<Article> datas}) {
    return ZoneData(
      zone: zone ?? this.zone,
      datas: datas ?? this.datas,
    );
  }

  Map<String, dynamic> toJson() => {
        "Zone": zone,
        "Data": datas,
      };
}
