import 'package:extended_nested_scroll_view/extended_nested_scroll_view.dart';
import 'package:flutter/material.dart' hide NestedScrollView;
import 'package:news/ads/ad_banner_123.dart';
import 'package:news/constant/length.dart';
import 'package:news/constant/number.dart';
import 'package:news/models/home_model.dart';
import 'package:news/widgets/advertising/admod_banner.dart';
import 'package:news/widgets/app_loading.dart';
import 'package:news/widgets/box/box_banner_baucumy.dart';
import 'package:news/widgets/box/box_bottom_widget.dart';
import 'package:news/widgets/box/box_classifieds_widget.dart';
import 'package:news/widgets/box/box_daily_newspape.dart';
import 'package:news/widgets/box/box_health_bylaw_widget.dart';
import 'package:news/widgets/box/box_highlight_video.dart';
import 'package:news/widgets/box/box_news_by_zone.dart';
import 'package:news/widgets/box/box_news_sub_zone.dart';
import 'package:news/widgets/box/box_picture.dart';
import 'package:news/widgets/box/box_playlist.dart';
import 'package:news/widgets/box/box_podcast.dart';
import 'package:news/widgets/box/box_sso_widget.dart';
import 'package:news/widgets/box/box_top_view.dart';
import 'package:news/widgets/box/box_toppic_widget.dart';
import 'package:news/widgets/box/box_vote_widget.dart';
import 'package:news/widgets/divider_widget.dart';
import 'package:news/widgets/large_news/generate_large_list_type_2.dart';
import 'package:news/widgets/large_news/large_news_type_1.dart';
import 'package:news/widgets/small_news/generate_small_list_title.dart';
import 'package:news/widgets/small_news/generate_small_list_type_1.dart';
import 'package:news/models/globals.dart' as globals;

class HomeList extends StatelessWidget {
  const HomeList({
    Key key,
    @required this.homeStructs,
  }) : super(key: key);

  final HomeStruct homeStructs;

