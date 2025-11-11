import 'package:flutter/material.dart';

import '../../pages/detail/page_detail_webview_custom_tab.dart';
import '../divider_widget.dart';

class BoxboxBannerBCM extends StatelessWidget {
  const BoxboxBannerBCM({
    Key key,
    this.isShowDivider = false,
    this.isSolid = false,
    this.color,
  }) : super(key: key);

  final bool isShowDivider;
  final bool isSolid;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Divider
        if (isShowDivider) DividerWidget(isSolid: isSolid, color: color),
        InkWell(
            onTap: () {
              PageDetailWebviewCustomTab.launch(
                  url: 'https://tuoitre.vn/bau-cu-tong-thong-my-e587.htm');
            },
            child: Image.asset('assets/images/banner_bau_cu_my.png')),
        // Divider
        if (isShowDivider) DividerWidget(isSolid: isSolid, color: color),
      ],
    );
  }
}
