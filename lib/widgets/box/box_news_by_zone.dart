import 'package:flutter/material.dart';
import 'package:news/constant/number.dart';
import 'package:news/models/news_by_zone.dart';
import 'package:news/widgets/box/item_large_news_by_zone.dart';
import 'package:news/widgets/box/item_small_news_by_zone.dart';

class BoxNewsByZone extends StatelessWidget {
  const BoxNewsByZone({
    Key key,
    @required this.newsByZones,
  }) : super(key: key);

  final List<NewsByZone> newsByZones;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        itemCount: this.newsByZones.length,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, int index) {
          return (index == SECOND_INDEX || index == FOUR_INDEX)
              ? ItemSmallNewsByZone(
                  newsByZones: this.newsByZones[index],
                )
              : ItemLargeNewsByZone(
                  newsByZones: this.newsByZones[index],
                );
        });
  }
}
