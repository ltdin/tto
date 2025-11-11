import 'package:flutter/material.dart';
import 'package:news/constant/enum.dart';
import 'package:news/constant/length.dart';
import 'package:news/models/article_model.dart';
import 'package:news/widgets/large_news/big_image_widget.dart';

class StackIconRideBigImage extends StatelessWidget {
  const StackIconRideBigImage({
    Key key,
    @required this.article,
    this.plusHeight = 0.0,
    this.type = RideType.CENTER,
    this.rideWidget,
  }) : super(key: key);

  final Article article;
  final RideType type;
  final double plusHeight;
  final Widget rideWidget;

  @override
  Widget build(BuildContext context) {
    switch (type) {
      case RideType.LEFTBOTTOM:
        return Stack(
          alignment: Alignment.center,
          children: [
            BigImageWidget(urlImage: article.getImageLargeType1),
            Positioned(
              bottom: paddingNews / 2,
              left: paddingNews / 2,
              child: rideWidget ?? Offstage(),
            )
          ],
        );

      default:
        return Stack(
          alignment: Alignment.center,
          children: [
            BigImageWidget(urlImage: article.getImageLargeType1),
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
