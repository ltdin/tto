import 'package:flutter/material.dart';
import 'package:flutter_dash_nullsafety/flutter_dash_nullsafety.dart';
import 'package:news/base/app_helpers.dart';
import 'package:news/constant/color.dart';
import 'package:news/constant/length.dart';
import 'package:news/models/article_model.dart';
import 'package:news/widgets/small_news/small_news_time_title_horizontal.dart';

class GenerateSmallListTimeTitleHorizontal extends StatelessWidget {
  const GenerateSmallListTimeTitleHorizontal({Key key, this.articles})
      : super(key: key);

  final List<Article> articles;

  @override
  Widget build(BuildContext context) {
    printDebug('Build GenerateSmallListTimeTitleHorizontal');

    return Container(
      margin: EdgeInsets.only(top: paddingNews),
      width: double.maxFinite,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: List.generate(
            articles.length,
            (index) => (index == 0)
                ? SmallNewsTimeTitleHorizontal(article: this.articles[index])
                : Row(
                    children: [
                      Dash(
                        direction: Axis.vertical,
                        length: 80,
                        dashLength: 12,
                        dashGap: 6,
                        dashThickness: 0.5,
                      ),
                      SmallNewsTimeTitleHorizontal(
                        article: this.articles[index],
                      ),
                    ],
                  ),
          ),
        ),
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: cardNewsBorderColor),
        borderRadius: BorderRadius.circular(radius8),
      ),
    );
  }
}
