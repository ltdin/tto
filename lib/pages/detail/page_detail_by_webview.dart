import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:news/base/app_cache.dart';
import 'package:news/base/app_helpers.dart';
import 'package:news/base/app_netcore.dart';
import 'package:news/base/app_sqflite.dart';
import 'package:news/constant/bool.dart';
import 'package:news/models/article_native.dart';
import 'package:news/pages/detail/bloc/detail_native_bloc.dart';
import 'package:news/widgets/retry_widget.dart';

class PageDetailByWebView extends StatefulWidget {
  const PageDetailByWebView({Key key, this.article}) : super(key: key);

  final ArticleNative article;
  @override
  _PageDetailByWebViewState createState() => _PageDetailByWebViewState();
}

class _PageDetailByWebViewState extends State<PageDetailByWebView> {
  bool loadError = FLAG_OFF;

  @override
  Widget build(BuildContext context) {
    printDebug('==================Build news webview detail==================');

    return loadError == FLAG_OFF
        ? InAppWebView(
            initialUrlRequest:
                URLRequest(url: Uri.tryParse(widget.article.urlWebView)),
            initialOptions: InAppWebViewGroupOptions(
              android: AndroidInAppWebViewOptions(
                textZoom: (AppCache().textSize * 10).round(),
                supportMultipleWindows: true,
              ),
            ),
            onWebViewCreated: (InAppWebViewController controller) {},
            onLoadStop: (InAppWebViewController controller, Uri url) {
              // Add event detail
              AppNetcore().addDetailNativeEvent(news: widget.article);

              // Save to local database
              AppSqflite.instance.insertNews(news: widget.article.toArticle());
            },
            onLoadError: (InAppWebViewController controller, Uri url, int code,
                String message) {
              setState(() {
                loadError = FLAG_ON;
              });
            },
          )
        : RetryWidget(
            onClickRetry: () {
              BlocProvider.of<DetailNativeBloc>(context)
                ..add(
                  GetDetailNativeEvent(newsId: widget.article.newsId),
                );
            },
          );
  }
}
