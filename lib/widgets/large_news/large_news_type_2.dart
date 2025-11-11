import 'package:flutter/material.dart';
import 'package:news/base/app_helpers.dart';
import 'package:news/constant/font.dart';
import 'package:news/constant/length.dart';
import 'package:news/models/article_model.dart';
import 'package:news/widgets/ariticle_detail/push_to_detail.dart';
import 'package:news/widgets/divider_widget.dart';

class LargeNewsType2 extends StatelessWidget {
  const LargeNewsType2({
    Key key,
    @required this.article,
    this.showZoneName = false,
    this.isShowDivider = false,
    this.isSolid = false,
    this.color,
  }) : super(key: key);

  final Article article;
  final bool showZoneName;
  final bool isShowDivider;
  final bool isSolid;
  final Color color;

  @override
  Widget build(BuildContext context) {
    printDebug("Build news : ${article.title}");

    return Column(
      children: [
        // Divider
        if (isShowDivider) DividerWidget(isSolid: isSolid, color: color),

        InkWell(
          child: Column(
            children: [
              // Title
              Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  this.article.title,
                  textAlign: TextAlign.start,
                  style: KfontConstant.styleOfTitleLargeType2,
                ),
              ),

              // Sapo
              Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.only(
                  top: paddingNewsSapo / 2,
                  bottom: paddingNews,
                ),
                child: Text(
                  this.article.sapo,
                  style: KfontConstant.styleOfSapoLargeType2,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              ),

              // Image
              article.getLargeImageWidget
            ],
          ),
          onTap: () => pushToDetail(article: this.article, context: context),
        ),
      ],
    );
  }
}
