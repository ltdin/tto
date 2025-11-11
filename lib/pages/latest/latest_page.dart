import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/base/app_helpers.dart';
import 'package:news/base/app_netcore.dart';
import 'package:news/constant/string.dart';
import 'package:news/pages/latest/widgets/latest_list.dart';
import 'package:news/widgets/app_loading.dart';
import 'package:news/widgets/retry_widget.dart';
import 'bloc/latest_list_bloc.dart';

class LastestPage extends StatelessWidget {
  const LastestPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Add Lastest tracking event + tab name is Lastest
    AppNetcore().addHomeEvent(
      pageName: KString.strHome,
      tabName: KString.LASTLEST_PAGE,
    );

    Future<void> _refresh() async {
      await Future.delayed(Duration(milliseconds: 200));
      BlocProvider.of<LatestListBloc>(context).add(RefreshListLatestEvent());
    }

    printDebug('\n----------------- Build latest page -----------------\n');
    return BlocBuilder<LatestListBloc, LatestListState>(
        builder: (BuildContext context, LatestListState state) {
      // Handle state is LastestListSuccess
      if (state is LatestListSuccess) {
        return RefreshIndicator(
          displacement: 10,
          onRefresh: _refresh,
          child: LatestList(
            articles: state.articles,
            canLoadMore: state.canLoadMore,
          ),
        );
      }

      // Handle state is LastestListFailure
      if (state is LatestListFailure) {
        return RetryWidget(onClickRetry: () {
          BlocProvider.of<LatestListBloc>(context)
              .add(RefreshListLatestEvent());
        });
      }

      return AppLoadingIndicator();
    });
  }
}
