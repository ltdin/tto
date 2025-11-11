import 'package:flutter/material.dart';
import 'package:news/constant/font.dart';
import 'package:news/constant/length.dart';
import 'package:news/models/zone_model.dart';
import 'package:news/widgets/box/title_zone.dart';

class TitleZoneListSubCategory extends StatelessWidget {
  const TitleZoneListSubCategory({
    Key key,
    @required this.subZones,
    @required this.zoneName,
    this.onTapItemZone,
  }) : super(key: key);

  final List<ZoneList> subZones;
  final String zoneName;
  final ValueChanged<ZoneList> onTapItemZone;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Title zone
        Padding(
          padding: EdgeInsets.only(bottom: paddingNewsSapo),
          child: TitleZone(zoneName: zoneName),
        ),

        // List sub category
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: List.generate(
              this.subZones.length,
              (i) => Padding(
                padding: const EdgeInsets.only(right: paddingNewsTitle),
                child: InkWell(
                  child: Text(
                    this.subZones[i].name ?? '',
                    style: KfontConstant.styleOfListCategory,
                  ),
                  onTap: () => onTapItemZone != null
                      ? onTapItemZone.call(this.subZones[i])
                      : null,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
