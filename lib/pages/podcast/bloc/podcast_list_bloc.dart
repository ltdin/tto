import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/base/app_cache.dart';
import 'package:news/blocs/news_bloc.dart';
import 'package:news/constant/bool.dart';
import 'package:news/constant/string.dart';
import 'package:news/base/app_helpers.dart';
import 'package:news/models/podcast_model.dart';

part 'podcast_list_event.dart';
part 'podcast_list_state.dart';

class PodcastListBloc extends Bloc<PodcastListEvent, PodcastListState> {
  PodcastListBloc() : super(PodcastListInitial());

  @override
  Stream<PodcastListState> mapEventToState(PodcastListEvent event) async* {
    final currentState = state;

    if (event is GetPodcastListEvent) {
      try {
        bool isLoadFail = FLAG_ON;

        // Load podcast from cache data
        final cachePodcast = await _getPodcastsFromCache();
        if (cachePodcast?.isNotEmpty ?? false) {
          yield PodcastListSuccess(podcasts: cachePodcast);
          isLoadFail = FLAG_OFF;
        }

        // Load podcast from api
        final podcasts = await bloc.fetchPodcastList();

        if (podcasts?.isNotEmpty ?? false) {
          yield PodcastListSuccess(podcasts: podcasts);
          isLoadFail = FLAG_OFF;
          _saveCachePodcast(articles: podcasts);
        }

        // Update UI if not data or empty
        if (isLoadFail) {
          yield PodcastListFailure();
        }
      } catch (e) {
        if (currentState is PodcastListSuccess) {
          return;
        } else {
          final cacheVideo = await _getPodcastsFromCache();

          // Check has data cache
          if (cacheVideo?.isNotEmpty ?? false) {
            yield PodcastListSuccess(podcasts: cacheVideo);
          } else {
            yield PodcastListFailure();
          }
        }
      }
    }
  }

  Future<List<PodcastModel>> _getPodcastsFromCache() async {
    printDebug('Get data podcast page from cache');

    // Get data podcast from cache
    final mapPodcast = await AppCache.load(KString.CACHE_PODCAST_PAGE_NEW);
    final List<PodcastModel> podcast = lookup<List>(mapPodcast, ['articles'])
            ?.map<PodcastModel>((o) => PodcastModel.fromJson(o))
            ?.toList() ??
        <PodcastModel>[];

    return podcast;
  }

  void _saveCachePodcast({List<PodcastModel> articles}) {
    printDebug('Save data podcast page from cache');

    // Save podcasts into cache data
    AppCache.save(
      key: KString.CACHE_PODCAST_PAGE_NEW,
      jsonModel: toListJson(articles),
    );
  }

  Map<String, dynamic> toListJson(List<PodcastModel> podcasts) => {
        'articles': List<PodcastModel>.from(podcasts.map((x) => x)),
      };
}
