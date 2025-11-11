import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news/widgets/app_loading_animation.dart';

import 'package:news/widgets/no_image_widget.dart';

class ItemNewspaperViewer extends StatelessWidget {
  const ItemNewspaperViewer({Key key, @required this.urlImage})
      : super(key: key);

  final String urlImage;

  @override
  Widget build(BuildContext context) {
    return InteractiveViewer(
      minScale: 1.0,
      maxScale: 8.0,
      child: Container(
        margin: EdgeInsets.all(20.0),
        child: CachedNetworkImage(
          imageUrl: urlImage,
          imageBuilder: (context, imageProvider) => Container(
            decoration: BoxDecoration(
              color: Colors.white,
              image: DecorationImage(
                image: imageProvider,
                fit: BoxFit.contain,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.38),
                  spreadRadius: 3,
                  blurRadius: 5,
                  offset: Offset(0, 3),
                ),
              ],
            ),
          ),
          placeholder: (context, url) => AppLoadingAnimation(),
          placeholderFadeInDuration: Duration(milliseconds: 500),
          errorWidget: (context, url, dynamic error) =>
              Center(child: const NoImageWidget()),
        ),
      ),
    );
  }
}
