import 'package:flutter/material.dart';
import 'package:news/base/app_helpers.dart';
import 'package:news/models/article_model.dart';
import 'package:news/constant/font.dart';
import 'package:news/widgets/ariticle_detail/push_to_detail.dart';
import 'package:news/widgets/small_news/small_image_widget.dart';

class ArticleGridWidget extends StatelessWidget {
  ArticleGridWidget({Key key, this.articles}) : super(key: key);

  final List<Article> articles;

  @override
  Widget build(BuildContext context) {
    printDebug('Test build 4 item video');
    return GridView.builder(
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        controller: new ScrollController(keepScrollOffset: false),
        itemCount: 4,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          childAspectRatio: 1.1,
        ),
        itemBuilder: (BuildContext context, int index) {
          final isEven = index.isEven;
          return InkWell(
            child: Container(
              padding: EdgeInsets.only(
                left: isEven ? 16 : 0,
                right: isEven ? 0 : 16,
                bottom: 10,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  // image news
                  SmallImageWidget(article: this.articles[index]),

                  // title news
                  Padding(
                    padding: const EdgeInsets.only(top: 5.0),
                    child: Text(
                      this.articles[index].title,
                      style: Theme.of(context).textTheme.subtitle1.copyWith(
                            fontFamily: KfontConstant.SFProDisplayMedium,
                            fontSize: 18,
                          ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
            onTap: () =>
                pushToDetail(article: this.articles[index], context: context),
          );
        });
  }
}