  @override
  Widget build(BuildContext context) {
    final List<Widget> listWidget = [];

    if (homeStructs.boxFeatures?.isNotEmpty ?? false) {
      // 1. Large news
      listWidget.add(
        LargeNewsType1(article: homeStructs.boxFeatures.first),
      );

      // 2. List small type 1
      listWidget.add(
        Padding(
          padding: const EdgeInsets.only(bottom: paddingNews),
          child: GenerateSmallListType1(
            articles: homeStructs.boxFeatures.sublist(1),
          ),
        ),
      );
    }
    DividerWidget;

    //chude
    listWidget.add(BoxToppicWidget());

    //hot topic
    if (!globals.isTTStar) {
      listWidget.add(AdBanner(zone: "jwsn1c2f", channel: "/home/", rate: rateAdsHome),);
    }

    // Banner Bau Cu My
    if (globals.isShowBannerBCM) {
      print('setting cua banner BCM la ${globals.isShowBannerBCM}');
      listWidget.add(BoxboxBannerBCM(
          isShowDivider: true, isSolid: false, color: Colors.black));
    }

    // 3. Admod ads
    if (globals.isShowAds) {
      listWidget.add(
        AdmodBanner(padding: EdgeInsets.zero),
      );
    }
    //box chủ đề....
    // if (homeStructs.threads?.isNotEmpty ?? false) {
    //   listWidget.add(HomeBoxThread(threads: homeStructs.threads));
    //*print('Home threads count: ${homeStructs.threads?.length}');
    //*print('Threads contents: ${homeStructs.threads?.map((t) => //*t.name).toList()}');
    // }

    // 4. List small news title
    // if (homeStructs.boxFeatured2?.isNotEmpty ?? false) {
    //   listWidget.add(
    //     Padding(
    //       padding: const EdgeInsets.only(top: paddingNews),
    //       child: GenerateSmallListTitle(
    //         articles: homeStructs.boxFeatured2,
    //       ),
    //     ),
    //   );
    // }

    // 5. List large type 2 // 4. List small news title
    if (homeStructs.boxFeatured2?.isNotEmpty ?? false) {
      listWidget.add(GenerateLargeListType2(articles: homeStructs.boxFeatured2));
    }


// 5. List large type 2
    if (homeStructs.boxFeatured2?.isNotEmpty ?? false) {
      listWidget.add(GenerateLargeListType2(articles: homeStructs.topHot1));
    }
// 5.1 Health and by law
    if (globals.isTTStar && (homeStructs?.boxTVPL?.isNotEmpty ?? false)) {
      listWidget.add(BoxHealthBylawWidget(
        articles: [
          homeStructs.boxHCSK,
          homeStructs.boxTVPL,
        ],
      ));
    }
    // 6. Large topHotSpecial1
    if (homeStructs.topHotSpecial1?.article?.newsId?.isNotEmpty ?? false) {
      listWidget.add(homeStructs.topHotSpecial1?.getUIWidget);
    }

    // 7. List large type 2
    if (homeStructs.topHot2?.isNotEmpty ?? false) {
      listWidget.add(GenerateLargeListType2(articles: homeStructs.topHot2));
    }

    // 8. Large topHotSpecial2
    if (homeStructs.topHotSpecial2?.article?.newsId?.isNotEmpty ?? false) {
      listWidget.add(homeStructs.topHotSpecial2?.getUIWidget);
    }

    // 9. List large type 2
    if (homeStructs.topHot3?.isNotEmpty ?? false) {
      listWidget.add(GenerateLargeListType2(articles: homeStructs.topHot3));
    }

    // 10. Large topHotSpecial3
    if (homeStructs.topHotSpecial3?.article?.newsId?.isNotEmpty ?? false) {
      listWidget.add(homeStructs.topHotSpecial3?.getUIWidget);
    }

    // 10.1 Daily newspaper
    if (globals.isShowDailyNewspaper) {
      listWidget.add(BoxDailyNewspaper());
    }

    // 11. List large type 2
    if (homeStructs.topHot4?.isNotEmpty ?? false) {
      listWidget.add(GenerateLargeListType2(articles: homeStructs.topHot4));
    }

    // 11.1 About TTS
    if (!globals.isTTStar) {
      listWidget.add(BoxSSOWidget());
    }

    // 12. Box playlist
    if (homeStructs.playlist != null) {
      listWidget.add(BoxPlaylist(playList: homeStructs.playlist));
    }

    // 13. List large type 2
    if (homeStructs.topHot5?.isNotEmpty ?? false) {
      listWidget.add(GenerateLargeListType2(articles: homeStructs.topHot5));
    }

    // 14. Box vote
    if (homeStructs.boxVote != null) {
      listWidget.add(BoxVoteWidget(boxVote: homeStructs.boxVote));
    }

    // 15. List large type 2
    if (homeStructs.topHot6?.isNotEmpty ?? false) {
      listWidget.add(GenerateLargeListType2(articles: homeStructs.topHot6));
    }

    // 16. Box Image
    if (homeStructs.boxNicePicture?.isNotEmpty ?? false) {
      listWidget.add(
        BoxPicture(
          boxNicePicture: homeStructs.boxNicePicture,
          boxMegastoryHot: homeStructs.boxMegastoryHot,
          boxInfographic: homeStructs.boxInfographic,
        ),
      );
    }

    // 17. Box top view
    if (homeStructs.boxTopView?.isNotEmpty ?? false) {
      listWidget.add(BoxTopView(boxTopView: homeStructs.boxTopView, boxTopStar: homeStructs.boxTopStar));
    }

    // 18. Box BoxHighlightVideo
    if (homeStructs.boxHighlightVideo != null) {
      listWidget.add(
        BoxHighlightVideo(boxHighlightVideo: homeStructs.boxHighlightVideo),
      );
    }

    // 19. Box BoxPodcast
    if (homeStructs.boxPodcast != null) {
      listWidget.add(BoxPodcast(boxPodcast: homeStructs.boxPodcast));
    }

    // 20. Box TTSmile , TTLastWeeken
    if (homeStructs?.boxNewsSubZone?.isNotEmpty ?? false) {
      listWidget.add(
        BoxNewsSubZone(
          boxNewsSubZone: homeStructs.boxNewsSubZone,
          ttNews: homeStructs.ttNews,
        ),
      );
    }

    // 21. Box ClassiFieds
    if (homeStructs?.classiFieds?.isNotEmpty ?? false) {
      listWidget.add(
        BoxClassifiedsWidget(classiFieds: homeStructs?.classiFieds),
      );
    }

    // 22. Box NewsByZone
    if (homeStructs?.newsByZone?.isNotEmpty ?? false) {
      listWidget.add(
        RepaintBoundary(
          child: BoxNewsByZone(newsByZones: homeStructs?.newsByZone),
        ),
      );
    }

    // 23. Box Bottom
    listWidget.add(BoxBottomInfoWidget());

    return ColoredBox(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: paddingNews),
        child: CustomScrollView(
          slivers: <Widget>[
            SliverOverlapInjector(
              handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, int index) {
                  if (index >= listWidget.length) {
                    return AppLoadingIndicator();
                  }
                  return listWidget[index];
                },
                childCount: listWidget.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
