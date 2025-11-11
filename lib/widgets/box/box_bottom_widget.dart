import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:news/base/app_helpers.dart';
import 'package:news/constant/color.dart';
import 'package:news/constant/length.dart';
import 'package:news/models/classifieds.dart';
import 'package:news/models/globals.dart' as globals;
import 'package:news/widgets/logo_sso_widget.dart';
import 'package:news/widgets/logo_tto_widget.dart';
import 'package:news/widgets/logo_youth_group_widget.dart';

class BoxBottomInfoWidget extends StatelessWidget {
  const BoxBottomInfoWidget({
    Key key,
    this.classiFieds,
    this.backgroundColor = cardNewsBackgroundColor,
    this.fullInfo = true,
    this.isShowYouthGroupLogo = false,
    this.padding,
  }) : super(key: key);

  final List<ClassiFieds> classiFieds;
  final Color backgroundColor;
  final bool fullInfo;
  final bool isShowYouthGroupLogo;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    printDebug('Build BoxBottomWidget');
    final _sizedBox = SizedBox(height: 4);
    final _sizedBox8 = SizedBox(height: 8);
    const _divider = Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: Divider(height: 0),
    );

    return Container(
      padding: padding ?? const EdgeInsets.all(paddingNews),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _divider,

          // Box logo
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Logo tto
              getLogo,

              // Image social
              if (Platform.isAndroid)
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: SvgPicture.asset(
                          'assets/icons/icon_youtube.svg',
                          height: 24,
                        ),
                      ),
                      onTap: () => AppHelpers.onOpenLink(
                        url:
                            'https://www.youtube.com/channel/UC47WI-kZXFf0H_f7pvaNCEQ',
                      ),
                    ),
                    InkWell(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: SvgPicture.asset(
                          'assets/icons/icon_ins.svg',
                          height: 24,
                        ),
                      ),
                      onTap: () => AppHelpers.onOpenLink(
                        url: 'https://www.instagram.com/baotuoitre',
                      ),
                    ),
                    InkWell(
                      child: SvgPicture.asset(
                        'assets/icons/icon_facebook.svg',
                        height: 24,
                      ),
                      onTap: () => AppHelpers.onOpenLink(
                        url: 'https://www.facebook.com/baotuoitre',
                      ),
                    ),
                  ],
                )
            ],
          ),
          _divider,

          // Content
          SizedBox(height: 20),
          Text('Tổng biên tập: Lê Thế Chữ'),
          SizedBox(height: 6),
          Text(
            'Giấy phép hoạt động báo điện tử tiếng Việt, tiếng Anh số 561/GP-BTTTT,cấp ngày 25-11-2022.',
          ),
          _sizedBox,

          if (fullInfo) ...[
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  InkWell(
                    child: Text(
                      'Thông tin tòa soạn',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    onTap: () => AppHelpers.onOpenLink(
                      url: 'https://tuoitre.vn/thong-tin-toa-soan.htm',
                    ),
                  ),
                  InkWell(
                    child: Text(
                      ' - Thành Đoàn TP.HCM ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    onTap: () => AppHelpers.onOpenLink(
                      url:
                          'http://www.thanhdoan.hochiminhcity.gov.vn/thanhdoan/webtd',
                    ),
                  )
                ],
              ),
            ),
            _sizedBox,
            _sizedBox8,

            // Info office
            Text(
                'Địa chỉ: 60A Hoàng Văn Thụ, Phường Đức Nhuận, Tp.Hồ Chí Minh'),
            Text('Hotline: 0918.033.133  - Email:tto@tuoitre.com.vn'),
            Text('Phòng Quảng Cáo Báo Tuổi Trẻ: 028.39974848'),
            _sizedBox,

            // Connect ads
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  InkWell(
                    child: Text(
                      'Liên hệ quảng cáo',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    onTap: () => AppHelpers.onOpenLink(
                      url: 'https://quangcao.tuoitre.vn/',
                    ),
                  ),
                  Text(' | '),
                  Text(
                    'Điều khoản bảo mật',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(' | '),
                  InkWell(
                    child: Text(
                      'Góp ý',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    onTap: () => AppHelpers.onOpenLink(
                      url:
                          'https://docs.google.com/forms/d/e/1FAIpQLScSRj-Bxm1t6roko_ocQlUSZCnei3a03IdoOpPQ9-lp2McaKw/viewform',
                    ),
                  ),
                ],
              ),
            ),
          ],
          _sizedBox,
          _sizedBox8,

          Text(
            '© Copyright 2023 TuoiTre Online,All rights reserved',
            style: TextStyle(color: Colors.grey),
          ),
          Text(
            '® Tuổi Trẻ Online giữ bản quyền nội dung trên website này',
            style: TextStyle(color: Colors.grey),
          ),
        ],
      ),
      decoration: BoxDecoration(
        color: backgroundColor,
        border: Border.all(color: backgroundColor),
      ),
    );
  }

  // Get
  Widget get getLogo {
    return isShowYouthGroupLogo
        ? LogoYouthGroupWidget()
        : globals.isTTStar
            ? LogoSSOWidget()
            : LogoTTOWidget(height: 32);
  }
}
