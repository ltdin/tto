import 'package:flutter/material.dart';
import 'package:news/base/app_helpers.dart';
import 'package:news/constant/color.dart';
import 'package:news/constant/font.dart';
import 'package:news/constant/length.dart';
import 'package:news/models/article_model.dart';
import 'package:news/blocs/news_bloc.dart';
import 'package:news/widgets/app_loading.dart';
import 'package:news/widgets/appbar_for_tab.dart';
import 'package:news/widgets/large_news/large_news_type_2.dart';

class AuthorPage extends StatelessWidget {
  const AuthorPage({Key key, @required this.authorId}) : super(key: key);
  final String authorId;

  @override
  Widget build(BuildContext context) {
    printDebug("\n---------- Build author page id : ${authorId} -----------");

    return Scaffold(
      appBar: appBarWidget(title: 'Tác giả'),
      body: FutureBuilder(
        future: bloc.getAuthorNews(authorId: '39167'),
        builder: (context, AsyncSnapshot<List<Article>> snapshot) {
          if (snapshot.hasData && (snapshot.data?.isNotEmpty ?? false)) {
            final List<Article> articles = snapshot.data;

            return ListView.builder(
              padding: const EdgeInsets.only(
                left: paddingNews,
                right: paddingNews,
                bottom: paddingNews,
              ),
              itemCount: articles.length,
              itemBuilder: (context, int index) =>
                  _getAuthorItem(articles[index], index),
            );
          } else if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          }
          return AppLoadingIndicator();
        },
      ),
    );
  }

  Widget _getAuthorItem(Article article, int index) {
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
              'tag?.name',
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
