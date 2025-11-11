import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/base/app_helpers.dart';
import 'package:news/base/app_netcore.dart';
import 'package:news/blocs/news_bloc.dart';
import 'package:news/constant/number.dart';
import 'package:news/constant/string.dart';
import 'package:news/models/article_model.dart';
import 'package:news/models/zone_model.dart';
import 'package:news/base/app_sqflite.dart';
part 'tab_category_page_event.dart';
part 'tab_category_page_state.dart';

class TabCategoryPageBloc
    extends Bloc<TabCategoryPageEvent, TabCategoryPageState> {
  TabCategoryPageBloc() : super(TabCategoryPageInitial());

  @override
  Stream<TabCategoryPageState> mapEventToState(
      TabCategoryPageEvent event) async* {
    final currentState = state;

    // Handle event is GetVideoListEvent
    if (event is GetTabCategoryListEvent) {
      // Get data list from local database
      final articlesLocal =
          await AppSqflite.instance.queryListNewsFromIdCategory(
        idCategory: event.zone.zoneId.toString(),
      );

      if (articlesLocal?.articles?.isNotEmpty ?? false) {
        yield TabCategoryPageSuccess(
          articles: articlesLocal.articles,
          zone: event.zone,
          canLoadMore: true,
        );
        printDebug(
            ' =========== isUpdate = ${articlesLocal.isUpdate} =========== ');

        // Get new data from api if isUpdate == 1
        if (articlesLocal.isUpdate == IS_UPDATE) {
          final articles = await bloc.fetchListingByZone(
            zoneId: event.zone.zoneId.toString(),
          );

          if (articles?.isNotEmpty ?? false) {
            yield TabCategoryPageSuccess(
              articles: articles,
              zone: event.zone,
              canLoadMore: true,
            );

            // Save data to local
            _saveLocalListTabCategory(zone: event.zone, articles: articles);
          }
        }

        // Add event Home Category
        AppNetcore().addHomeEvent(
          pageName: KString.strHome,
          tabName: event.zone.name,
          zoneList: event.zone,
        );
      } else {
        final articles = await bloc.fetchListingByZone(
          zoneId: event.zone.zoneId.toString(),
        );

        // Check empty data
        if (articles?.isNotEmpty ?? false) {
          yield TabCategoryPageSuccess(
            articles: articles,
            zone: event.zone,
            canLoadMore: true,
          );

          // Save list news to local
          _saveLocalListTabCategory(zone: event.zone, articles: articles);
        } else {
          yield TabCategoryPageSuccess(
            articles: [],
            zone: event.zone,
            canLoadMore: false,
          );
        }
      }
    }

    // Handle event is RefeshListTabCategoryEvent
    if (event is RefeshListTabCategoryEvent) {
      final articles = await bloc.fetchListingByZone(
        zoneId: event.zone.zoneId.toString(),
      );

      // check list video has data
      if (articles != null && (articles?.isNotEmpty ?? false)) {
        yield TabCategoryPageSuccess(
          articles: articles,
          zone: event.zone,
          canLoadMore: true,
        );

        // Save data to local
        _saveLocalListTabCategory(zone: event.zone, articles: articles);
      }
    }

    // Handle event is LoadMore
    if (event is TabCategoryLoadMoreListEvent &&
        currentState is TabCategoryPageSuccess) {
      printDebug('Call bloc Load more ${event.zone}');
      final articlesLoadMore = await bloc.fetchZonePaging(
        zoneId: event.zone.zoneId.toString(),
        pageIndex: currentState.page,
      );

      if (articlesLoadMore?.isNotEmpty ?? false) {

        //chống trùng tin
        final existingIds = currentState.articles.map((a) => a.newsId).toSet();
        final filteredNewArticles = articlesLoadMore.where((a) => !existingIds.contains(a.newsId)).toList();

        // yield TabCategoryPageSuccess(
        //   articles: currentState.articles + articlesLoadMore,
        //   zone: event.zone,
        //   canLoadMore: true,
        //   page: currentState.page + 1,

        yield TabCategoryPageSuccess(
          articles: currentState.articles + filteredNewArticles,
          zone: event.zone,
          canLoadMore: true,
          page: currentState.page + 1,
        );
      } else {
        currentState.copyWith(canLoadMore: false);
      }
    }
  }

  void _saveLocalListTabCategory({ZoneList zone, List<Article> articles}) {
    final sqlite = AppSqflite.instance;
    sqlite.insertListCategory(zone: zone, articles: articles);
  }
}
