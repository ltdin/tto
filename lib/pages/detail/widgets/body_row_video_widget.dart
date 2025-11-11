import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:news/base/app_helpers.dart';
import 'package:news/constant/color.dart';
import 'package:news/constant/length.dart';
import 'package:news/models/body_row.dart';
import 'package:news/widgets/no_video.dart';
import 'package:video_player/video_player.dart';

class BodyRowVideoWidget extends StatefulWidget {
  const BodyRowVideoWidget({
    Key key,
    @required this.textSize,
    @required this.row,
  }) : super(key: key);

  final int textSize;
  final BodyRow row;

  @override
  State<BodyRowVideoWidget> createState() => _BodyRowVideoWidgetState();
}

class _BodyRowVideoWidgetState extends State<BodyRowVideoWidget> {
  VideoPlayerController _videoPlayerController;
  ChewieController _chewieController;
  bool _flagPlay = false;

  @override
  Widget build(BuildContext context) {
    printDebug('Build : BodyRowVideoWidget ');

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: paddingNewsTitle),
      child: Column(
        children: [
          // Video
          (_flagPlay == true && _chewieController != null)
              ? AspectRatio(
                  aspectRatio: 3 / 2,
                  child: Chewie(controller: _chewieController),
                )
              : NoVideo(
                  avatarVideo: widget.row?.avatarVideo ?? '',
                  onClickPlayVideo: () =>
                      _onClickPlayVideo(widget.row?.filename),
                ),

          // Caption video
          if (widget.row?.caption?.isNotEmpty ?? false)
            Container(
              width: double.infinity,
              color: CL_DETAIL_BACKGROUND_PHOTO,
              padding: EdgeInsets.symmetric(
                vertical: paddingNewsTitle,
                horizontal: paddingNews,
              ),
              child: Text(
                widget.row?.caption ?? '',
                style: TextStyle(fontSize: 3.0 + widget.textSize, height: 1.4),
                textAlign: TextAlign.center,
              ),
            )
        ],
      ),
    );
  }

  void _onClickPlayVideo(String linkVideo) {
    setState(() {
      // Set value flag play
      _flagPlay = true;

      // Create video player controller
      _videoPlayerController = VideoPlayerController.network(linkVideo);

      // Create chewie controller
      _chewieController = _getChewieController(_videoPlayerController);
    });
  }

  ChewieController _getChewieController(
      VideoPlayerController videoPlayerController) {
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
    printDebug('Dispose : BodyRowVideoWidget ');
    _videoPlayerController?.pause();
    _videoPlayerController?.dispose();

    _chewieController?.pause();
    _chewieController?.dispose();
    super.dispose();
  }
}
