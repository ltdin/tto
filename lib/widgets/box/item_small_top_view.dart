import 'package:flutter/material.dart';
import 'package:news/constant/color.dart';
import 'package:news/constant/enum.dart';
import 'package:news/constant/font.dart';
import 'package:news/constant/length.dart';
import 'package:news/models/article_model.dart';
import 'package:news/widgets/ariticle_detail/push_to_detail.dart';
import 'package:news/widgets/stack_icon_ride_small_image.dart';

class ItemSmallTopView extends StatelessWidget {
  const ItemSmallTopView({
    Key key,
    @required this.article,
    this.index = 1,
  }) : super(key: key);

  final Article article;
  final int index;

  @override
  Widget build(BuildContext context) {
    final _avatar = article.getAvata;

    return InkWell(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // Image video
          StackIconRideSmallImage(
            type: RideType.LEFTTOP,
            heightImage: heightSmallNews150,
            linkImage: _avatar,
            rideWidget: Container(
              width: 32,
              height: 38,
              color: textPositionBoxTopViewColor,
              child: Center(
                child: Text(
                  index.toString(),
                  style: KfontConstant.styleOfTitleLargeType1
                      .copyWith(color: CL_WHITE),
                ),
              ),
            ),
          ),

          // Category
          Padding(
            padding: const EdgeInsets.only(
              left: paddingNewsTitle,
              right: paddingNewsTitle,
              top: paddingNewsTitle,
              bottom: paddingNewsTitle / 2,
            ),
            child: Text(
              article.zoneName,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: KfontConstant.styleOfListCategory,
            ),
          ),

          // Title
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: paddingNewsTitle),
            child: Text(
              article.title,
              maxLines: 4,
              overflow: TextOverflow.ellipsis,
              style: KfontConstant.styleOfTitleSmallType2,
            ),
          )
        ],
      ),
      onTap: () => pushToDetail(article: article, context: context),
    );
  }
}
