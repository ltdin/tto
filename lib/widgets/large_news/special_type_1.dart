import 'package:flutter/material.dart';
import 'package:news/constant/color.dart';
import 'package:news/constant/font.dart';
import 'package:news/constant/length.dart';
import 'package:news/models/article_model.dart';
import 'package:news/models/special_article.dart';
import 'package:news/widgets/ariticle_detail/push_to_detail.dart';
import 'package:news/widgets/divider_widget.dart';
import 'package:news/widgets/large_news/special_big_image.dart';
import 'package:news/widgets/small_news/small_news_type_2.dart';

class SpecialType1 extends StatelessWidget {
  const SpecialType1({
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
    return Column(
      children: [
        // Divider
        if (isShowDivider) DividerWidget(),

        // News 1
        InkWell(
          child: Column(
            children: [
              // Title 1
              Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.symmetric(vertical: 0),
                child: Text(
                  this.specialArticles.article.getTitle,
                  textAlign: TextAlign.start,
                  style: KfontConstant.styleOfTitleLargeType3,
                ),
              ),

              // Sapo 1
              Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.only(
                  top: paddingNewsSapo / 2,
                  bottom: paddingNews,
                ),
                child: Text(
                  this.specialArticles.article.sapo,
                  style: KfontConstant.styleOfSapoLargeType3,
                ),
              ),

              // Image 1
              SpecialBigImage(
                urlImage: this.specialArticles.article.getUrlSpecialImageLarge,
              ),
            ],
          ),
          onTap: () => onTapDetail(context, this.specialArticles.article),
        ),

        // News 2
        if (this.specialArticles?.newsRelations?.isNotEmpty ?? false)
          Container(
            margin: const EdgeInsets.only(top: paddingNews),
            child: InkWell(
              child: Padding(
                padding: const EdgeInsets.all(paddingNews),
                child: SmallNewsType2(
                  article: this.specialArticles.newsRelations.first,
                  type: '1',
                ),
              ),
              onTap: () => onTapDetail(
                context,
                this.specialArticles.newsRelations.first,
              ),
            ),
            decoration: BoxDecoration(
              color: cardNewsBackgroundColor,
              border: Border.all(color: cardNewsBorderColor),
              borderRadius: BorderRadius.circular(radius8),
            ),
          )
      ],
    );
  }

  void onTapDetail(BuildContext context, Article article) {
    pushToDetail(article: article, context: context);
  }
}
