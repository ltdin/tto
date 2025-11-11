import 'package:flutter/material.dart';
import 'package:news/constant/color.dart';
import 'package:news/constant/enum.dart';
import 'package:news/constant/font.dart';
import 'package:news/constant/length.dart';
import 'package:news/models/box_highlight_video_model.dart';
import 'package:news/models/zone_model.dart';
import 'package:news/pages/detail/page_detail_webview_custom_tab.dart';
import 'package:news/widgets/ariticle_detail/push_to_detail.dart';
import 'package:news/widgets/box/item_small_video_style_1.dart';
import 'package:news/widgets/box/title_zone_list_sub_category.dart';
import 'package:news/widgets/divider_widget.dart';
import 'package:news/widgets/stack_icon_ride_big_image.dart';

class BoxHighlightVideo extends StatelessWidget {
  const BoxHighlightVideo({
    Key key,
    @required this.boxHighlightVideo,
  }) : super(key: key);

  final BoxHighlightVideoModel boxHighlightVideo;

  @override
  Widget build(BuildContext context) {
    final first = this.boxHighlightVideo.videos.first.toArticle() ?? null;
    final subVideos = this.boxHighlightVideo.videos.sublist(1) ?? [];

    return ColoredBox(
      color: cardNewsBackgroundColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DividerWidget(isSolid: true),

          // Title zone + List sub category
          TitleZoneListSubCategory(
            subZones: boxHighlightVideo.zones,
            zoneName: 'Video',
            onTapItemZone: _onTapItemZone,
          ),

          DividerWidget(isSolid: true),

          // News topic
          if (first != null)
            InkWell(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
          if (subVideos.isNotEmpty ?? false)
            Container(
              height: heightSmallNews220,
              width: double.maxFinite,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: List.generate(
                  subVideos.length,
                  (i) => Container(
                    width: widthSmallImage180,
                    padding: EdgeInsets.only(
                      right: i != subVideos.length - 1 ? paddingNews : 0.0,
                    ),
                    child:
                        ItemSmallVideoStyle1(article: subVideos[i].toArticle()),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  void _onTapItemZone(ZoneList zoneList) {
    PageDetailWebviewCustomTab.launch(url: zoneList.getUrlTVO);
  }
}
