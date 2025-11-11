import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news/constant/length.dart';
import 'package:news/models/daily_newspaper.dart';
import 'package:news/widgets/app_loading.dart';
import 'package:news/widgets/no_image_widget.dart';

class IteamDailyNewspaper extends StatelessWidget {
  const IteamDailyNewspaper({Key key, this.dailyNewspaper, this.onTap})
      : super(key: key);

  final DailyNewspaper dailyNewspaper;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: CachedNetworkImage(
        imageUrl: dailyNewspaper.thumbnailUrl,
        imageBuilder: (context, imageProvider) => Container(
          height: heightLargeNews415,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: imageProvider,
              fit: BoxFit.fill,
            ),
            color: Colors.black12,
            borderRadius: BorderRadius.circular(4.0),
          ),
        ),
        placeholder: (context, url) => Container(
          height: heightLargeNews415,
          child: const AppLoadingIndicator(),
        ),
        errorWidget: (context, url, dynamic error) => const NoImageWidget(),
      ),
      onTap: onTap,
    );
  }
}
