import 'package:flutter/material.dart' hide NestedScrollView;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/base/app_helpers.dart';
import 'package:news/base/app_netcore.dart';
import 'package:news/constant/string.dart';
import 'package:news/pages/latest/bloc/latest_list_bloc.dart';
import 'package:news/pages/podcast/bloc/podcast_list_bloc.dart';
import 'package:news/pages/recommend/bloc/recommend_list_bloc.dart';
import 'package:news/pages/run/app.dart';
import 'package:news/pages/home/bloc/home_list_bloc.dart';
import 'package:news/pages/stars/bloc/stars_list_bloc.dart';
import 'package:news/pages/video/bloc/video_list_bloc.dart';

class AppBloc extends StatefulWidget {
  const AppBloc({Key key}) : super(key: key);

  @override
  _AppBlocState createState() => _AppBlocState();
}

class _AppBlocState extends State<AppBloc> {
  @override
  initState() {
    // Listener deep link Netcore
    AppNetcore().handleDeeplink(context: context);

    // Add home event + tab name is Home
    AppNetcore()
        .addHomeEvent(pageName: KString.strHome, tabName: KString.HOME_PAGE);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    printDebug('====================== Build app ======================');

    return MultiBlocProvider(
      providers: [
        BlocProvider<HomeListBloc>(
          create: (context) => HomeListBloc()..add(GetHomeListEvent()),
        ),
        BlocProvider<LatestListBloc>(
          create: (context) =>
              LatestListBloc()..add(const GetLatestListEvent()),
        ),
        BlocProvider<RecommendListBloc>(
          create: (context) =>
              RecommendListBloc()..add(const GetRecommendListEvent()),
        ),
        BlocProvider<StarsListBloc>(
          create: (context) => StarsListBloc()..add(const GetStarsListEvent()),
        ),
        BlocProvider<VideoListBloc>(
          create: (context) => VideoListBloc()..add(const GetVideoListEvent()),
        ),
        BlocProvider<PodcastListBloc>(
          create: (context) =>
              PodcastListBloc()..add(const GetPodcastListEvent()),
        ),
      ],
      child: App(),
    );
  }
}
