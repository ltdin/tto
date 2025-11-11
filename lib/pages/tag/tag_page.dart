import 'package:flutter/material.dart';
import 'package:news/base/app_helpers.dart';
import 'package:news/base/app_netcore.dart';
import 'package:news/constant/color.dart';
import 'package:news/constant/font.dart';
import 'package:news/constant/length.dart';
import 'package:news/constant/string.dart';
import 'package:news/models/article_model.dart';
import 'package:news/blocs/news_bloc.dart';
import 'package:news/models/tag.dart';
import 'package:news/models/zone_model.dart';
import 'package:news/widgets/app_loading.dart';
import 'package:news/widgets/appbar_for_tab.dart';
import 'package:news/widgets/large_news/large_news_type_2.dart';

class TagPage extends StatelessWidget {
  const TagPage({Key key, @required this.tag}) : super(key: key);

  final Tag tag;

  @override
  Widget build(BuildContext context) {
    printDebug("\n-------- Build tag page: ${tag?.getTagSearch} ---------");

    return Scaffold(
      appBar: appBarWidget(title: 'Tag'),
      body: FutureBuilder(
        future: bloc.getTagNews(tagUrl: tag?.getTagSearch),
        builder: (context, AsyncSnapshot<List<Article>> snapshot) {
          if (snapshot.hasData) {
            // Add tag event
            AppNetcore().addTagEvent(
              zoneList: ZoneList(name: tag.getTagName, shortUrl: tag.getUrlTag),
            );

            if (snapshot.data.isNotEmpty) {
              final List<Article> articles = snapshot.data;

              return ListView.builder(
                padding: const EdgeInsets.only(
                  left: paddingNews,
                  right: paddingNews,
                  bottom: paddingNews,
                ),
                itemCount: articles.length,
                itemBuilder: (context, int index) =>
                    _getTagItem(articles[index], index),
              );
            } else {
              return Center(child: Text(KString.msgNoData));
            }
          }

          // Error
          if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          }

          return AppLoadingIndicator();
        },
      ),
    );
  }

  Widget _getTagItem(Article article, int index) {
    switch (index) {
      case 0:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: paddingNews, bottom: 8.0),
              child: Text(
                'Tag:',
                style: KfontConstant.styleOfTimeInRecommend,
              ),
            ),
            Text(
              tag?.getTagName,
              style: KfontConstant.styleOfRecommend
                  .copyWith(fontWeight: FontWeight.bold),
            ),
            LargeNewsType2(
              article: article,
              isShowDivider: true,
              isSolid: true,
              color: dividerColor,
            ),
          ],
        );
        break;

      default:
        return LargeNewsType2(article: article, isShowDivider: true);
    }
  }
}
