import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:just_audio/just_audio.dart';
import 'package:news/base/app_cache.dart';
import 'package:news/base/app_helpers.dart';
import 'package:news/base/app_netcore.dart';
import 'package:news/constant/color.dart';
import 'package:news/constant/font.dart';
import 'package:news/constant/length.dart';
import 'package:news/constant/number.dart';
import 'package:news/constant/string.dart';
import 'package:news/models/article_model.dart';
import 'package:news/models/article_native.dart';
import 'package:news/models/tag.dart';
import 'package:news/pages/detail/bloc/detail_native_bloc.dart';
import 'package:news/pages/detail/page_detail_by_webview.dart';
import 'package:news/pages/detail/page_detail_webview_custom_tab.dart';
import 'package:news/pages/detail/widgets/generate_native_body.dart';
import 'package:news/pages/detail/widgets/generate_list_news_relation.dart';
import 'package:news/pages/detail/widgets/show_range_text_size_native.dart';
import 'package:news/pages/detail/widgets/star_like_heart_widget.dart';
import 'package:news/pages/detail/widgets/tag_widget.dart';
import 'package:news/pages/tag/tag_page.dart';
import 'package:news/widgets/appbar_for_tab.dart';
import 'package:news/widgets/header_box_widget.dart';
import 'package:news/widgets/icon_button_comment.dart';
import 'package:news/widgets/icon_button_read_audio.dart';
import 'package:news/widgets/icon_button_share.dart';
import 'package:news/widgets/linear_progress_indicator_widget.dart';
import 'package:news/widgets/retry_widget.dart';
import 'package:share/share.dart';

class PageTtoDetailNative extends StatefulWidget {
  const PageTtoDetailNative({Key key, this.article}) : super(key: key);

  final Article article;
  @override
  _PageDetailState createState() => _PageDetailState();
}

class _PageDetailState extends State<PageTtoDetailNative> {
  final _player = AudioPlayer();
  int _textZoom = AppCache().textSize;
  int _newsIsWebView = IS_NOT_WEBVIEW_TYPE;
  Article _article;

