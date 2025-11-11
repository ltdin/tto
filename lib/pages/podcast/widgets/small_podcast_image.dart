import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news/constant/length.dart';
import 'package:news/models/podcast_model.dart';
import 'package:news/widgets/no_image_widget.dart';

class SmallPodcastImage extends StatelessWidget {
  const SmallPodcastImage({
    Key key,
    @required this.podcast,
    this.height = heightSmallImage100,
  }) : super(key: key);

  final PodcastModel podcast;
  final double height;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      height: height,
      imageUrl: podcast?.mobileAvatar ?? podcast?.avatar,
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
