import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news/constant/length.dart';
import 'package:news/widgets/no_image_widget.dart';

class SmallImageType1 extends StatelessWidget {
  const SmallImageType1({
    Key key,
    @required this.urlImage,
    this.height = heightSmallImage100,
  }) : super(key: key);

  final String urlImage;
  final double height;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      height: this.height,
      imageUrl: urlImage,
      imageBuilder: (context, imageProvider) => Container(
        decoration: BoxDecoration(
          image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
          color: Colors.black12,
          borderRadius: BorderRadius.circular(imageBorderRadius),
        ),
      ),
      placeholder: (context, url) => const NoImageWidget(),
      errorWidget: (context, url, dynamic error) => const NoImageWidget(),
    );
  }
}
