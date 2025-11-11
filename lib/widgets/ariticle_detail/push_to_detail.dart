import 'package:flutter/material.dart';
import 'package:news/models/article_model.dart';
import 'package:news/models/podcast_model.dart';
import 'package:news/models/video_tvo_model.dart';
import 'package:news/pages/detail/page_detail_native.dart';
import 'package:news/pages/detail/page_detail_webview_custom_tab.dart';
import 'package:news/pages/podcast/podcast_detail.dart';
import 'package:news/pages/video_tvo_detail/video_tvo_detail.dart';
import 'package:news/models/globals.dart' as globals;

void pushToDetail({
  @required BuildContext context,
  @required Article article,
  bool fromPush = false,
}) {
  ///=== Handle push to detail ====///

  // Open news in Custome tab for error case
  if (globals.appSetting.getFlagOpenNewsInWebview) {
    PageDetailWebviewCustomTab.launch(url: article.getUrlForOpenWebview);
    return;
  }

  // Open news in tto detail
  if (article.isTtoNews) {
    _pushToTtoDetail(context: context, article: article);
    return;
  }

  // Open tvo news in tvo detail page
  if (fromPush || article.isTvoLiveNews) {
    PageDetailWebviewCustomTab.launch(url: article.getTvoUrlVideo);
    return;
  }
  _pushToTvoDetail(context: context, article: article);
}

void _pushToTtoDetail({
  @required BuildContext context,
  @required Article article,
}) {
  // Check open news in Webview
  if (globals.appSetting.idNewsOpenWebview == article.newsId ||
      article.isTtoLiveNews) {
    PageDetailWebviewCustomTab.launch(url: article.getUrlForOpenWebview);
    return;
  }

  //
  // AppHelpers.showToast(text: '_pushToTtoDetail');

  // Push
  Navigator.push(
    context,
    MaterialPageRoute(
      settings: RouteSettings(name: "/tto_detail", arguments: null),
      builder: (context) => PageTtoDetailNative(article: article),
    ),
  );
}

void _pushToTvoDetail({
  @required BuildContext context,
  @required Article article,
}) {
  Navigator.push(
    context,
    MaterialPageRoute(
      settings: RouteSettings(name: "/tvo_detail", arguments: null),
      builder: (context) => PageVideoTvoDetail(
        itemRelatedNews: VideoTvoModel(
          newsId: article?.newsId ?? "138282",
          title: article?.title ?? "",
          url: article?.url ?? "",
          sapo: article?.sapo ?? "",
        ),
      ),
    ),
  );
}

void pushToPodcastDetail({
  @required BuildContext context,
  @required List<PodcastModel> podcasts,
  @required int index,
}) {
  if (globals.appSetting.getFlagOpenNewsInWebview) {
    PageDetailWebviewCustomTab.launch(url: podcasts[index].getUrl);
    return;
  }

  Navigator.push(
    context,
    MaterialPageRoute(
      settings: RouteSettings(name: "/podcast_detail", arguments: null),
      builder: (context) => PodcastDetail(podcasts: podcasts, index: index),
    ),
  );
}
