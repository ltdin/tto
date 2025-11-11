import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/base/app_helpers.dart';
import 'package:news/base/app_netcore.dart';
import 'package:news/constant/string.dart';
import 'package:news/pages/podcast/bloc/podcast_list_bloc.dart';
import 'package:news/pages/podcast/widgets/podcast_list.dart';
import 'package:news/widgets/app_loading.dart';
import 'package:news/widgets/retry_widget.dart';

class PodcastPage extends StatelessWidget {
  const PodcastPage();

  @override
  Widget build(BuildContext context) {
    // Add Videos tracking event + tab name is Videos
    AppNetcore().addHomeEvent(
      pageName: KString.strHome,
      tabName: KString.PODCAST_PAGE,
    );

    Future<void> _refresh() async {
      BlocProvider.of<PodcastListBloc>(context).add(GetPodcastListEvent());
      await Future.delayed(Duration(milliseconds: 200));
    }

    printDebug('\n------------------ Build podcast page ------------------\n');
    return BlocBuilder<PodcastListBloc, PodcastListState>(
        builder: (BuildContext context, PodcastListState state) {
      // Handle state is PodcastListSuccess
      if (state is PodcastListSuccess) {
        return RefreshIndicator(
          onRefresh: _refresh,
          child: state.podcasts.isNotEmpty
              ? PodcastList(podcasts: state.podcasts)
              : RetryWidget(onClickRetry: () => _refresh()),
        );
      }

      // Handle state is PodcastListFailure
      if (state is PodcastListFailure) {
        return RetryWidget(onClickRetry: () => _refresh());
      }
      return AppLoadingIndicator();
    });
  }
}
