import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/base/app_helpers.dart';
import 'package:news/constant/length.dart';
import 'package:news/constant/number.dart';
import 'package:news/constant/string.dart';
import 'package:news/pages/recently_read/bloc/recently_read_bloc.dart';
import 'package:news/widgets/app_loading.dart';
import 'package:news/widgets/appbar_for_tab.dart';
import 'package:news/widgets/no_data_widget.dart';
import 'package:news/widgets/small_news/small_news_type_1.dart';

class RecentlyReadPage extends StatelessWidget {
  const RecentlyReadPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    printDebug('Build RecentlyReadPage');

    return Scaffold(
      appBar: appBarWidget(title: KString.strRecentlyRead, centerTitle: true),
      body: BlocBuilder<RecentlyReadBloc, RecentlyReadState>(
        builder: (context, RecentlyReadState state) {
          // Handle state is ViewedNewsSuccess
          if (state is ViewedNewsSuccess) {
            return ListView.builder(
              padding: EdgeInsets.all(paddingNews),
              shrinkWrap: true,
              itemCount: state.articles.length,
              itemBuilder: (context, int index) {
                return SmallNewsType1(
                  article: state.articles[index],
                  isShowDivider: index != FIRST_INDEX,
                );
              },
            );
          }

          // Handle state is ViewedNewsSuccess
          if (state is RecentlyReadNodata) {
            return NoDataWidget();
          }

          return AppLoadingIndicator();
        },
      ),
    );
  }
}
