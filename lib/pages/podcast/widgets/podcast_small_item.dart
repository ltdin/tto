import 'package:flutter/material.dart';
import 'package:news/base/app_helpers.dart';
import 'package:news/constant/font.dart';
import 'package:news/constant/length.dart';
import 'package:news/constant/number.dart';
import 'package:news/models/podcast_model.dart';
import 'package:news/pages/podcast/widgets/small_podcast_image.dart';
import 'package:news/widgets/ariticle_detail/push_to_detail.dart';
import 'package:news/widgets/divider_widget.dart';

class PodcastSmallArticle extends StatelessWidget {
  const PodcastSmallArticle(
      {Key key, @required this.index, @required this.podcasts})
      : super(key: key);

  final int index;
  final List<PodcastModel> podcasts;

  @override
  Widget build(BuildContext context) {
    final _podcast = podcasts.elementAt(index);
    final textTheme = Theme.of(context).textTheme;
    printDebug('Build item : ${_podcast.title}');

    return Column(
      children: [
        DividerWidget(isSolid: index == SECOND_INDEX),

        // News
        InkWell(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // Image & button play
              Expanded(
                flex: 4,
                child: Stack(
                  children: <Widget>[
                    // Image
                    SmallPodcastImage(podcast: _podcast),

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
              ),

              // Title podcast
              Expanded(
                flex: 6,
                child: Container(
                  height: heightSmallNews100,
                  padding: EdgeInsets.only(left: paddingNews),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          _podcast.title,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: KfontConstant.styleOfTitleSmallType1,
                        ),
                      ),
                      Text(
                        _podcast.timeCreateNews,
                        style: textTheme.caption,
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
          onTap: () => pushToPodcastDetail(
            context: context,
            podcasts: podcasts,
            index: index,
          ),
        ),
      ],
    );
  }
}
