import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news/constant/length.dart';
import 'package:news/widgets/no_image_widget.dart';

class SpecialBigImage extends StatelessWidget {
  const SpecialBigImage({
    Key key,
    @required this.urlImage,
    this.isDetail = false,
    this.fit = BoxFit.fill,
    this.plusHeight = 0.0,
  }) : super(key: key);

  final String urlImage;
  final bool isDetail;
  final BoxFit fit;
  final double plusHeight;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 6 / 8,
      child: CachedNetworkImage(
        imageUrl: urlImage,
        imageBuilder: (context, imageProvider) => Container(
          decoration: BoxDecoration(
            image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
            borderRadius: BorderRadius.circular(imageBorderRadius),
          ),
        ),
        placeholder: (context, url) => const NoImageWidget(),
        errorWidget: (context, url, dynamic error) => const NoImageWidget(),
      ),
    );
  }
}
