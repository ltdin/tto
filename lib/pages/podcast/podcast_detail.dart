import 'package:cached_network_image/cached_network_image.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:news/base/app_helpers.dart';
import 'package:news/base/app_netcore.dart';
import 'package:news/constant/color.dart';
import 'package:news/constant/font.dart';
import 'package:news/constant/string.dart';
import 'package:news/models/podcast_model.dart';
import 'package:news/util/debouncer.dart';
import 'package:news/widgets/appbar_for_tab.dart';
import 'package:news/widgets/icon_button_share.dart';
import 'package:news/widgets/no_image_widget.dart';
import 'package:news/widgets/no_video.dart';
import 'package:video_player/video_player.dart';

class PodcastDetail extends StatefulWidget {
  const PodcastDetail({
    Key key,
    @required this.podcasts,
    this.index,
  }) : super(key: key);

  final List<PodcastModel> podcasts;
  final int index;

  @override
  ChildState createState() => ChildState();
}

class ChildState extends State<PodcastDetail> {
  PodcastModel _podcast;
  int _index = 0;
  VideoPlayerController _videoPlayerController;
  ChewieController _chewieController;
  final _debouncer = Debouncer(milliseconds: 1000);

  @override
  void initState() {
    _index = this.widget.index;
    _podcast = this.widget.podcasts.elementAt(_index);

    // Get data from api
    _videoPlayerController = VideoPlayerController.network(_podcast.filemp3)
      ..addListener(_videoListener);

    // Create chewieController
    _chewieController = _getChewieController(_videoPlayerController);

    // Add event detail
    AppNetcore().addDetailEvent(news: _podcast.toArticle);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    printDebug('build PodcastDetail');
    final _themeData = Theme.of(context);

    return Scaffold(
      appBar: appBarWidget(
        title: KString.PODCAST_PAGE,
        actions: [
          // Icon share link
          IconButtonShare(
            url: _podcast?.getUrl,
            subject: _podcast?.getTitle,
            color: appBarDetailTitleColor,
          )
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Video
            (_chewieController != null)
                ? AspectRatio(
                    aspectRatio: 3 / 2,
                    child: Chewie(controller: _chewieController),
                  )
                : NoVideo(
                    avatarVideo: _podcast.getAvata,
                  ),

            // Infomation podcast
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(10),
                children: <Widget>[
                  // Title
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Text(
                      _podcast.title,
                      style: _themeData.textTheme.headline5.copyWith(
                        fontFamily: KfontConstant.SFProDisplayBold,
                      ),
                    ),
                  ),

                  // Time
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 12),
                    child: Text(
                      _podcast.timeCreateNews,
                      style: _themeData.textTheme.caption,
                    ),
                  ),

                  // Caption of video
                  if (_podcast?.sapo?.isNotEmpty ?? false)
                    Text(
                      _podcast.sapo,
                      style: _themeData.textTheme.subtitle1.copyWith(
                        fontFamily: KfontConstant.SFDisplayRegular,
                        fontSize: 16,
                      ),
                    ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  ChewieController _getChewieController(
    VideoPlayerController videoPlayerController,
  ) {
    return ChewieController(
      videoPlayerController: videoPlayerController,
      aspectRatio: 3 / 2,
      autoPlay: true,
      looping: false,
      allowedScreenSleep: false,
      overlay: CachedNetworkImage(
        imageUrl: _podcast.getAvata,
        imageBuilder: (context, imageProvider) => Container(
          decoration: BoxDecoration(
            image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
          ),
        ),
        placeholder: (context, url) => const NoImageWidget(),
        errorWidget: (context, url, dynamic error) => const NoImageWidget(),
      ),
    );
  }

  void _videoListener() {
    final _positionInSeconds = _videoPlayerController.value.position.inSeconds;
    final _durationInSeconds = _videoPlayerController.value.duration.inSeconds;
    final bool canNextPodcast =
        _durationInSeconds == (_positionInSeconds + 1) ||
            _durationInSeconds == _positionInSeconds;

    // Check end video
    if (canNextPodcast && (_chewieController?.isPlaying ?? false)) {
      _debouncer.run(() => _openNextVideo());
    }
  }

  void _openNextVideo() {
    if (this.widget.index == this.widget.podcasts.length - 1) {
      return;
    }

    // Turn on loading
    AppHelpers.onLoading(context, true);

    Future.delayed(Duration(seconds: 2), () {
      AppHelpers.closeContext(context);

      // Move to next
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          settings: RouteSettings(name: "/podcast_detail", arguments: null),
          builder: (context) => PodcastDetail(
            podcasts: this.widget.podcasts,
            index: nextIndex,
          ),
        ),
      );
    });
  }

  int get nextIndex => this.widget.index + 1;

  @override
  void dispose() {
    _videoPlayerController?.dispose();
    _chewieController?.dispose();
    _debouncer?.dispose();
    super.dispose();
  }
}
