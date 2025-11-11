import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:news/base/app_helpers.dart';
import 'package:news/base/app_netcore.dart';
import 'package:news/blocs/news_bloc.dart';
import 'package:news/constant/bool.dart';
import 'package:news/constant/color.dart';
import 'package:news/constant/font.dart';
import 'package:news/constant/length.dart';
import 'package:news/constant/string.dart';
import 'package:news/models/video_tvo_model.dart';
import 'package:news/pages/video_tvo_detail/widgets/generate_list_video_news_relation.dart';
import 'package:news/widgets/appbar_for_tab.dart';
import 'package:news/widgets/header_box_widget.dart';
import 'package:news/widgets/icon_button_share.dart';
import 'package:news/widgets/linear_progress_indicator_widget.dart';
import 'package:news/widgets/no_video.dart';
import 'package:news/widgets/play_video_widget.dart';

class PageVideoTvoDetail extends StatefulWidget {
  const PageVideoTvoDetail({Key key, @required this.itemRelatedNews})
      : super(key: key);

  final VideoTvoModel itemRelatedNews;

  @override
  ChildState createState() => ChildState();
}

class ChildState extends State<PageVideoTvoDetail>
    with AfterLayoutMixin<PageVideoTvoDetail> {
  String _urlVideo = '';
  VideoTvoModel _itemRelatedNews;
  bool _flagLoadingVideo = FLAG_OFF;

  @override
  void initState() {
    printDebug('initState VideoTvoDetail');
    _itemRelatedNews = this.widget.itemRelatedNews;

    // Get data from api
    _getInfoVideoTvo(newsId: _itemRelatedNews.videoID)
        .then((VideoTvoModel item) async {
      if (mounted) {
        // Load video
        _loadFromUrlVideoTvo(itemRelatedNews: item);
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    printDebug('build VideoTvoDetail');

    return Scaffold(
      backgroundColor: CL_WHITE,
      appBar: appBarWidget(
        title: KString.VIDEO_PAGE,
        actions: [
          // Icon share link
          IconButtonShare(
            url: _itemRelatedNews?.getUrlVideo,
            subject: _itemRelatedNews.getTitle,
            color: appBarDetailTitleColor,
          )
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Progress indicator && NoVideo
            if (_flagLoadingVideo == FLAG_OFF) ...[
              LinearProgressIndicatorWidget(),
              NoVideo(isLoadingVideo: FLAG_OFF)
            ] else ...[
              // Video
              PlayVideoWidget(
                urlVideo: _urlVideo,
                urlImage: _itemRelatedNews.avatar,
              ),
            ],

            // Infomation video + relations
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(paddingNews),
                children: <Widget>[
                  // Title of video
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: paddingNewsTitle),
                    child: Text(
                      _itemRelatedNews.title,
                      style: KfontConstant.styleOfTitleLargeType1,
                    ),
                  ),

                  // Caption of video
                  Text(
                    _itemRelatedNews.sapo,
                    style: KfontConstant.styleOfSapoLargeType1,
                  ),

                  // Show list Relations when has data
                  if (_itemRelatedNews.videoRelations?.isNotEmpty ?? false) ...[
                    Container(
                      margin: EdgeInsets.symmetric(vertical: paddingNews),
                      padding: EdgeInsets.only(bottom: paddingNewsTitle),
                      child: Column(
                        children: [
                          HeaderBoxWidget(
                            title: KString.strRelationsVideo,
                            paddingTitle: EdgeInsets.only(
                              left: paddingNews,
                              top: paddingNews,
                            ),
                            titleStyle: KfontConstant.styleOfTitleRecommend,
                          ),
                          GenerateListVideoNewsRelation(
                            newsRelations:
                                _itemRelatedNews.videoRelations ?? [],
                            loadRelatedNews: _loadNewVideo,
                          )
                        ],
                      ),
                      decoration: BoxDecoration(
                        color: cardNewsBackgroundColor,
                        border: Border.all(color: cardNewsBorderColor),
                        borderRadius: BorderRadius.circular(radius8),
                      ),
                    )
                  ]
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<VideoTvoModel> _getInfoVideoTvo({String newsId}) async {
    // Get data from api
    return await bloc.getArticleTvoDetail(newsId);
  }

  Future<void> _loadFromUrlVideoTvo({VideoTvoModel itemRelatedNews}) async {
    printDebug('hlsInfo :  ${itemRelatedNews?.hlsInfo}');

    // Get video link
    final _urlMp4 = await bloc.getUrlVideoTvoDetail(itemRelatedNews?.hlsInfo);

    printDebug('Url : $_urlMp4');

    // Load video
    setState(() {
      printDebug('setState VideoTvoDetail');
      _urlVideo = _urlMp4;
      _itemRelatedNews = itemRelatedNews;
      _flagLoadingVideo = FLAG_ON;
    });
  }

  void _loadNewVideo(VideoTvoModel item) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => PageVideoTvoDetail(itemRelatedNews: item),
      ),
    );
  }

  @override
  void afterFirstLayout(BuildContext context) {
    // Add event detail
    AppNetcore().addDetailEvent(news: _itemRelatedNews.toArticle());
  }
}
