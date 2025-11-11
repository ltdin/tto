import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/base/app_cache.dart';
import 'package:news/blocs/news_bloc.dart';
import 'package:news/constant/string.dart';
import 'package:news/models/article_model.dart';
import 'package:news/base/app_helpers.dart';

part 'recommend_list_event.dart';
part 'recommend_list_state.dart';

class RecommendListBloc extends Bloc<RecommendListEvent, RecommendListState> {
  RecommendListBloc() : super(RecommendListInitial());

  @override
  Stream<RecommendListState> mapEventToState(RecommendListEvent event) async* {
    if (event is GetRecommendListEvent) {
      bool isLoadFail = true;

      // Load recommends from cache data
      final cacheRecommends = await _getRecommendFromCache();

      if (cacheRecommends?.isNotEmpty ?? false) {
        yield RecommendListSuccess(
          pages: 1,
          articles: cacheRecommends,
          canLoadMore: false,
        );
        isLoadFail = false;
      }

      // Load recommends from api
      final articles = await bloc.getNewstRecommend();

      if (articles?.isNotEmpty ?? false) {
        yield RecommendListSuccess(
          pages: 1,
          articles: articles,
          canLoadMore: true,
        );
        _saveCacheRecommend(articles: articles);
        return;
      }

      // Update UI if not data or empty
      if (isLoadFail) {
        yield RecommendListFailure();
      }
    }

    // Handle state is RefreshListRecommendEvent
    if (event is RefreshListRecommendEvent) {
      final articles = await bloc.getNewstRecommend();

      if (articles?.isNotEmpty ?? false) {
        yield RecommendListSuccess(
          pages: 1,
          articles: articles,
          canLoadMore: true,
        );
        _saveCacheRecommend(articles: articles);
      }
    }
  }

  Future<List<Article>> _getRecommendFromCache() async {
    printDebug('Get data Recommend from cache');

    // Get data Recommend from cache
    final mapRecommend = await AppCache.load(KString.CACHE_RECOMMEND_PAGE_NEW);
    final recommends = lookup<List>(mapRecommend, ['articles'])
            ?.map<Article>((o) => Article.fromJson(o))
            ?.toList() ??
        <Article>[];

    return recommends;
  }

  void _saveCacheRecommend({List<Article> articles}) {
    printDebug('Save data Recommend page to cache');

    // Save cache data Recommend
    AppCache.save(
      key: KString.CACHE_RECOMMEND_PAGE_NEW,
      jsonModel: toListJson(articles),
    );
  }

  Map<String, dynamic> toListJson(List<Article> articles) => {
        'articles': List<Article>.from(articles.map((x) => x)),
      };
}
