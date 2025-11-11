import 'package:flutter/material.dart';
import 'package:news/constant/color.dart';
import 'package:news/constant/enum.dart';
import 'package:news/constant/font.dart';
import 'package:news/constant/length.dart';
import 'package:news/models/play_list.dart';
import 'package:news/widgets/ariticle_detail/push_to_detail.dart';
import 'package:news/widgets/box/item_small_video_style_1.dart';
import 'package:news/widgets/stack_icon_ride_big_image.dart';

class BoxPlaylist extends StatelessWidget {
  const BoxPlaylist({
    Key key,
    @required this.playList,
  }) : super(key: key);

  final PlayList playList;

  @override
  Widget build(BuildContext context) {
    final first = this.playList.articles.first ?? null;
    final subArticles = this.playList.articles.sublist(1) ?? [];

    return ColoredBox(
      color: cardNewsBackgroundColor,
      child: Column(
        children: [
          // News topic
          if (first != null)
            InkWell(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Topic
                  Padding(
                    padding: EdgeInsets.only(
                      top: paddingNews,
                      bottom: paddingNewsSapo / 2,
                    ),
                    child: Text(
                      playList?.topic ?? 'Chủ đề',
                      textAlign: TextAlign.start,
                      style: KfontConstant.styleOfTitleLargeType2,
                    ),
                  ),

                  // Image
                  StackIconRideBigImage(
                    article: first,
                    type: RideType.LEFTBOTTOM,
                    rideWidget: Image.asset(
                      'assets/images/buttonplay.png',
                      width: 24.0,
                      height: 24.0,
                    ),
                  ),

                  // Sapo
                  Padding(
                    padding: EdgeInsets.only(
                      top: paddingNewsSapo / 2,
                      bottom: paddingNews,
                    ),
                    child: Text(
                      first.getTitle,
                      style: KfontConstant.styleOfTitleLargeType2,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              onTap: () => pushToDetail(article: first, context: context),
            ),

          // List video horizontal
          if (subArticles.isNotEmpty ?? false)
            Container(
              height: heightSmallNews220,
              width: double.maxFinite,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: List.generate(
                  subArticles.length,
                  (i) => Container(
                    width: widthSmallImage180,
                    padding: EdgeInsets.only(
                      right: i != subArticles.length - 1 ? paddingNews : 0.0,
                    ),
                    child: ItemSmallVideoStyle1(article: subArticles[i]),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
