import 'package:flutter/material.dart';
import 'package:news/base/app_helpers.dart';
import 'package:news/constant/bool.dart';
import 'package:news/constant/font.dart';
import 'package:news/constant/length.dart';
import 'package:news/models/podcast_model.dart';
import 'package:news/widgets/ariticle_detail/push_to_detail.dart';
import 'package:news/widgets/large_news/big_image_widget.dart';

class PodcastLargeItem extends StatelessWidget {
  const PodcastLargeItem(
      {Key key, @required this.index, @required this.podcasts})
      : super(key: key);

  final int index;
  final List<PodcastModel> podcasts;

  @override
  Widget build(BuildContext context) {
    final _podcast = podcasts.elementAt(index);
    printDebug('Build item ${_podcast.title}');

    return InkWell(
      child: Column(
        children: <Widget>[
          // Title
          Container(
            padding: EdgeInsets.symmetric(vertical: paddingNews),
            alignment: Alignment.topLeft,
            child: Text(
              _podcast.title,
              maxLines: 4,
              overflow: TextOverflow.ellipsis,
              style: KfontConstant.styleOfTitleLargeType1,
            ),
          ),

          // Image & button play
          Stack(
            children: <Widget>[
              // Image
              BigImageWidget(
                urlImage: _podcast.toArticle.getImageNews,
                isDetail: FLAG_ON,
                fit: BoxFit.cover,
              ),

              // Play icon
              Positioned(
                left: 10.0,
                bottom: 10.0,
                child: Image.asset(
                  'assets/images/buttonplay.png',
                  width: 24.0,
                  height: 24.0,
                ),
              )
            ],
          ),
        ],
      ),
      onTap: () => pushToPodcastDetail(
        context: context,
        podcasts: podcasts,
        index: index,
      ),
    );
  }
}
