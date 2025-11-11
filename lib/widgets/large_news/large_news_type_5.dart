import 'package:flutter/material.dart';
import 'package:news/constant/font.dart';
import 'package:news/constant/length.dart';
import 'package:news/models/article_model.dart';
import 'package:news/widgets/ariticle_detail/push_to_detail.dart';
import 'package:news/widgets/large_news/big_image_widget.dart';
import 'package:news/widgets/divider_widget.dart';

class LargeNewsType5 extends StatelessWidget {
  const LargeNewsType5({
    Key key,
    @required this.article,
    this.showZoneName = false,
    this.isShowDivider = false,
    this.isSolid = false,
    this.isNotSapo = false,
    this.OnTap,
  }) : super(key: key);

  final Article article;
  final bool showZoneName;
  final bool isShowDivider;
  final bool isSolid;
  final bool isNotSapo;
  final ValueChanged<Article> OnTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Divider
        if (isShowDivider) DividerWidget(isSolid: isSolid),

        InkWell(
          child: Column(
            children: [
              // Image
              BigImageWidget(urlImage: this.article.getImageNews),

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
              if (!isNotSapo)
                Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.only(top: paddingNewsSapo / 2),
                  child: Text(
                    this.article.sapo,
                    style: KfontConstant.styleOfSapoLargeType2,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
            ],
          ),
          onTap: () => OnTap != null
              ? OnTap.call(this.article)
              : pushToDetail(article: this.article, context: context),
        ),
      ],
    );
  }
}
