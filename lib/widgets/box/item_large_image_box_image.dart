import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news/base/app_helpers.dart';
import 'package:news/constant/enum.dart';
import 'package:news/constant/font.dart';
import 'package:news/constant/length.dart';
import 'package:news/models/article_model.dart';
import 'package:news/widgets/ariticle_detail/push_to_detail.dart';
import 'package:news/widgets/no_image_widget.dart';

class ItemLargeImageBoxImage extends StatelessWidget {
  const ItemLargeImageBoxImage({
    Key key,
    @required this.article,
    this.tabIndex,
  }) : super(key: key);

  final Article article;
  final EnumBoxPicture tabIndex;

  @override
  Widget build(BuildContext context) {
    printDebug('ItemLargeImageBoxImage :  ${article.getUrlSpecialImageLarge}');

    return InkWell(
      child: Stack(
        alignment: AlignmentDirectional.bottomStart,
        children: [
          AspectRatio(
            aspectRatio: 6 / 8,
            child: CachedNetworkImage(
              imageUrl: article.getUrlSpecialImageLarge,
              imageBuilder: (context, imageProvider) => Container(
                decoration: BoxDecoration(
                  image:
                      DecorationImage(image: imageProvider, fit: BoxFit.cover),
                  borderRadius: BorderRadius.circular(imageBorderRadius),
                ),
              ),
              placeholder: (context, url) => const NoImageWidget(),
              errorWidget: (context, url, dynamic error) =>
                  const NoImageWidget(),
            ),
          ),

          // Title
          Container(
            height: 135,
            width: double.maxFinite,
            color: Colors.black.withOpacity(0.25),
            padding: const EdgeInsets.all(paddingNewsTitle),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  getAssetsIcons,
                  width: 35,
                  height: 35,
                ),
                Text(
                  article.title,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: KfontConstant.styleOfTitleLargePicture,
                )
              ],
            ),
          )
        ],
      ),
      onTap: () => pushToDetail(article: article, context: context),
    );
  }

  String get getAssetsIcons {
    switch (tabIndex) {
      case EnumBoxPicture.IMAGE:
        return 'assets/icons/icon_news_image.png';
        break;

      case EnumBoxPicture.MEGASTORY:
        return 'assets/icons/icon_news_mega.png';
        break;

      default:
        return 'assets/icons/icon_news_info.png';
    }
  }
}
