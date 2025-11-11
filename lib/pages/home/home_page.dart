import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/base/app_helpers.dart';
import 'package:news/base/app_netcore.dart';
import 'package:news/constant/string.dart';
import 'package:news/pages/home/bloc/home_list_bloc.dart';
import 'package:news/pages/home/widgets/home_list.dart';
import 'package:news/widgets/app_loading.dart';
import 'package:news/widgets/retry_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Add home tracking event + tab name is Home
    AppNetcore()
        .addHomeEvent(pageName: KString.strHome, tabName: KString.HOME_PAGE);

    Future<void> _refresh() async {
      BlocProvider.of<HomeListBloc>(context).add(RefreshHomeListEvent());
      await Future.delayed(Duration(milliseconds: 500));
    }

    printDebug('\n----------------- Build home page ---------------------\n');

    return BlocBuilder<HomeListBloc, HomeListState>(
        builder: (BuildContext context, HomeListState state) {
      //
      if (state is HomeListSuccess) {
        return RefreshIndicator(
          onRefresh: _refresh,
          child: HomeList(homeStructs: state.homeStructs),
        );
      }

      // Handle error
      if (state is HomeListFailure) {
        return RetryWidget(onClickRetry: _refresh);
      }

      //
      return AppLoadingIndicator();
    });
  }
}
