import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:news/constant/color.dart';
import 'package:news/constant/font.dart';
import 'package:news/constant/length.dart';
import 'package:news/constant/string.dart';
import 'package:news/models/podcast_model.dart';
import 'package:news/widgets/ariticle_detail/push_to_detail.dart';
import 'package:news/widgets/small_news/small_news_type_1.dart';
import 'package:news/models/globals.dart' as globals;


class BoxPodcast extends StatelessWidget {
  const BoxPodcast({Key key, this.boxPodcast}) : super(key: key);

  final PodcastModel boxPodcast;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: paddingNews),
      margin: const EdgeInsets.symmetric(vertical: paddingNews),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Box title
          GestureDetector(
            onTap: () {
              globals.onChangeTab?.call(KString.PODCAST_PAGE);
            },
            child: Container(
              width: double.maxFinite,
              color: voteBackgroundColor,
              padding: const EdgeInsets.only(left: paddingNewsTitle),
              child: Row(
                children: [
                  SvgPicture.asset(
                    'assets/icons/icon_podcast.svg',
                    width: 35,
                    height: 35,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: paddingNews,
                      horizontal: 8.0,
                    ),
                    child: RichText(
                      text: TextSpan(
                        text: 'Tuoitre ',
                        style: KfontConstant.styleOfTitlePodcast,
                        children: const <TextSpan>[
                          TextSpan(
                            text: 'Podcast',
                            style: TextStyle(color: KfontConstant.sapoFontColor),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),


          // Content
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: paddingNews,
              vertical: paddingNews,
            ),
            child: SmallNewsType1(
              article: this.boxPodcast.toArticle,
              isShowDivider: false,
              OnTap: () => _toPodcastDetail(context),
            ),
          ),

          // Button
          Container(
            height: 40,
            padding: const EdgeInsets.symmetric(horizontal: paddingNews),
            width: double.maxFinite,
            child: OutlinedButton(
              style: KfontConstant.styleButtonVote.copyWith(
                backgroundColor:
                    MaterialStateProperty.all<Color>(cardNewsBorderColor),
              ),
              child: Text(
                KString.strListenThisNews,
                style: TextStyle(color: textVoteColor),
              ),
              onPressed: () => _toPodcastDetail(context),
            ),
          )
        ],
      ),
      decoration: BoxDecoration(
        color: cardNewsBackgroundColor,
        border: Border.all(color: cardNewsBorderColor),
        borderRadius: BorderRadius.circular(radius8),
      ),
    );
  }

  void _toPodcastDetail(BuildContext context) {
    pushToPodcastDetail(context: context, podcasts: [boxPodcast], index: 0);
  }
}
