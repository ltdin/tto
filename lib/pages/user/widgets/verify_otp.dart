import 'package:flutter/material.dart';
import 'package:news/constant/color.dart';
import 'package:news/constant/enum.dart';
import 'package:news/constant/font.dart';
import 'package:news/constant/length.dart';
import 'package:news/constant/number.dart';
import 'package:news/base/app_helpers.dart';
import 'package:news/widgets/app_loading.dart';
import 'package:news/widgets/button_elevated_custom.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class VerifyOtp extends StatefulWidget {
  const VerifyOtp({
    Key key,
    this.onOtpCallBack,
    this.numberPhone,
    this.onMoveTo,
  }) : super(key: key);

  final ValueChanged<String> onOtpCallBack;
  final ValueChanged<UserPage> onMoveTo;
  final String numberPhone;

  @override
  State<VerifyOtp> createState() => _VerifyOtpState();
}

class _VerifyOtpState extends State<VerifyOtp> {
  bool _isLoading = false;
  String _cacheValue = '';

  @override
  Widget build(BuildContext context) {
    printDebug('==================== Build VerifyOtp ====================');

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(paddingNews),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // Text login or create account
              Padding(
                padding: const EdgeInsets.only(top: paddingNews),
                child: Text(
                  'Nhập mã xác minh',
                  style: KfontConstant.styleOfRecommend.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),

              // Sapo
              Wrap(
                alignment: WrapAlignment.center,
                spacing: 4.0,
                runSpacing: 4.0,
                children: [
                  Text(
                    "Nhập mã xác minh gồm 6 số vừa được gửi đến",
                    style: KfontConstant.defaultStyle,
                  ),
                  Text(
                    widget.numberPhone,
                    style: KfontConstant.defaultStyle.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),

              // Pin Code
              Padding(
                padding: const EdgeInsets.symmetric(vertical: paddingNews),
                child: PinCodeTextField(
                  appContext: context,
                  length: 6,
                  obscureText: false,
                  autoUnfocus: false,
                  keyboardType: TextInputType.number,
                  animationType: AnimationType.scale,
                  cursorColor: Colors.black,
                  textStyle: TextStyle(
                    fontSize: 28.0,
                    fontWeight: FontWeight.normal,
                  ),
                  pinTheme: PinTheme(
                    shape: PinCodeFieldShape.underline,
                    fieldHeight: 60,
                    activeColor: detailDistributionDateColor,
                    inactiveFillColor: Colors.transparent,
                    inactiveColor: detailDistributionDateColor,
                    activeFillColor: CL_WHITE,
                    selectedColor: detailDistributionDateColor,
                    selectedFillColor: CL_WHITE,
                  ),
                  onCompleted: (String number) {
                    _cacheValue = number;
                    callBackValue(number);
                  },
                  onChanged: (value) {},
                ),
              ),

              // Button verify
              if (_isLoading)
                SizedBox(
                  height: kTabHeight,
                  child: AppLoadingIndicator(),
                )
              else
                ButtonElevatedCustom(
                  width: 160,
                  height: kTabHeight,
                  text: "Xác minh".toUpperCase(),
                  color: CL_BUTTON_LOGIN,
                  onTap: () => callBackValue(_cacheValue),
                ),
            ],
          ),
        ),
      ],
    );
  }

  void callBackValue(String number) {
    if (widget.onOtpCallBack != null && number.length > 5) {
      _isLoading = !_isLoading;

      // Call back
      widget.onOtpCallBack.call(number);
    }
  }
}
