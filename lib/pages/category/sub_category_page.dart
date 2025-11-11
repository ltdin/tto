import 'package:flutter/material.dart';
import 'package:news/base/app_helpers.dart';
import 'package:news/base/app_netcore.dart';
import 'package:news/constant/length.dart';
import 'package:news/models/article_model.dart';
import 'package:news/blocs/news_bloc.dart';
import 'package:news/models/zone_model.dart';
import 'package:news/widgets/app_loading.dart';
import 'package:news/widgets/appbar_for_tab.dart';
import 'package:news/widgets/large_news/large_news_type_1.dart';
import 'package:news/widgets/large_news/large_news_type_2.dart';
import 'package:news/widgets/small_news/small_news_type_1.dart';

class SubCategoryPage extends StatelessWidget {
  const SubCategoryPage({Key key, @required this.zone, this.parentCategory})
      : super(key: key);

  final ZoneList zone;
  final String parentCategory;

  @override
  Widget build(BuildContext context) {
    printDebug("Build subcategory : ${zone?.name}");

    return Scaffold(
      appBar: appBarWidget(title: zone?.name),
      body: FutureBuilder(
        future: bloc.fetchListingByZone(zoneId: zone.zoneId.toString()),
        builder: (context, AsyncSnapshot<List<Article>> snapshot) {
          if (snapshot.hasData && (snapshot.data?.isNotEmpty ?? false)) {
            final List<Article> articles = snapshot.data;

            // Add event sub category
            AppNetcore().addSubCategoryEvent(
              zoneList: zone,
              parentCategory: parentCategory,
            );

            return ListView.builder(
              padding: const EdgeInsets.only(
                left: paddingNews,
                right: paddingNews,
                bottom: paddingNews,
              ),
              itemCount: articles.length,
              itemBuilder: (context, int index) =>
                  _getArticleSubCate(articles[index], index),
            );
          } else if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          }
          return AppLoadingIndicator();
        },
      ),
    );
  }

  Widget _getArticleSubCate(Article article, int index) {
    switch (index) {
      case 0:
        return LargeNewsType1(article: article);
        break;

      case 1:
        return SmallNewsType1(article: article, isSolidDivider: true);
        break;

      default:
        return index > 1 && index < 9
            ? SmallNewsType1(article: article)
            : LargeNewsType2(article: article, isShowDivider: true);
    }
  }
}
