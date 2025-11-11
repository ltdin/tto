import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/base/app_cache.dart';
import 'package:news/blocs/news_bloc.dart';
import 'package:news/constant/string.dart';
import 'package:news/models/article_model.dart';
import 'package:news/base/app_helpers.dart';

part 'latest_list_event.dart';
part 'latest_list_state.dart';

class LatestListBloc extends Bloc<LatestListEvent, LatestListState> {
  LatestListBloc() : super(LatestListInitial());

  @override
  Stream<LatestListState> mapEventToState(LatestListEvent event) async* {
    final currentState = state;

    if (event is GetLatestListEvent) {
      bool isLoadFail = true;

      // Load from cache data
      final cacheRecommends = await _getLatestFromCache();

      if (cacheRecommends?.isNotEmpty ?? false) {
        yield LatestListSuccess(
          pages: 1,
          articles: cacheRecommends,
          canLoadMore: false,
        );
        isLoadFail = false;
      }

      // Load from api
      final articles = await bloc.getNewsLastest(page: 1);

      if (articles?.isNotEmpty ?? false) {
        yield LatestListSuccess(
          pages: 1,
          articles: articles,
          canLoadMore: true,
        );
        _saveCacheLastest(articles: articles);
        isLoadFail = false;
      }

      // Update UI if not data or empty
      if (isLoadFail) {
        yield LatestListFailure();
      }
    }

    // Handle state is LoadMoreRecommendListEvent
    if (event is LoadMoreLatestListEvent) {
      if (currentState is LatestListSuccess) {
        final int currentPage = currentState.pages + 1;
        final List<Article> articles =
            await bloc.getNewsLastest(page: currentPage);

        if (articles?.isNotEmpty ?? false) {
          yield LatestListSuccess(
            pages: currentPage,
            articles: currentState.articles + articles,
            canLoadMore: true,
          );
        } else {
          yield currentState.copyWith(canLoadMore: false);
        }
      }
    }

    // Handle state is RefreshListRecommendEvent
    if (event is RefreshListLatestEvent) {
      final articles = await bloc.getNewsLastest(page: 1);
      if (articles?.isNotEmpty ?? false) {
        yield LatestListSuccess(
          pages: 1,
          articles: articles,
          canLoadMore: true,
        );
        _saveCacheLastest(articles: articles);
      }
    }
  }

  Future<List<Article>> _getLatestFromCache() async {
    printDebug('Get Latest data from cache');

    // Get data Recommend from cache
    final mapRecommend = await AppCache.load(KString.CACHE_LASTEST_PAGE_NEW);
    final recommends = lookup<List>(mapRecommend, ['articles'])
            ?.map<Article>((o) => Article.fromJson(o))
            ?.toList() ??
        <Article>[];

    return recommends;
  }

  void _saveCacheLastest({List<Article> articles}) {
    printDebug('Save data Recommend page to cache');

    // Save cache data Recommend
    AppCache.save(
      key: KString.CACHE_LASTEST_PAGE_NEW,
      jsonModel: toListJson(articles),
    );
  }

  Map<String, dynamic> toListJson(List<Article> articles) => {
        'articles': List<Article>.from(articles.map((x) => x)),
      };
}
