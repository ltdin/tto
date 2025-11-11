import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:news/base/app_helpers.dart';
import 'package:news/constant/length.dart';
import 'package:news/widgets/advertising/ad_helper.dart';

class AdmodBanner extends StatefulWidget {
  const AdmodBanner({
    Key key,
    this.tabKey,
    this.padding = const EdgeInsets.symmetric(vertical: paddingNews),
  }) : super(key: key);

  final EdgeInsets padding;
  final String tabKey;

  @override
  _AdmodBannerState createState() => _AdmodBannerState();
}

class _AdmodBannerState extends State<AdmodBanner>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);

    printDebug(' Test build ${widget.tabKey} ');

    return AdManager.adIsNotExist
        ? Offstage()
        : Container(
            margin: widget.padding,
            width: double.infinity,
            height: AdManager.ad.size.height.toDouble(),
            child: RepaintBoundary(child: AdWidget(ad: AdManager.ad)),
          );
  }

  @override
  bool get wantKeepAlive => true;
}
