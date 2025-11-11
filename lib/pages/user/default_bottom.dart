import 'package:flutter/material.dart';
import 'package:news/constant/font.dart';
import 'package:news/constant/length.dart';
import 'package:news/models/body_row.dart';
import 'package:news/pages/detail/widgets/text_html_widget.dart';
import 'package:news/models/globals.dart' as globals;

class DefaultBottom extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Phone
        TextHtmlWidget(
          row: BodyRow(
            value: globals.isShowFullFunction
                ? '<center><p>Vui lòng email tới hòm thư <a href="mailto:tto@tuoitre.com.vn" title="">tto@tuoitre.com.vn</a> hoặc gọi hotline <a href="tel:" title="">0902429833</a> nếu bạn cần hỗ trợ trong quá trình đăng nhập và nạp sao trên Tuổi Trẻ Sao.</p></center>'
                : '',
          ),
          textStyle:
              KfontConstant.defaultStyle.copyWith(height: 1.5, fontSize: 16.0),
        ),

        // Copy right
        Padding(
          padding: const EdgeInsets.only(
            bottom: paddingNews32,
            top: paddingNews,
          ),
          child: Text(
            '© Copyright 2023 TuoiTre Online',
            style: KfontConstant.defaultStyle
                .copyWith(fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}
