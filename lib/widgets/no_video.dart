import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news/base/app_helpers.dart';
import 'package:news/constant/bool.dart';
import 'package:news/constant/color.dart';
import 'package:news/widgets/app_loading.dart';
import 'package:news/widgets/no_image_widget.dart';
import 'package:news/models/globals.dart' as globals;

class NoVideo extends StatelessWidget {
  const NoVideo({
    Key key,
    this.avatarVideo,
    this.onClickPlayVideo,
    this.isLoadingVideo = FLAG_OFF,
  }) : super(key: key);

  final String avatarVideo;
  final VoidCallback onClickPlayVideo;
  final bool isLoadingVideo;

  @override
  Widget build(BuildContext context) {
    printDebug('build PlayVideoWidget $avatarVideo');

    return AspectRatio(
      aspectRatio: 3 / 2,
      child: InkWell(
        child: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
            color: CL_BACKGROUND_ITEM,
            image: DecorationImage(
              image: AssetImage(globals.getWhiteLogoTTO),
            ),
          ),
          child: Stack(
            children: [
              if (avatarVideo?.isNotEmpty ?? false)
                // Image
                CachedNetworkImage(
                  height: double.infinity,
                  imageUrl: avatarVideo,
                  imageBuilder: (context, imageProvider) => Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: imageProvider, fit: BoxFit.cover),
                      color: Colors.black12,
                    ),
                  ),
                  placeholder: (context, url) => const NoImageWidget(),
                  errorWidget: (context, url, dynamic error) =>
                      const NoImageWidget(),
                ),

              // Button play
              isLoadingVideo == FLAG_ON
                  ? AppLoadingIndicator()
                  : Align(
                      child: Image.asset('assets/images/buttonplay.png',
                          scale: 1.6),
                    ),
            ],
          ),
        ),
        onTap: onClickPlayVideo != null ? () => onClickPlayVideo.call() : () {},
      ),
    );
  }
}
