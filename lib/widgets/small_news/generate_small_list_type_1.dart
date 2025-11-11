import 'package:flutter/material.dart';
import 'package:news/models/article_model.dart';
import 'package:news/widgets/ariticle_detail/push_to_detail.dart';
import 'package:news/widgets/small_news/small_news_type_1.dart';

class GenerateSmallListType1 extends StatelessWidget {
  const GenerateSmallListType1({
    Key key,
    this.type,
    this.articles,
    this.indexSolidDivider = 0,
    this.OnTapItem,
  }) : super(key: key);

  final String type;
  final List<Article> articles;
  final int indexSolidDivider;
  final ValueChanged<Article> OnTapItem;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      itemCount: articles.length,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, int index) {
        return this.articles[index] == null
            ? Offstage()
            : InkWell(
                child: SmallNewsType1(
                  article: this.articles[index],
                  isShowDivider: true,
                ),
                onTap: () => OnTapItem != null
                    ? OnTapItem.call(this.articles[index])
                    : pushToDetail(
                        article: this.articles[index],
                        context: context,
                      ),
              );
      },
    );
  }
}
