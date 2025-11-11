import 'package:flutter/material.dart';
import 'package:news/constant/color.dart';
import 'package:news/constant/enum.dart';
import 'package:news/constant/font.dart';
import 'package:news/constant/length.dart';
import 'package:news/constant/number.dart';
import 'package:news/models/article_model.dart';
import 'package:news/widgets/ariticle_detail/push_to_detail.dart';
import 'package:news/widgets/divider_widget.dart';
import 'package:news/widgets/stack_icon_ride_small_image.dart';

class ItemSmallHealthBylaw extends StatelessWidget {
  const ItemSmallHealthBylaw({
    Key key,
    @required this.index,
    @required this.article,
  }) : super(key: key);

  final int index;
  final Article article;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (index != FIRST_INDEX)
          DividerWidget(
            subtract: paddingNews32,
            color: dividerColor,
          ),

        // News
        InkWell(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: paddingNews),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                // Image & button play
                Expanded(
                  flex: 4,
                  child: StackIconRideSmallImage(
                    type: RideType.LEFTBOTTOM,
                    linkImage: article.getAvata,
                    rideWidget: Image.asset(
                      'assets/images/buttonplay.png',
                      width: 24.0,
                      height: 24.0,
                    ),
                  ),
                ),

                // Title
                Expanded(
                  flex: 6,
                  child: Container(
                    height: heightSmallNews100,
                    padding: EdgeInsets.only(left: paddingNews),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            article.getTitle,
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                            style: KfontConstant.styleOfTitleSmallType1,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          onTap: () => pushToDetail(context: context, article: article),
        ),
      ],
    );
  }
}
