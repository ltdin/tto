import 'package:flutter/material.dart';
import 'package:news/models/classifieds.dart';
import 'package:news/pages/detail/page_detail_webview_custom_tab.dart';
import 'package:news/widgets/small_news/small_news_classifieds.dart';

class GenerateSmallListClassifieds extends StatelessWidget {
  const GenerateSmallListClassifieds({
    Key key,
    this.type,
    this.classiFieds,
    this.indexSolidDivider = 0,
  }) : super(key: key);

  final String type;
  final List<ClassiFieds> classiFieds;
  final int indexSolidDivider;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      itemCount: classiFieds.length,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, int index) {
        return InkWell(
          child: SmallNewsClassiFieds(
            classiFieds: this.classiFieds[index],
            isSolidDivider: index == indexSolidDivider,
            isShowDivider: true,
          ),
          onTap: () => PageDetailWebviewCustomTab.launch(
            url: this.classiFieds[index].getUrl,
          ),
        );
      },
    );
  }
}
