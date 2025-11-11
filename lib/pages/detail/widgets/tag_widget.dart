import 'package:flutter/material.dart';
import 'package:news/base/app_helpers.dart';
import 'package:news/constant/color.dart';
import 'package:news/constant/length.dart';
import 'package:news/models/tag.dart';

class TagWidget extends StatelessWidget {
  const TagWidget({Key key, this.tags, this.openToTagPage}) : super(key: key);

  final List<Tag> tags;
  final ValueChanged<Tag> openToTagPage;

  @override
  Widget build(BuildContext context) {
    printDebug('Build TagWidget');

    return Container(
      margin: const EdgeInsets.all(paddingNews),
      child: Wrap(
        children: List.generate(
          tags.length,
          (index) => InkWell(
            child: Container(
              padding: EdgeInsets.all(paddingNewsTitle),
              margin: EdgeInsets.only(
                  right: paddingNewsTitle, bottom: paddingNewsTitle),
              child: Text(tags[index].name, textAlign: TextAlign.center),
              decoration: BoxDecoration(
                color: cardNewsBorderColor,
                borderRadius: BorderRadius.circular(4.0),
              ),
            ),
            onTap: () => openToTagPage(tags[index]),
          ),
        ),
      ),
    );
  }
}
