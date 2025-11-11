import 'package:flutter/material.dart';
import 'package:news/base/app_helpers.dart';
import 'package:news/constant/font.dart';
import 'package:news/constant/length.dart';
import 'package:news/models/article_model.dart';
import 'package:news/models/special_article.dart';
import 'package:news/widgets/ariticle_detail/push_to_detail.dart';
import 'package:news/widgets/divider_widget.dart';
import 'package:news/widgets/large_news/big_image_widget.dart';
import 'package:news/widgets/large_news/topic_widget.dart';
import 'package:news/widgets/small_news/generate_small_list_time_title_horizontal.dart';

class SpecialType3 extends StatelessWidget {
  const SpecialType3({
    Key key,
    @required this.specialArticles,
    this.showZoneName = false,
    this.isShowDivider = false,
  }) : super(key: key);

  final SpecialArticle specialArticles;
  final bool showZoneName;
  final bool isShowDivider;

  @override
  Widget build(BuildContext context) {
    printDebug(
      'SpecialType3 : ${this.specialArticles.article.getUrlSpecialImageLarge}',
    );

    return Column(
      children: [
        // Divider
        if (isShowDivider) DividerWidget(),

        // Topic
        TopicWidget(threadName: specialArticles?.threadName ?? ''),

        // Large news
        InkWell(
          child: Column(
            children: [
              // Title
              Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.only(bottom: paddingNews),
                child: Text(
                  this.specialArticles.article.title,
                  textAlign: TextAlign.start,
                  style: KfontConstant.styleOfTitleLargeType4,
                ),
              ),

              // Image
              BigImageWidget(
                urlImage: this.specialArticles.article.getUrlImageLarge480x300,
              ),
            ],
          ),
          onTap: () => onTapDetail(context, specialArticles.article),
        ),

        // List small time + title
        if (specialArticles?.newsThreadItems?.isNotEmpty ?? false)
          GenerateSmallListTimeTitleHorizontal(
            articles: specialArticles.newsThreadItems,
          )
      ],
    );
  }

  void onTapDetail(BuildContext context, Article article) {
    pushToDetail(article: article, context: context);
  }
}
