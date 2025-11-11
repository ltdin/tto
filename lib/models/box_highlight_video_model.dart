import 'package:news/base/app_helpers.dart';
import 'package:news/models/article_model.dart';
import 'package:news/models/video_tvo_model.dart';
import 'package:news/models/zone_model.dart';

class BoxHighlightVideoModel {
  final List<VideoTvoModel> videos;
  final List<ZoneList> zones;

  const BoxHighlightVideoModel({this.videos, this.zones});

  factory BoxHighlightVideoModel.fromJson(Map<String, dynamic> json) {
    if (json == null || (json?.isEmpty ?? false)) {
      return null;
    }

    return BoxHighlightVideoModel(
      videos: lookup<List>(json, ['Data'])
              ?.map<VideoTvoModel>((o) => VideoTvoModel.fromJson(o))
              ?.toList() ??
          <Article>[],
      zones: lookup<List>(json, ['Zones'])
              ?.map<ZoneList>((o) => ZoneList.fromJson(o))
              ?.toList() ??
          <ZoneList>[],
    );
  }

  Map<String, dynamic> toJson() => {
        "Data": videos,
        "Zones": zones,
      };
}
