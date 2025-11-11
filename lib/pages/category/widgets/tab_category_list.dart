import 'package:flutter/material.dart';
import 'package:extended_nested_scroll_view/extended_nested_scroll_view.dart'
    as nestedScrollView;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/base/app_helpers.dart';
import 'package:news/models/zone_model.dart';
import 'package:news/models/article_model.dart';
import 'package:news/pages/category/bloc/tab_category_page_bloc.dart';
import 'package:news/widgets/app_loading.dart';
import 'package:news/widgets/large_news/large_news_type_1.dart';
import 'package:news/widgets/large_news/large_news_type_2.dart';
import 'package:news/widgets/small_news/small_news_type_1.dart';

class TabCategoryList extends StatelessWidget {
  const TabCategoryList(
      {Key key,
      @required this.articles,
      this.tabKey,
      this.zone,
      this.canLoadMore})
      : super(key: key);

  final List<Article> articles;
  final Key tabKey;
  final ZoneList zone;
  final bool canLoadMore;

  @override
  Widget build(BuildContext context) {
    bool isLoading = canLoadMore;

    return nestedScrollView.NestedScrollViewInnerScrollPositionKeyWidget(
      tabKey,
      NotificationListener<ScrollNotification>(
        onNotification: (ScrollNotification scrollInfo) {
          if (scrollInfo.metrics.pixels >= scrollInfo.metrics.maxScrollExtent &&
              !scrollInfo.metrics.outOfRange) {
            if (isLoading == true) {
              isLoading = false;
              printDebug('Load more ${zone.name}');
              BlocProvider.of<TabCategoryPageBloc>(context)
                  .add(TabCategoryLoadMoreListEvent(zone: zone));
            }
            return true;
          } else {
            return false;
          }
        },
        child: CustomScrollView(
          slivers: <Widget>[
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  return index >= articles.length
                      ? Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: AppLoadingIndicator(),
                        )
                      : _getArticleCateWidget(index);
                },
                childCount: canLoadMore ? articles.length + 1 : articles.length,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _getArticleCateWidget(int index) {
    switch (index) {
      case 0:
        return LargeNewsType1(article: articles[index]);
        break;

      case 1:
        return SmallNewsType1(
          article: articles[index],
          isSolidDivider: true,
        );
        break;

      default:
        return index > 1 && index < 9
            ? SmallNewsType1(article: articles[index])
            : LargeNewsType2(article: articles[index], isShowDivider: true);
    }
  }
}
