import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news/constant/length.dart';
import 'package:news/widgets/no_image_widget.dart';

class ImageNetworkLoading extends StatelessWidget {
  const ImageNetworkLoading({
    Key key,
    @required this.urlImage,
    this.height = heightSmallImage100,
    this.width = double.infinity,
    this.fit = BoxFit.cover,
  }) : super(key: key);

  final String urlImage;
  final double height;
  final double width;
  final BoxFit fit;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      height: this.height,
      width: this.width,
      imageUrl: urlImage,
      imageBuilder: (context, imageProvider) => Container(
        decoration: BoxDecoration(
          image: DecorationImage(image: imageProvider, fit: fit),
          color: Colors.black12,
          borderRadius: BorderRadius.circular(imageBorderRadius),
        ),
      ),
      placeholder: (context, url) => const NoImageWidget(),
      errorWidget: (context, url, dynamic error) => const NoImageWidget(),
    );
  }
}
