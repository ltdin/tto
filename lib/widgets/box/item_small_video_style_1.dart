import 'package:flutter/material.dart';
import 'package:news/constant/enum.dart';
import 'package:news/constant/font.dart';
import 'package:news/constant/length.dart';
import 'package:news/models/article_model.dart';
import 'package:news/widgets/ariticle_detail/push_to_detail.dart';
import 'package:news/widgets/stack_icon_ride_small_image.dart';

class ItemSmallVideoStyle1 extends StatelessWidget {
  const ItemSmallVideoStyle1({
    Key key,
    @required this.article,
  }) : super(key: key);
  final Article article;

  @override
  Widget build(BuildContext context) {
    final _avatar = article.avatar;

    return InkWell(
      child: Column(
        children: <Widget>[
          // Image video
          StackIconRideSmallImage(
            type: RideType.LEFTBOTTOM,
            heightImage: heightSmallImage120,
            linkImage: _avatar,
            rideWidget: Image.asset(
              'assets/images/buttonplay.png',
              width: 24.0,
              height: 24.0,
            ),
          ),

          // Title video
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: const EdgeInsets.only(top: paddingNewsTitle),
              child: Text(
                article.title,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: KfontConstant.styleOfTitleSmallType2,
              ),
            ),
          )
        ],
      ),
      onTap: () => pushToDetail(article: article, context: context),
    );
  }
}
