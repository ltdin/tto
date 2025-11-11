import 'dart:async';
import 'dart:io';

import 'package:diacritic/diacritic.dart';
import 'package:flutter/material.dart';
import 'package:news/base/app_helpers.dart';
import 'package:news/blocs/user_bloc.dart';
import 'package:news/constant/bool.dart';
import 'package:news/constant/string.dart';
import 'package:news/models/article_model.dart';
import 'package:news/models/article_native.dart';
import 'package:news/models/zone_model.dart';
import 'package:news/widgets/ariticle_detail/push_to_detail.dart';
import 'package:smartech_base/smartech_base.dart';
import 'package:news/models/globals.dart' as globals;

class AppNetcore {
  // Handle deeplink for push
  void handleDeeplink({BuildContext context}) {
    // On background
    Smartech().onHandleDeeplink(
      (smtDeeplinkSource, smtDeeplink, smtPayload, smtCustomPayload) {
        printDebug('----------------- onHandleDeeplink -----------------');

        // Handle the deeplink
        if (smtDeeplink == null || smtDeeplink.isEmpty) {
          return;
        }

        // Handle link from idNews
        final String newsId = AppHelpers.parseArticleIdFromUrl(smtDeeplink);

        // If emplty
        if (newsId.isNotEmpty) {
          Timer(
            const Duration(seconds: 1),
            () => pushToDetail(
              context: context,
              article: Article(newsId: newsId, url: smtDeeplink),
              fromPush: FLAG_ON,
            ),
          );
        }
      },
    );

    // Deeplink
    // Smartech().onHandleDeeplinkAction((
    //   String link,
    //   Map<dynamic, dynamic> map,
    // ) {
    //   printDebug('----------------- handleDeeplinkAction -----------------');

    //   // Handle the deeplink
    //   if (link == null || link.isEmpty) {
    //     return;
    //   }

    //   // Handle link from idNews
    //   final String newsId = AppHelpers.parseArticleIdFromUrl(link);
    //   if (newsId.isNotEmpty) {
    //     Timer(
    //       const Duration(seconds: 1),
    //       () => pushToDetail(
    //         context: context,
    //         article: Article(newsId: newsId, url: link),
    //         fromPush: FLAG_ON,
    //       ),
    //     );
    //   }
    // });
  }

  void addHomeEvent(
      {String pageName = '', String tabName = '', ZoneList zoneList}) {
    if (tabName == KString.HOME_PAGE) {
      addCategoryEvent(
        zoneList: ZoneList(
            description:
                'báo tuổi trẻ - tin tức mới nhất tin nhanh tin nóng 24h',
            name: tabName,
            shortUrl: 'https://tuoitre.vn/',
            slug: 'home'),
        parentCategory: tabName,
      );
      return;
    }

    /// Tab is TAG page
    if ([
      KString.LASTLEST_PAGE,
      KString.PODCAST_PAGE,
      KString.STR_RECOMMEND,
      KString.STR_MANY_STARS_PAGE,
      KString.VIDEO_PAGE
    ].contains(tabName)) {
      String shortUrl = '';

      switch (tabName) {
        case KString.VIDEO_PAGE:
          shortUrl = 'https://tuoitre.vn/video.htm';
          break;

        case KString.STR_MANY_STARS_PAGE:
          shortUrl = 'https://tuoitre.vn/sao-nhieu.htm';
          break;

        case KString.STR_RECOMMEND:
          shortUrl = 'https://tuoitre.vn/tin-xem-nhieu.htm';
          break;

        case KString.PODCAST_PAGE:
          shortUrl = 'https://podcast.tuoitre.vn';
          break;

        case KString.LASTLEST_PAGE:
          shortUrl = 'https://tuoitre.vn/moi-nhat.htm';
          break;
      }

      addTagEvent(
        zoneList: ZoneList(name: tabName, shortUrl: shortUrl),
      );
      return;
    }

    // Tab is category
    addCategoryEvent(zoneList: zoneList, parentCategory: tabName);
  }

