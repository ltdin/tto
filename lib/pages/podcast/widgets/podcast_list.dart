import 'package:extended_nested_scroll_view/extended_nested_scroll_view.dart';
import 'package:flutter/material.dart' hide NestedScrollView;
import 'package:news/constant/length.dart';
import 'package:news/constant/number.dart';
import 'package:news/models/podcast_model.dart';
import 'package:news/pages/podcast/widgets/podcast_large_item.dart';
import 'package:news/pages/podcast/widgets/podcast_small_item.dart';

class PodcastList extends StatelessWidget {
  const PodcastList({Key key, @required this.podcasts}) : super(key: key);

  final List<PodcastModel> podcasts;

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
              (BuildContext context, int index) {
                return index == FIRST_INDEX
                    ? PodcastLargeItem(index: index, podcasts: podcasts)
                    : PodcastSmallArticle(index: index, podcasts: podcasts);
              },
              childCount: podcasts.length,
            ),
          ),
        ],
      ),
    );
  }
}
