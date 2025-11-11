import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/base/app_helpers.dart';
import 'package:news/base/app_netcore.dart';
import 'package:news/constant/string.dart';
import 'package:news/pages/stars/widgets/stars_list.dart';
import 'package:news/widgets/app_loading.dart';
import 'package:news/widgets/retry_widget.dart';
import 'bloc/stars_list_bloc.dart';

class StarsPage extends StatelessWidget {
  const StarsPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Add  tracking event + tab name is Stars
    AppNetcore().addHomeEvent(
      pageName: KString.strHome,
      tabName: KString.STR_MANY_STARS_PAGE,
    );

    Future<void> _refresh() async {
      await Future.delayed(Duration(milliseconds: 200));
      BlocProvider.of<StarsListBloc>(context).add(RefreshListStarsEvent());
    }

    printDebug('\n------------------- Build Stars page -------------------\n');
    return BlocBuilder<StarsListBloc, StarsListState>(
        builder: (BuildContext context, StarsListState state) {
      // Handle state is RecommendListSuccess
      if (state is StarsListSuccess) {
        return RefreshIndicator(
          displacement: 10,
          onRefresh: _refresh,
          child: StarsList(articles: state.articles),
        );
      }

      // Handle state is RecommendListFailure
      if (state is StarsListFailure) {
        return RetryWidget(onClickRetry: () {
          BlocProvider.of<StarsListBloc>(context).add(RefreshListStarsEvent());
        });
      }

      return AppLoadingIndicator();
    });
  }
}
