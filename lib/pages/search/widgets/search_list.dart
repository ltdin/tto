import 'package:flutter/material.dart';
import 'package:news/constant/length.dart';
import 'package:news/constant/number.dart';
import 'package:news/models/article_model.dart';
import 'package:news/widgets/small_news/small_news_type_1.dart';

class SearchList extends StatelessWidget {
  const SearchList({
    Key key,
    @required this.count,
    @required List<Article> list,
    @required this.isFinish,
  })  : _list = list,
        super(key: key);

  final int count;
  final List<Article> _list;
  final bool isFinish;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: paddingNews),
      child: ListView.builder(
        padding: EdgeInsets.only(bottom: paddingNews),
        itemCount: count,
        itemBuilder: (context, int index) {
          return SmallNewsType1(
            article: _list[index],
            isShowDivider: index != FIRST_INDEX,
          );
        },
      ),
    );
  }
}
