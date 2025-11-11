import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/base/app_helpers.dart';
import 'package:news/base/app_netcore.dart';
import 'package:news/constant/string.dart';
import 'package:news/widgets/app_loading.dart';
import 'package:news/widgets/retry_widget.dart';
import 'bloc/recommend_list_bloc.dart';
import 'widgets/recommend_list.dart';

class RecommendPage extends StatelessWidget {
  const RecommendPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Add recommend tracking event + tab name is recommend
    AppNetcore().addHomeEvent(
      pageName: KString.strHome,
      tabName: KString.STR_RECOMMEND,
    );

    Future<void> _refresh() async {
      await Future.delayed(Duration(milliseconds: 200));
      BlocProvider.of<RecommendListBloc>(context)
          .add(RefreshListRecommendEvent());
    }

    printDebug('\n-------------- Build recommend page --------------------\n');
    return BlocBuilder<RecommendListBloc, RecommendListState>(
        builder: (BuildContext context, RecommendListState state) {
      // Handle state is RecommendListSuccess
      if (state is RecommendListSuccess) {
        return RefreshIndicator(
          displacement: 10,
          onRefresh: _refresh,
          child: RecommendList(
            articles: state.articles,
            canLoadMore: state.canLoadMore,
          ),
        );
      }

      // Handle state is RecommendListFailure
      if (state is RecommendListFailure) {
        return RetryWidget(onClickRetry: () {
          BlocProvider.of<RecommendListBloc>(context)
              .add(RefreshListRecommendEvent());
        });
      }

      return AppLoadingIndicator();
    });
  }
}
