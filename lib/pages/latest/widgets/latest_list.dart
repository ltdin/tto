import 'package:extended_nested_scroll_view/extended_nested_scroll_view.dart';
import 'package:flutter/material.dart' hide NestedScrollView;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/base/app_helpers.dart';
import 'package:news/constant/color.dart';
import 'package:news/constant/font.dart';
import 'package:news/constant/length.dart';
import 'package:news/models/article_model.dart';
import 'package:news/pages/latest/bloc/latest_list_bloc.dart';
import 'package:news/widgets/advertising/admod_banner.dart';
import 'package:news/widgets/app_loading.dart';
import 'package:news/widgets/large_news/large_news_type_2.dart';
import 'package:news/models/globals.dart' as globals;

class LatestList extends StatelessWidget {
  const LatestList({this.articles, Key key, this.canLoadMore})
      : super(key: key);

  final List<Article> articles;
  final bool canLoadMore;

  @override
  Widget build(BuildContext context) {
    bool isLoading = canLoadMore;

    printDebug('Build list Recommend : ${articles?.length}');

    return NotificationListener<ScrollNotification>(
      onNotification: (ScrollNotification scrollInfo) {
        if (scrollInfo.metrics.pixels >= scrollInfo.metrics.maxScrollExtent &&
            !scrollInfo.metrics.outOfRange) {
          if (isLoading == true) {
            isLoading = false;
            BlocProvider.of<LatestListBloc>(context)
                .add(const LoadMoreLatestListEvent());
          }
          return true;
        } else {
          return false;
        }
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: paddingNews),
        child: CustomScrollView(
          shrinkWrap: true,
          slivers: <Widget>[
            SliverOverlapInjector(
              handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, int index) {
                  return index >= articles.length
                      ? Padding(
                          padding:
                              const EdgeInsets.symmetric(vertical: paddingNews),
                          child: AppLoadingIndicator(),
                        )
                      : _getArticleLatestWidget(index);
                },
                childCount: canLoadMore ? articles.length + 1 : articles.length,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _getArticleLatestWidget(int index) {
    switch (index) {
      case 0:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: paddingNews, bottom: 8.0),
              child: Text(
                'Tin mới nhất',
                style: KfontConstant.styleOfRecommend
                    .copyWith(fontWeight: FontWeight.bold),
              ),
            ),
            Text(
              AppHelpers.getNowFullDate(),
              style: KfontConstant.styleOfTimeInRecommend,
            ),

            //
            LargeNewsType2(
              article: articles.first,
              isShowDivider: true,
              isSolid: true,
              color: dividerColor,
            ),
          ],
        );
        break;

      case 5:
        return (!globals.isShowAds)
            ? Column(
                children: [
                  // Admod ads
                  RepaintBoundary(
                    child: AdmodBanner(
                      padding: EdgeInsets.symmetric(vertical: paddingNews * 2),
                    ),
                  ),
                  LargeNewsType2(article: articles[index])
                ],
              )
            : LargeNewsType2(
                article: articles[index],
                isShowDivider: true,
              );

        break;

      default:
        return LargeNewsType2(
          article: articles[index],
          isShowDivider: true,
        );
    }
  }
}
