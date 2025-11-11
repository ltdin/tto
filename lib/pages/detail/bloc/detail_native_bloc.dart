import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/base/app_helpers.dart';
import 'package:news/base/app_sqflite.dart';

import 'package:news/blocs/news_bloc.dart';
import 'package:news/constant/number.dart';
import 'package:news/models/article_native.dart';

part 'detail_native_event.dart';
part 'detail_native_state.dart';

class DetailNativeBloc extends Bloc<DetailNativeEvent, DetailNativeState> {
  DetailNativeBloc() : super(DetailNativeInitial());

  @override
  Stream<DetailNativeState> mapEventToState(DetailNativeEvent event) async* {
    //
    if (event is GetDetailNativeEvent) {
      final _articleNative = await bloc.getArticleDetailNative(event.newsId);

      // Check has data cache
      if (_articleNative?.body?.isNotEmpty ?? false) {
        printDebug('length : ${_articleNative.body.length.toString()} ');

        yield DetailNativeSuccess(
          webData: '${_articleNative.body}',
          article: _articleNative,
        );

        // Save to local database
        AppSqflite.instance.insertNews(news: _articleNative.toArticle());
      } else {
        yield _articleNative?.webViewType == IS_WEBVIEW_TYPE
            ? DetailNativeOpenByWebview(article: _articleNative)
            : DetailNativeFailure();
      }
    }
  }
}
