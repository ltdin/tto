import 'package:flutter/material.dart';
import 'package:news/base/app_helpers.dart';
import 'package:news/constant/font.dart';
import 'package:news/models/article_model.dart';
import 'package:news/widgets/ariticle_detail/push_to_detail.dart';
import 'package:news/widgets/divider_widget.dart';

class SmallNewsType1 extends StatelessWidget {
  const SmallNewsType1({
    Key key,
    @required this.article,
    this.isSolidDivider = false,
    this.isShowDivider = true,
    this.OnTap,
    this.colorDivider,
  }) : super(key: key);

  final Article article;
  final bool isSolidDivider;
  final bool isShowDivider;
  final Color colorDivider;
  final VoidCallback OnTap;

  @override
  Widget build(BuildContext context) {
    printDebug("Build news : ${article?.title}");

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Divider
        if (isShowDivider)
          DividerWidget(
            isSolid: isSolidDivider,
            color: colorDivider,
          ),

        //
        InkWell(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // Title
              Expanded(
                flex: 6,
                child: Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      article?.getTitle ?? '',
                      style: KfontConstant.styleOfTitleSmallType1,
                      maxLines: 4,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ),

              // Image
              Expanded(
                flex: 4,
                child: article.getSmallImageWidget,
              ),
            ],
          ),
          onTap: () => OnTap != null
              ? OnTap.call()
              : pushToDetail(article: article, context: context),
        )
      ],
    );
  }
}
