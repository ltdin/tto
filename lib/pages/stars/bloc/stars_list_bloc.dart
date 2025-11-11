import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/base/app_cache.dart';
import 'package:news/blocs/news_bloc.dart';
import 'package:news/constant/string.dart';
import 'package:news/models/article_model.dart';
import 'package:news/base/app_helpers.dart';

part 'stars_list_event.dart';
part 'stars_list_state.dart';

class StarsListBloc extends Bloc<StarsListEvent, StarsListState> {
  StarsListBloc() : super(StarsListInitial());

  @override
  Stream<StarsListState> mapEventToState(StarsListEvent event) async* {
    if (event is GetStarsListEvent) {
      bool isLoadFail = true;

      // Load from cache data
      final cacheRecommends = await _getLatestFromCache();

      if (cacheRecommends?.isNotEmpty ?? false) {
        yield StarsListSuccess(
          pages: 1,
          articles: cacheRecommends,
        );
        isLoadFail = false;
      }

      // Load from api
      final articles = await bloc.getNewsStars(page: 1);

      if (articles?.isNotEmpty ?? false) {
        yield StarsListSuccess(pages: 1, articles: articles);
        _saveCacheStars(articles: articles);
        isLoadFail = false;
      }

      // Update UI if not data or empty
      if (isLoadFail) {
        yield StarsListFailure();
      }
    }

    // Handle state is RefreshListStarsEvent
    if (event is RefreshListStarsEvent) {
      final articles = await bloc.getNewsStars(page: 1);

      if (articles?.isNotEmpty ?? false) {
        yield StarsListSuccess(pages: 1, articles: articles);
        _saveCacheStars(articles: articles);
      }
    }
  }

  Future<List<Article>> _getLatestFromCache() async {
    printDebug('Get Latest data from cache');

    // Get data Recommend from cache
    final maps = await AppCache.load(KString.CACHE_STARS_PAGE_NEW);
    final stars = lookup<List>(maps, ['articles'])
            ?.map<Article>((o) => Article.fromJson(o))
            ?.toList() ??
        <Article>[];

    return stars;
  }

  void _saveCacheStars({List<Article> articles}) {
    printDebug('Save data page to cache');

    // Save cache data Recommend
    AppCache.save(
      key: KString.CACHE_STARS_PAGE_NEW,
      jsonModel: toListJson(articles),
    );
  }

  Map<String, dynamic> toListJson(List<Article> articles) => {
        'articles': List<Article>.from(articles.map((x) => x)),
      };
}
