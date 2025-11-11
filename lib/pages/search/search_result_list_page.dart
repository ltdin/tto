import 'package:flutter/material.dart';
import 'package:news/base/app_theme.dart';
import 'package:news/blocs/news_bloc.dart';
import 'package:news/constant/font.dart';
import 'package:news/constant/length.dart';
import 'package:news/constant/number.dart';
import 'package:news/constant/string.dart';
import 'package:news/models/article_model.dart';
import 'package:news/widgets/app_loading.dart';
import 'package:news/widgets/ariticle_detail/push_to_detail.dart';
import 'package:news/widgets/header_box_widget.dart';
import 'package:news/widgets/item_small_article.dart';
import 'package:news/widgets/small_news/small_news_type_1.dart';

class SearchResultListPage extends StatelessWidget {
  const SearchResultListPage();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: bloc.getNewsInterest('0'),
      builder: (context, AsyncSnapshot<List<Article>> snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            padding: const EdgeInsets.symmetric(
              horizontal: paddingNews,
              vertical: paddingNews,
            ),
            shrinkWrap: true,
            itemCount: snapshot.data.length,
            itemBuilder: (context, int index) {
              if (index == FIRST_INDEX) {
                return Column(
                  children: [
                    HeaderBoxWidget(
                      title: '# ${KString.searchHomeBoxRecommendTitle}',
                      isTrailing: false,
                      paddingTitle: EdgeInsets.zero,
                      titleStyle: KfontConstant.tabLabelStyle.copyWith(
                        color: AppTheme().currentTheme.indicatorColor,
                      ),
                    ),
                    SizedBox(height: paddingNews),
                    ItemSmallArticle(article: snapshot.data[index]),
                  ],
                );
              }

              return InkWell(
                child: SmallNewsType1(article: snapshot.data[index]),
                onTap: () => pushToDetail(
                  article: snapshot.data[index],
                  context: context,
                ),
              );
            },
          );
        } else if (snapshot.hasError) {
          return Center(child: Text(snapshot.error.toString()));
        }

        return AppLoadingIndicator();
      },
    );
  }
}
