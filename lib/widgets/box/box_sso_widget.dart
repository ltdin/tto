import 'package:flutter/material.dart';
import 'package:news/base/app_helpers.dart';
import 'package:news/constant/color.dart';
import 'package:news/constant/font.dart';
import 'package:news/constant/length.dart';
import 'package:news/constant/string.dart';
import 'package:news/pages/detail/page_detail_webview_custom_tab.dart';
import 'package:news/widgets/button_elevated_custom.dart';
import 'package:news/widgets/box/carousel_slider_with_indicator.dart';

class BoxSSOWidget extends StatefulWidget {
  const BoxSSOWidget({Key key}) : super(key: key);

  @override
  State<BoxSSOWidget> createState() => _BoxSSOWidgetState();
}

class _BoxSSOWidgetState extends State<BoxSSOWidget> {
  @override
  Widget build(BuildContext context) {
    printDebug('Build BoxSSOWidget');

    return Container(
      padding: const EdgeInsets.only(
        top: paddingNews / 2,
        bottom: paddingNews,
        left: paddingNews,
        right: paddingNews,
      ),
      margin: const EdgeInsets.symmetric(vertical: paddingNews * 2),
      child: Column(
        children: [
          // Logo TTS
          Center(
            child: Image.asset('assets/images/tto_star_small.png', height: 70),
          ),

          // Text
          Text(
            'Trở thành thành viên và trải nghiệm 5 giá trị',
            style: KfontConstant.styleOfBoxTitleSSo,
          ),

          // Slider
          Padding(
            padding: const EdgeInsets.only(top: paddingNews),
            child: CarouselSliderWithIndicator(),
          ),

          // Button
          ButtonElevatedCustom(
            width: double.maxFinite,
            height: 40,
            text: KString.strRegisterTTS,
            color: buttonVoteColor,
            onTap: () => PageDetailWebviewCustomTab.launch(
              url: 'https://stag-mediahub.tuoitre.vn/tuoitresao',
            ),
          ),
        ],
      ),
      decoration: BoxDecoration(
        color: voteBackgroundColor,
        border: Border.all(color: cardNewsBorderColor),
        borderRadius: BorderRadius.circular(radius8),
      ),
    );
  }
}
