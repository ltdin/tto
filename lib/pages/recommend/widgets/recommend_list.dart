import 'package:extended_nested_scroll_view/extended_nested_scroll_view.dart';
import 'package:flutter/material.dart' hide NestedScrollView;
import 'package:news/base/app_helpers.dart';
import 'package:news/constant/color.dart';
import 'package:news/constant/font.dart';
import 'package:news/constant/length.dart';
import 'package:news/models/article_model.dart';
import 'package:news/widgets/advertising/admod_banner.dart';
import 'package:news/widgets/large_news/large_news_type_2.dart';
import 'package:news/models/globals.dart' as globals;

class RecommendList extends StatelessWidget {
  const RecommendList({this.articles, Key key, this.canLoadMore})
      : super(key: key);

  final List<Article> articles;
  final bool canLoadMore;

  @override
  Widget build(BuildContext context) {
    printDebug('Build list Recommend : ${articles?.length}');

    return Padding(
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
                return index == articles.length - 1
                    ? Padding(
                        padding: const EdgeInsets.only(bottom: paddingNews),
                        child: LargeNewsType2(
                          article: articles[index],
                          isShowDivider: true,
                        ),
                      )
                    : _getArticleRecommendWidget(index);
              },
              childCount: articles.length,
            ),
          ),
        ],
      ),
    );
  }

  Widget _getArticleRecommendWidget(int index) {
    switch (index) {
      case 0:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: paddingNews, bottom: 8.0),
              child: Text(
                'Tin xem nhiều',
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
        return globals.isOpenAdmobInApp
            ? Column(
                children: [
                  // Admod ads
                  AdmodBanner(
                    padding: EdgeInsets.symmetric(vertical: paddingNews * 2),
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
        // Else return default
        return LargeNewsType2(
          article: articles[index],
          isShowDivider: true,
        );
    }
  }
}
