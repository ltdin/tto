import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/base/app_helpers.dart';
import 'package:news/base/app_netcore.dart';
import 'package:news/constant/string.dart';
import 'package:news/pages/video/bloc/video_list_bloc.dart';
import 'package:news/pages/video/widgets/videos_list.dart';
import 'package:news/widgets/app_loading.dart';
import 'package:news/widgets/retry_widget.dart';

class VideosTvoPage extends StatelessWidget {
  const VideosTvoPage();

  @override
  Widget build(BuildContext context) {
    // Add Videos tracking event + tab name is Videos
    AppNetcore().addHomeEvent(
      pageName: KString.strHome,
      tabName: KString.VIDEO_PAGE,
    );

    Future<void> _refresh() async {
      BlocProvider.of<VideoListBloc>(context).add(GetVideoListEvent());
      await Future.delayed(Duration(milliseconds: 200));
    }

    printDebug('\n------------------- Build videos page ------------------\n');
    return BlocBuilder<VideoListBloc, VideoListState>(
        builder: (BuildContext context, VideoListState state) {
      // Handle state is VideoListSuccess
      if (state is VideoListSuccess) {
        return RefreshIndicator(
          onRefresh: _refresh,
          child: state.articles.isNotEmpty
              ? VideoList(videoList: state.articles)
              : RetryWidget(onClickRetry: () => _refresh()),
        );
      }

      // Handle state is VideoListFailure
      if (state is VideoListFailure) {
        return RetryWidget(onClickRetry: () => _refresh());
      }

      //
      return AppLoadingIndicator();
    });
  }
}
