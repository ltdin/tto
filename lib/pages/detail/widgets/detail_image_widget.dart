import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news/models/body_row.dart';
import 'package:news/widgets/no_image_widget.dart';

class DetailImageWidget extends StatelessWidget {
  const DetailImageWidget({Key key, @required this.img}) : super(key: key);

  final Img img;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 16 / 13,
      // aspectRatio: img?.size?.aspectRatio ?? 1,
      child: CachedNetworkImage(
        imageUrl: img?.src ?? '',
        imageBuilder: (context, imageProvider) => Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: imageProvider,
              // fit: BoxFit.cover,
            ),
          ),
        ),
        placeholder: (context, url) => const NoImageWidget(),
        errorWidget: (context, url, dynamic error) => const NoImageWidget(),
      ),
    );
  }
}
