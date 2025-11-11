import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:news/base/app_helpers.dart';
import 'package:news/constant/bool.dart';
import 'package:news/widgets/no_video.dart';
import 'package:video_player/video_player.dart';

class PlayVideoWidget extends StatefulWidget {
  const PlayVideoWidget({Key key, @required this.urlVideo, this.urlImage})
      : super(key: key);
  final String urlVideo;
  final String urlImage;

  @override
  PlayVideoWidgetState createState() => PlayVideoWidgetState();
}

class PlayVideoWidgetState extends State<PlayVideoWidget> {
  VideoPlayerController _videoPlayerController;
  ChewieController _chewieController;
  bool _isLoadingVideo = FLAG_ON;

  @override
  void initState() {
    printDebug('initState PlayVideoWidget');

    // Load video
    _getVideoPlayerController(link: widget.urlVideo ?? '');

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    printDebug('build PlayVideoWidget');

    return (_isLoadingVideo == FLAG_ON)
        ? NoVideo(
            isLoadingVideo: _isLoadingVideo,
            avatarVideo: widget.urlImage,
          )
        : AspectRatio(
            aspectRatio: 3 / 2,
            child: Chewie(controller: _chewieController),
          );
  }

  void _getVideoPlayerController({String link}) {
    printDebug('_getVideoPlayerController');
    _videoPlayerController = VideoPlayerController.network(link)
      ..initialize().then((_) {
        printDebug('Loading video success ');

        // Create chewieController
        _chewieController = _getChewieController(_videoPlayerController);

        setState(() {
          _isLoadingVideo = FLAG_OFF;
        });
        // ignore: sdk_version_since
      }).onError((error, stackTrace) async {
        printDebug('Error : $error');
        _getVideoPlayerController(link: link);
      });
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
    );
  }

  @override
  void dispose() {
    printDebug('Dispose _chewieController');

    _videoPlayerController?.dispose();
    _chewieController.dispose();

    super.dispose();
  }
}
