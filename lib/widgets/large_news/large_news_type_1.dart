import 'package:flutter/material.dart';
import 'package:news/base/app_helpers.dart';
import 'package:news/constant/font.dart';
import 'package:news/constant/length.dart';
import 'package:news/models/article_model.dart';
import 'package:news/widgets/ariticle_detail/push_to_detail.dart';
import 'package:news/widgets/large_news/big_image_widget.dart';

class LargeNewsType1 extends StatelessWidget {
  const LargeNewsType1({Key key, @required this.article}) : super(key: key);

  final Article article;

  @override
  Widget build(BuildContext context) {
    // final textTheme = Theme.of(context).textTheme;
    printDebug("Build news LargeNewsType1: ${article.title}");

    return InkWell(
      child: Column(
        children: [
          // Title
          Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.symmetric(vertical: paddingNews),
            child: Text(
              this.article.title,
              textAlign: TextAlign.start,
              style: KfontConstant.styleOfTitleLargeType1,
            ),
          ),

          // Image
          BigImageWidget(urlImage: this.article.getImageLargeType1),

          // Sapo
          Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.symmetric(vertical: paddingNewsSapo),
            child: Text(
              this.article.sapo,
              style: KfontConstant.styleOfSapoLargeType1,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
      onTap: () => pushToDetail(article: this.article, context: context),
    );
  }
}
