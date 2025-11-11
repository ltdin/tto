import 'package:flutter/material.dart';
import 'package:news/constant/color.dart';
import 'package:news/constant/length.dart';
import 'package:news/models/video_tvo_model.dart';
import 'package:news/widgets/small_news/small_news_type_1.dart';

class GenerateListVideoNewsRelation extends StatelessWidget {
  const GenerateListVideoNewsRelation({
    Key key,
    @required this.newsRelations,
    this.loadRelatedNews,
  }) : super(key: key);

  final List<VideoTvoModel> newsRelations;
  final ValueChanged<VideoTvoModel> loadRelatedNews;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: paddingNews),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: newsRelations.length,
      itemBuilder: (BuildContext ctxt, int index) {
        return SmallNewsType1(
          article: newsRelations.elementAt(index).toArticle(),
          isSolidDivider: true,
          colorDivider: dividerColor,
          OnTap: () => loadRelatedNews.call(newsRelations.elementAt(index)),
        );
      },
    );
  }
}
