import 'package:flutter/material.dart';
import 'package:news/constant/length.dart';
import 'package:news/constant/string.dart';
import 'package:news/pages/detail/page_detail_webview_custom_tab.dart';
import 'package:news/pages/user/widgets/text_underline.dart';

class RegisterTtsInfoAccount extends StatelessWidget {
  const RegisterTtsInfoAccount({Key key, this.callBackClose}) : super(key: key);

  final VoidCallback callBackClose;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: paddingNews),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.asset('assets/images/tto_star_small.png', height: 70),
          Padding(
            padding: const EdgeInsets.only(right: paddingNews),
            child: TextUnderline(
              text: KString.strRegisterTTS,
              onTap: () => PageDetailWebviewCustomTab.launch(
                url: 'https://stag-mediahub.tuoitre.vn/tuoitresao',
              ),
            ),
          )
        ],
      ),
    );
  }
}
