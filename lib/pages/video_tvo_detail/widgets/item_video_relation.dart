import 'package:flutter/material.dart';
import 'package:news/constant/font.dart';
import 'package:news/constant/length.dart';
import 'package:news/models/article_model.dart';
import 'package:news/models/video_tvo_model.dart';
import 'package:news/widgets/small_news/small_image_widget.dart';

class ItemVideoRelation extends StatelessWidget {
  const ItemVideoRelation({
    Key key,
    @required this.itemVideoRelation,
    this.loadRelatedNews,
  }) : super(key: key);
  final VideoTvoModel itemVideoRelation;
  final Function loadRelatedNews;

  @override
  Widget build(BuildContext context) {
    final _avatar = itemVideoRelation.avatar;
    return Container(
      padding: EdgeInsets.symmetric(vertical: 5),
      height: heightSmallNews150,
      child: InkWell(
        child: Row(
          children: <Widget>[
            // Image video
            Expanded(
              flex: 4,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  SmallImageWidget(
                    article: Article(avatar: _avatar, defaultAvatar: _avatar),
                  ),
                  Positioned(
                    child: Image.asset(
                      'assets/images/buttonplay.png',
                      width: 40.0,
                      height: 40.0,
                    ),
                  )
                ],
              ),
            ),

            // Title video
            Expanded(
              flex: 6,
              child: Padding(
                padding: const EdgeInsets.only(left: 12),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    itemVideoRelation.title,
                    maxLines: 4,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.subtitle1.copyWith(
                          fontFamily: KfontConstant.SFProDisplayMedium,
                          fontSize: 18,
                        ),
                  ),
                ),
              ),
            )
          ],
        ),
        onTap: () => loadRelatedNews(itemVideoRelation),
      ),
    );
  }
}