  @override
  void initState() {
    _article = widget.article;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    printDebug('\n---------- Build detail : ${_article?.newsId} ---------\n');

    return Scaffold(
      backgroundColor: CL_WHITE,
      appBar: appBarWidget(
        title: _article?.zoneName ?? '',
        centerTitle: false,
        actions: [
          // Read audio
          IconButtonReadAudio(
            onTap: (bool value) {
              value
                  ? _onReadAudioNews(linkAudio: _article.audioUrl)
                  : _stopAudio();
            },
          ),

          // Set size text
          IconButton(
            icon: SvgPicture.asset('assets/icons/icon_text_size.svg'),
            onPressed: () {
              _newsIsWebView == IS_NOT_WEBVIEW_TYPE
                  ? _showRangeTextSize(context)
                  : AppHelpers.showToast(
                      text: KString.msgIsWebViewNews,
                      isError: true,
                    );
            },
          ),

          // Icon comment
          IconButtonComment(article: _article),

          // Icon share link
          IconButtonShare(
            onTap: () => Share.share(
              _article.getShareUrl,
              subject: _article.getTitle,
            ),
          )
        ],
      ),
      body: BlocProvider(
        create: (context) => DetailNativeBloc()
          ..add(GetDetailNativeEvent(newsId: _article?.newsId)),
        child: BlocBuilder<DetailNativeBloc, DetailNativeState>(
          builder: (context, DetailNativeState state) {
            // Handle state is DetailSuccess
            if (state is DetailNativeSuccess) {
              // Do every thing after load detail success
              _onLoadSuccess(state.article);

              return SingleChildScrollView(
                padding: EdgeInsets.symmetric(vertical: paddingNews),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Category name + distribution Date
                    Padding(
                      padding: EdgeInsets.only(
                        bottom: paddingNews,
                        left: 16.0,
                        right: 16.0,
                      ),
                      child: Text(
                        //   state.article.distributionDate,
                        _article.getDayMonth,
                        style: textTheme.caption.copyWith(
                          fontSize: 4.0 + _textZoom,
                        ),
                      ),
                    ),

                    // Title of news
                    Padding(
                      padding:
                          const EdgeInsets.symmetric(horizontal: paddingNews),
                      child: Text(
                        state.article.title,
                        style: KfontConstant.styleOfTitleLargeDetail.copyWith(
                          fontSize: _textZoom + 14.0,
                        ),
                      ),
                    ),

                    // Author
                    if (state.article.author.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.only(
                          left: paddingNews,
                          right: paddingNews,
                          top: paddingNews,
                        ),
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: InkWell(
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                    right: paddingNewsTitle,
                                  ),
                                  child: Image.asset(
                                    'assets/images/image_author.png',
                                    width: 30,
                                    height: 30,
                                  ),
                                ),
                                Text(
                                  state.article.author,
                                  style: KfontConstant.styleOfTitleSmallTime
                                      .copyWith(fontSize: _textZoom + 2.0),
                                ),
                              ],
                            ),
                            onTap: () {},
                          ),
                        ),
                      ),

                    // Sapo of news
                    Padding(
                      padding: const EdgeInsets.all(paddingNews),
                      child: Text(
                        state.article.sapo,
                        style: KfontConstant.styleOfSapoDetail.copyWith(
                          fontSize: _textZoom + 6.0,
                        ),
                      ),
                    ),

                    // Body
                    if (state.article.body?.isNotEmpty ?? false) ...[
                      GenerateNativeBody(
                        body: state.article.body,
                        textSize: _textZoom,
                        onTapUrl: _onTapDeepLink,
                      )
                    ],

                    // Gift star
                    StarLikeHeartWidget(article: state.article.toArticle()),

                    // News relation
                    if (state.article.newsRelation?.isNotEmpty ?? false) ...[
                      Container(
                        margin: EdgeInsets.all(paddingNews),
                        padding: EdgeInsets.only(bottom: paddingNews),
                        child: Column(
                          children: [
                            HeaderBoxWidget(
                              title: KString.strRelationsNews,
                              paddingTitle: EdgeInsets.only(
                                left: paddingNews,
                                top: paddingNews,
                              ),
                              titleStyle: KfontConstant.styleOfTitleRecommend,
                            ),
                            GenerateListNewsRelation(
                              newsRelations: state.article.newsRelation ?? [],
                              onClickItemRelationsNews:
                                  _onClickItemRelationsNews,
                            )
                          ],
                        ),
                        decoration: BoxDecoration(
                          color: cardNewsBackgroundColor,
                          border: Border.all(color: cardNewsBorderColor),
                          borderRadius: BorderRadius.circular(radius8),
                        ),
                      ),
                    ],

                    // Tags
                    if (state.article.tags?.isNotEmpty ?? false)
                      TagWidget(
                        tags: state.article.tags,
                        openToTagPage: _openToTagPage,
                      )
                  ],
                ),
              );
            }

            // Handle state is DetailFailure
            if (state is DetailNativeFailure) {
              return RetryWidget(
                onClickRetry: () {
                  BlocProvider.of<DetailNativeBloc>(context)
                    ..add(
                      GetDetailNativeEvent(newsId: widget.article.newsId),
                    );
                },
              );
            }

            // Handle state is DetailNativeOpenByWebview
            if (state is DetailNativeOpenByWebview) {
              _newsIsWebView = IS_WEBVIEW_TYPE;
              return PageDetailByWebView(article: state.article);
            }

            return LinearProgressIndicatorWidget();
          },
        ),
      ),
    );
  }

  Future<bool> _showRangeTextSize(BuildContext context) {
    return showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: const EdgeInsets.symmetric(horizontal: 24),
          content: ShowRangeTextSizeNative(
            textZoom: _textZoom,
            textStyle: Theme.of(context).textTheme.bodyText1,
            setTextZoom: (int value) {
              setState(() {
                _textZoom = value;
              });
            },
          ),
        );
      },
    );
  }

  void _onLoadSuccess(ArticleNative article) {
    _article = article.toArticle();

    // Add event detail
    AppNetcore().addDetailNativeEvent(news: article);
  }

  void _onClickItemRelationsNews(Article article) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => PageTtoDetailNative(article: article),
      ),
    );
  }

  Future<void> _onReadAudioNews({@required String linkAudio}) async {
    try {
      await _player.setUrl(linkAudio);
      _player.play();
    } catch (e) {
      AppHelpers.showToast(
        text: KString.strErrorReadAudioNews,
        isError: false,
      );
      printDebug("Error loading audio : $e");
      _stopAudio();
    }
  }

  void _stopAudio() {
    _player.stop();
  }

  void _disposeAudio() {
    _player.dispose();
  }

  // void _openToAuthorPage(BuildContext context, String authorId) {
  //   Navigator.push(
  //     context,
  //     MaterialPageRoute(builder: (context) => AuthorPage(authorId: authorId)),
  //   );
  // }

  void _openToTagPage(Tag tag) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => TagPage(tag: tag)),
    );
  }

  void _onTapDeepLink(String url) {
    final tag = Tag(url: url);

    if (tag.isUrl) {
      PageDetailWebviewCustomTab.launch(url: tag.url);
    } else {
      final String path = url.split("/").last;
      final String tag = path.substring(0, path.lastIndexOf("."));
      _openToTagPage(Tag(url: tag));
    }
  }

  @override
  void dispose() {
    _disposeAudio();
    super.dispose();
  }
}

// Future<bool> _onWillPop() async {
// Return true if not ads
// if (globals.isNoneAds) {
//   return true;
// }

// final timeBeforeOpenAds = AppCache().adsInterstitialsTime;

// // First open
// if (timeBeforeOpenAds == null) {
//   _onOpenAdsInterstitials();
//   return false;
// }

// // Diff beetween time before open with now()
// final differenceHours = AppCache().getDifferenceInHours;
// if (differenceHours >= 12) {
//   _onOpenAdsInterstitials();
//   return false;
// }

//   return true;
// }

// Future<void> _onOpenAdsInterstitials() async {
//   // Open ads
//   await AdmodInterstitial().openInterstitialAd(
//     context: context,
//     onAdShowed: () {
//       Navigator.pop(context);
//       print('Test onAdShowed');
//     },
//     onAdDismissed: () {
//       print('Test onAdDismissed');
//     },
//     onAdFailedToShow: () {
//       Navigator.pop(context);
//       print('Test onAdFailedToShow');
//     },
//   );

//   AppCache().adsInterstitialsTime = DateTime.now().millisecondsSinceEpoch;
// }
