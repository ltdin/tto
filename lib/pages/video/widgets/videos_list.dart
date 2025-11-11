import 'package:extended_nested_scroll_view/extended_nested_scroll_view.dart';
import 'package:flutter/material.dart' hide NestedScrollView;
import 'package:news/constant/length.dart';
import 'package:news/models/article_model.dart';
import 'package:news/pages/video/widgets/video_item.dart';

class VideoList extends StatelessWidget {
  const VideoList({Key key, @required this.videoList}) : super(key: key);

  final List<Article> videoList;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: paddingNews),
      child: CustomScrollView(
        slivers: <Widget>[
          SliverOverlapInjector(
            handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, int index) {
                return VideoItem(index: index, article: videoList[index]);
              },
              childCount: videoList.length,
            ),
          ),
        ],
      ),
    );
  }
}