  void addCategoryEvent({ZoneList zoneList, String parentCategory}) {
    printDebug('---------> addCategoryEvent /${zoneList.getSlug}/');
    var eventData = {
      'article_id': '0',
      'article_title': zoneList.description,
      'article_category': zoneList.name.toLowerCase() ?? '',
      'article_parent_category': parentCategory.toLowerCase(),
      'article_tags': '',
      'article_thumbnail': '',
      'article_short_url': zoneList.getUrlForCategory,
      'article_full_url': zoneList.getUrlForCategory,
      'page_category': '/${zoneList.getSlug}/',
      'referrer_url': '',
      'user_id': userBloc.userInfo.getId,
      'is_ttsao': globals.isTTStar ? '1' : '0',
      'plaform': Platform.isAndroid ? 'android' : 'ios'
    };

    _trackPlatformEvent("page_view", eventData);
  }

  void addSubCategoryEvent({ZoneList zoneList, String parentCategory}) {
    final parentCategorySlug =
        removeDiacritics(parentCategory.replaceAll(' ', '-')).toLowerCase();
    final pageCategory = '${parentCategorySlug}/${zoneList.getSlug}';
    final urlForCategory = 'https://tuoitre.vn/$pageCategory.htm';

    printDebug('---------> addSubCategoryEvent /$pageCategory/ ');

    var eventData = {
      'article_id': '0',
      'article_title': zoneList.description,
      'article_category': zoneList.name.toLowerCase() ?? '',
      'article_parent_category': parentCategory.toLowerCase(),
      'article_tags': '',
      'article_thumbnail': '',
      'article_short_url': urlForCategory,
      'article_full_url': urlForCategory,
      'page_category': '/$pageCategory/',
      'referrer_url': '',
      'user_id': userBloc.userInfo.getId,
      'is_ttsao': globals.isTTStar ? '1' : '0',
      'plaform': Platform.isAndroid ? 'android' : 'ios'
    };

    _trackPlatformEvent("page_view", eventData);
  }

  void addTagEvent({ZoneList zoneList}) {
    printDebug('---------> addTagEvent /tag/${zoneList.getTag}/');
    var eventData = {
      'article_id': '0',
      'article_title': '',
      'article_category': '',
      'article_parent_category': '',
      'article_tags': '',
      'article_thumbnail': '',
      'article_short_url': zoneList.getShortUrl,
      'article_full_url': zoneList.getShortUrl,
      'page_category': '/tag/${zoneList.getTag}/',
      'referrer_url': '',
      'user_id': userBloc.userInfo.getId,
      'is_ttsao': globals.isTTStar ? '1' : '0',
      'plaform': Platform.isAndroid ? 'android' : 'ios'
    };

    _trackPlatformEvent("page_view", eventData);
  }

  void addDetailEvent({Article news}) {
    addDetailNativeEvent(news: news.toArticleNative());
  }

  void addDetailNativeEvent({ArticleNative news}) {
    var eventData = {
      'article_id': news.newsId ?? '',
      'article_title': news.title ?? '',
      'article_category': news.zoneName?.toLowerCase() ?? '',
      'article_parent_category': '',
      'article_tags': news.getStrTags ?? '',
      'article_thumbnail': news.avatar ?? '',
      'article_short_url': news.getShareUrl,
      'article_full_url': news.url,
      'page_category': '/${news.getPageCategory}/detail/',
      'referrer_url': '',
      'user_id': userBloc.userInfo.getId,
      'is_ttsao': globals.isTTStar ? '1' : '0',
      'plaform': Platform.isAndroid ? 'android' : 'ios'
    };

    _trackPlatformEvent("page_view", eventData);
  }

  void _trackPlatformEvent(String eventName, Map<String, dynamic> eventData) {
    Smartech().trackEvent(eventName, eventData);
  }

  void setUserIdentity({String id}) {
    Smartech().setUserIdentity(id);
  }
}
