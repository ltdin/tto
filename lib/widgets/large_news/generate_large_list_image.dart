import 'package:flutter/material.dart';
import 'package:news/constant/enum.dart';
import 'package:news/constant/length.dart';
import 'package:news/models/article_model.dart';
import 'package:news/widgets/box/item_large_image_box_image.dart';

class GenerateLargeListImage extends StatelessWidget {
  const GenerateLargeListImage({
    Key key,
    @required this.articles,
    this.tabIndex = EnumBoxPicture.IMAGE,
  }) : super(key: key);

  final List<Article> articles;
  final EnumBoxPicture tabIndex;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: heightLargeNews415,
      width: double.maxFinite,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.zero,
        child: Row(
          children: List.generate(
            articles.length,
            (i) => Container(
              width: widthSmallImage300,
              margin: EdgeInsets.only(
                right: i != articles.length - 1 ? paddingNews : 0.0,
              ),
              child: ItemLargeImageBoxImage(
                article: articles[i],
                tabIndex: tabIndex,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
