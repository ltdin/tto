import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/base/app_cache.dart';
import 'package:news/blocs/news_bloc.dart';
import 'package:news/constant/string.dart';
import 'package:news/models/article_model.dart';
import 'package:news/base/app_helpers.dart';

part 'video_list_event.dart';
part 'video_list_state.dart';

class VideoListBloc extends Bloc<VideoListEvent, VideoListState> {
  VideoListBloc() : super(VideoListInitial());

  @override
  Stream<VideoListState> mapEventToState(VideoListEvent event) async* {
    final currentState = state;

    if (event is GetVideoListEvent) {
      try {
        bool isLoadFail = true;

        // Load videos from cache data
        final cacheVideo = await _getVideosFromCache();
        if (cacheVideo?.isNotEmpty ?? false) {
          yield VideoListSuccess(articles: cacheVideo);
          isLoadFail = false;
        }

        // Load videos from api
        final videos = await bloc.fetchVideoList();

        if (videos?.isNotEmpty ?? false) {
          yield VideoListSuccess(articles: videos);
          isLoadFail = false;
          _saveCacheVideo(articles: videos);
        }

        // Update UI if not data or empty
        if (isLoadFail) {
          yield VideoListFailure();
        }
      } catch (e) {
        if (currentState is VideoListSuccess) {
          return;
        } else {
          final cacheVideo = await _getVideosFromCache();

          // Check has data cache
          if (cacheVideo?.isNotEmpty ?? false) {
            yield VideoListSuccess(articles: cacheVideo);
          } else {
            yield VideoListFailure();
          }
        }
      }
    }
  }

  Future<List<Article>> _getVideosFromCache() async {
    printDebug('Get data video page from cache');

    // Get data Recommend from cache
    final mapVideo = await AppCache.load(KString.CACHE_VIDEO_PAGE_NEW);
    final List<Article> videos = lookup<List>(mapVideo, ['articles'])
            ?.map<Article>((o) => Article.fromJson(o))
            ?.toList() ??
        <Article>[];

    return videos;
  }

  void _saveCacheVideo({List<Article> articles}) {
    printDebug('Save data video page from cache');

    // Save cache data Recommend
    AppCache.save(
      key: KString.CACHE_VIDEO_PAGE_NEW,
      jsonModel: toListJson(articles),
    );
  }

  Map<String, dynamic> toListJson(List<Article> articles) => {
        'articles': List<Article>.from(articles.map((x) => x)),
      };
}
