import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/base/app_helpers.dart';
import 'package:news/constant/length.dart';
import 'package:news/models/zone_model.dart';
import 'package:news/pages/category/bloc/tab_category_page_bloc.dart';
import 'package:news/pages/category/widgets/tab_category_list.dart';
import 'package:news/widgets/app_loading.dart';

class TabCategoryPage extends StatelessWidget {
  const TabCategoryPage({
    Key key,
    @required this.zone,
    this.tabKey,
  }) : super(key: key);

  final ZoneList zone;
  final Key tabKey;

  @override
  Widget build(BuildContext context) {
    printDebug("\n-------------- Build Tab : ${zone.name} ----------------\n");

    return BlocBuilder<TabCategoryPageBloc, TabCategoryPageState>(
      builder: (BuildContext context, TabCategoryPageState state) {
        // Handle state is TabCategoryPageSuccess
        if (state is TabCategoryPageSuccess) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: paddingNews),
            child: TabCategoryList(
              articles: state.articles,
              tabKey: tabKey,
              zone: zone,
              canLoadMore: state.canLoadMore,
            ),
          );
        }

        return AppLoadingIndicator();
      },
    );
  }
}
