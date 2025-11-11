import 'package:flutter/material.dart';
import 'package:news/base/app_helpers.dart';
import 'package:news/constant/color.dart';
import 'package:news/constant/length.dart';
import 'package:news/models/classifieds.dart';
import 'package:news/models/zone_model.dart';
import 'package:news/pages/detail/page_detail_webview_custom_tab.dart';
import 'package:news/widgets/box/title_zone_list_sub_category.dart';
import 'package:news/widgets/small_news/generate_small_list_classifieds.dart';

class BoxClassifiedsWidget extends StatelessWidget {
  const BoxClassifiedsWidget({Key key, this.classiFieds}) : super(key: key);

  final List<ClassiFieds> classiFieds;

  @override
  Widget build(BuildContext context) {
    printDebug('Build BoxClassifiedsWidget');

    return Container(
      padding: const EdgeInsets.only(
        left: paddingNews,
        right: paddingNews,
        bottom: paddingNews,
      ),
      margin: const EdgeInsets.only(top: paddingNews * 2, bottom: paddingNews),
      child: Column(
        children: [
          // Title zone + List sub category
          Padding(
            padding: const EdgeInsets.only(top: paddingNews),
            child: TitleZoneListSubCategory(
              zoneName: 'Rao vặt',
              subZones: [
                ZoneList(name: 'Nhà đất', slug: 'nha-dat'),
                ZoneList(name: 'Xe', slug: 'xe'),
                ZoneList(name: 'Học hành', slug: 'hoc-hanh'),
                ZoneList(name: 'Sản phẩm - Dịch vụ', slug: 'san-pham-dich-vu'),
              ],
              onTapItemZone: _onTapItemZone,
            ),
          ),

          // List classiFieds
          GenerateSmallListClassifieds(classiFieds: classiFieds),
        ],
      ),
      decoration: BoxDecoration(
        color: voteBackgroundColor,
        border: Border.all(color: cardNewsBorderColor),
      ),
    );
  }

  void _onTapItemZone(ZoneList zoneList) {
    PageDetailWebviewCustomTab.launch(url: zoneList.getUrlRaoVatForZone);
  }
}
