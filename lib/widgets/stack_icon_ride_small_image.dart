import 'package:flutter/material.dart';
import 'package:news/constant/enum.dart';
import 'package:news/constant/length.dart';
import 'package:news/models/article_model.dart';
import 'package:news/widgets/small_news/small_image_widget.dart';

class StackIconRideSmallImage extends StatelessWidget {
  const StackIconRideSmallImage({
    Key key,
    this.linkImage = '',
    this.heightImage = heightSmallImage100,
    this.type = RideType.CENTER,
    this.rideWidget,
  }) : super(key: key);

  final double heightImage;
  final String linkImage;
  final RideType type;
  final Widget rideWidget;

  @override
  Widget build(BuildContext context) {
    switch (type) {
      case RideType.LEFTBOTTOM:
        return Stack(
          children: [
            SmallImageWidget(
              height: heightImage,
              article: Article(avatar: linkImage, defaultAvatar: linkImage),
            ),
            Positioned(
              bottom: paddingNews / 2,
              left: paddingNews / 2,
              child: rideWidget ?? Offstage(),
            )
          ],
        );
        break;

      case RideType.LEFTTOP:
        return Stack(
          children: [
            SmallImageWidget(
              height: heightImage,
              article: Article(avatar: linkImage, defaultAvatar: linkImage),
            ),
            Positioned(
              top: 0.0,
              left: 0.0,
              child: rideWidget ?? Offstage(),
            )
          ],
        );
        break;

      default:
        return Stack(
          alignment: Alignment.center,
          children: [
            SmallImageWidget(
              height: heightImage,
              article: Article(avatar: linkImage, defaultAvatar: linkImage),
            ),
            Positioned(
              child: Image.asset(
                'assets/images/buttonplay.png',
                width: 24.0,
                height: 24.0,
              ),
            )
          ],
        );
        break;
    }
  }
}
