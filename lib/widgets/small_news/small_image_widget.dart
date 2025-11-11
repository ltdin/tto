import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news/constant/length.dart';
import 'package:news/models/article_model.dart';
import 'package:news/widgets/no_image_widget.dart';

class SmallImageWidget extends StatelessWidget {
  const SmallImageWidget({
    Key key,
    @required this.article,
    this.type,
    this.height = heightSmallImage100,
  }) : super(key: key);

  final Article article;
  final String type;
  final double height;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      height: this.height,
      imageUrl:
          (this.type != null) ? article.getImageNews : article.defaultAvatar,
      imageBuilder: (context, imageProvider) => Container(
        decoration: BoxDecoration(
          image: DecorationImage(image: imageProvider, fit: BoxFit.fill),
          color: Colors.black12,
          borderRadius: BorderRadius.circular(imageBorderRadius),
        ),
      ),
      placeholder: (context, url) => const NoImageWidget(),
      errorWidget: (context, url, dynamic error) => const NoImageWidget(),
    );
  }
}
