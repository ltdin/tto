import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:news/util/screen_util.dart';

class AdWidget extends StatefulWidget {
  const AdWidget({Key key, this.zone, this.channel}) : super(key: key);

  final String channel;
  final String zone;

  static String _zoneR1Id = 'jwsn1c2f';
  static String _zoneR2Id = 'jwsn2xfm';
  static String get zoneR1Id => _zoneR1Id;
  static String get zoneR2Id => _zoneR2Id;

  @override
  _AdWidgetState createState() => _AdWidgetState();
}

class _AdWidgetState extends State<AdWidget> {
  // double _adWidth = 300;
  // double _adHeight = 250;
  String channel;
  String zone;

  // final String _siteId = 'jmadjflq';
  bool isHideLoader;
  bool isHideAd;
  double screenWidth = ScreenUtil.screenWidth;

  @override
  void initState() {
    channel = widget.channel;
    zone = widget.zone;
    isHideAd = false;
    isHideLoader = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Offstage();
    // if (globals.isLoggedIn) {
    //   return new Container();
    // }

    // double sW = screenWidth - 10;
    // double sH = _adHeight;

    // if (screenWidth < _adWidth) {
    //   sW = _adWidth;
    //   sH = screenWidth * _adHeight / _adWidth;
    // }

    // channel = '/home/';

    // if (this.widget.zone == null || this.widget.zone.isEmpty) {
    //   zone = AdWidget._zoneR1Id;
    // }

    // String initialUrl =
    //     'https://quangcao.tuoitre.vn/zone/app/?site=$_siteId&zone=' +
    //         this.widget.zone +
    //         '&channel=' +
    //         this.widget.channel;

    // return !isHideAd
    //     ? Container(
    //         height: sH,
    //         width: sW,
    //         child: Stack(children: [
    //           WebView(
    //             initialUrl: initialUrl,
    //             javascriptMode: JavascriptMode.unrestricted,
    //             navigationDelegate: (navigationRequest) {
    //               if (navigationRequest.url != null &&
    //                   navigationRequest.url != 'about:blank' &&
    //                   navigationRequest.url.indexOf('logging.admicro.vn') > 0) {
    //                 _onOpenLink(navigationRequest.url);

    //                 return NavigationDecision.prevent;
    //               }
    //               return NavigationDecision.navigate;
    //             },
    //             onPageFinished: (String url) {
    //               printDebug('onLoadStop');
    //               if (mounted)
    //                 Future.delayed(
    //                   Duration(seconds: 3),
    //                   () {
    //                     if (this.mounted) {
    //                       setState(() {
    //                         isHideLoader = true;
    //                       });
    //                     }
    //                   },
    //                 );
    //             },
    //             onWebResourceError: (_) {
    //               printDebug('onLoadError');
    //               setState(() {
    //                 isHideAd = true;
    //               });
    //             },
    //           ),
    //           if (!isHideLoader) AppLoadingIndicator()
    //         ]),
    //       )
    //     : Offstage();
  }

  Future<void> onOpenLink(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
