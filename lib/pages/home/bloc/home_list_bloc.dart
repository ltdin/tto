import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/base/app_cache.dart';
import 'package:news/base/app_helpers.dart';
import 'package:news/blocs/news_bloc.dart';
import 'package:news/constant/string.dart';
import 'package:news/models/home_model.dart';

part 'home_list_event.dart';
part 'home_list_state.dart';

class HomeListBloc extends Bloc<HomeListEvent, HomeListState> {
  HomeListBloc() : super(HomeListInitial());

  @override
  Stream<HomeListState> mapEventToState(HomeListEvent event) async* {
    // Event is GetHomeListEvent
    if (event is GetHomeListEvent) {
      // Load home from cache data
      final cacheHomeStruts = await _getHomeFromCache();

      if (cacheHomeStruts != null) {
        yield HomeListSuccess(homeStructs: cacheHomeStruts);
      }

      // Load home from api5
      HomeStruct homeStruts = await bloc.fetchAllHome();

      // Load classifieds
      final classiFieds = await bloc.getClassiFieds();

      // Load ttNews
      final ttNews = await bloc.getTtNews();

      // Check list classifieds
      if (classiFieds?.isNotEmpty ?? false) {
        homeStruts = homeStruts?.copyWith(classiFieds: classiFieds);
      }

      // Check list ttNews
      if (ttNews?.isNotEmpty ?? false) {
        homeStruts = homeStruts?.copyWith(ttNews: ttNews);
      }

      // Yield state into bloc
      if (homeStruts != null) {
        yield HomeListSuccess(homeStructs: homeStruts);
        _saveCacheHome(homeStruts: homeStruts);
      }
    }

    // Event is RefreshHomeListEvent
    if (event is RefreshHomeListEvent) {
      // Load home from api
      HomeStruct homeStruts = await bloc.fetchAllHome();

      // Load classifieds from
      final classiFieds = await bloc.getClassiFieds();

      // Load ttNews
      final ttNews = await bloc.getTtNews();

      // Check list classifieds
      if (classiFieds?.isNotEmpty ?? false) {
        homeStruts = homeStruts?.copyWith(classiFieds: classiFieds);
      }

      // Check list ttNews
      if (ttNews?.isNotEmpty ?? false) {
        homeStruts = homeStruts?.copyWith(ttNews: ttNews);
      }

      // Yield state into bloc
      if (homeStruts != null) {
        yield HomeListSuccess(homeStructs: homeStruts);
        _saveCacheHome(homeStruts: homeStruts);
      }
    }
  }

  Future<HomeStruct> _getHomeFromCache() async {
    printDebug('Get data home page from cache');

    // Get map data from cache
    final Map<String, dynamic> mapHomeStruts =
        await AppCache.load(KString.CACHE_HOME_PAGE_NEW);

    return HomeStruct.fromJson(mapHomeStruts, fromCache: true);
  }

  void _saveCacheHome({HomeStruct homeStruts}) {
    printDebug('Save data home page into cache');

    // Save cache data home
    AppCache.save(
      key: KString.CACHE_HOME_PAGE_NEW,
      jsonModel: homeStruts.toJson(),
    );
  }
}
