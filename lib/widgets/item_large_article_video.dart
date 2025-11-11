import 'package:flutter/material.dart';
import 'package:news/models/article_model.dart';
import 'package:news/widgets/large_news/big_image_widget.dart';

class ItemLargeArticleVideo extends StatelessWidget {
  const ItemLargeArticleVideo({Key key, @required this.article})
      : super(key: key);

  final Article article;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        // Image
        BigImageWidget(urlImage: article.getImageNews),

        // Category name
        Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.only(top: 8, left: 15, bottom: 0),
          child: Text(
            '#' + article.zoneName.toUpperCase(),
            style: TextStyle(
              fontSize: 14,
              color: Theme.of(context).primaryColor,
              fontFamily: 'SFDisplayRegular',
            ),
          ),
        ),
        // title news
        Container(
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.only(top: 5, right: 16, bottom: 15, left: 16),
          child: Text(
            article.title,
            textAlign: TextAlign.start,
            style: Theme.of(context).textTheme.headline5.copyWith(
                  fontFamily: 'SFProDisplayBold',
                ),
          ),
        )
      ],
    );
  }
}
