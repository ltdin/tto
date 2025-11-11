import 'package:flutter/material.dart';
import 'package:news/constant/color.dart';
import 'package:news/constant/font.dart';
import 'package:news/constant/length.dart';
import 'package:news/widgets/button_elevated_custom.dart';

class GetPassSuccess extends StatelessWidget {
  const GetPassSuccess({
    Key key,
    this.onTapBackButton,
    this.focusNode,
  }) : super(key: key);

  final VoidCallback onTapBackButton;
  final FocusScopeNode focusNode;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(paddingNews),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          // Text foget pass
          Padding(
            padding: const EdgeInsets.only(top: paddingNews),
            child: Text(
              'XÁC THỰC EMAIL',
              style: KfontConstant.styleOfRecommend.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
                color: Color(0xff464E5F),
              ),
            ),
          ),

          // Text
          Text(
            '\n Kiểm tra email của bạn  để xem hướng dẫn cài đặt lại mật khẩu.',
            style: KfontConstant.defaultStyle
                .copyWith(color: Color(0xff9999A4), fontSize: 14.0),
            textAlign: TextAlign.center,
          ),

          // Text remind
          Text(
            '\n Bạn đừng quên kiểm tra hộp thư rác !',
            style: KfontConstant.defaultStyle.copyWith(
                color: Color(0xff464E5F),
                fontSize: 14.0,
                fontWeight: FontWeight.w600,
                fontStyle: FontStyle.italic),
            textAlign: TextAlign.center,
          ),

          // Button back to home
          Padding(
            padding: EdgeInsets.symmetric(vertical: paddingNews * 2),
            child: ButtonElevatedCustom(
              height: 42,
              text: "Về trang chủ".toUpperCase(),
              color: CL_BUTTON_LOGIN,
              onTap: onTapBackButton,
            ),
          ),
        ],
      ),
    );
  }
}
