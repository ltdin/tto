import 'package:flutter/material.dart';
import 'package:just_debounce_it/just_debounce_it.dart';
import 'package:news/base/app_helpers.dart';
import 'package:news/blocs/auth_bloc.dart';
import 'package:news/constant/color.dart';
import 'package:news/constant/enum.dart';
import 'package:news/constant/font.dart';
import 'package:news/constant/length.dart';
import 'package:news/constant/number.dart';
import 'package:news/constant/string.dart';
import 'package:news/widgets/button_elevated_custom.dart';

class InputGetPassAgain extends StatefulWidget {
  const InputGetPassAgain({
    Key key,
    this.onTapGetPassButton,
    this.onMoveTo,
    this.focusNode,
    this.loadingButtonWhenClick = false,
  }) : super(key: key);

  final ValueChanged<String> onTapGetPassButton;
  final ValueChanged<UserPage> onMoveTo;
  final FocusScopeNode focusNode;
  final bool loadingButtonWhenClick;

  @override
  State<InputGetPassAgain> createState() => _InputGetPassAgainState();
}

class _InputGetPassAgainState extends State<InputGetPassAgain> {
  final _emailOrPhoneController = TextEditingController();
  bool _loadingWhenClick = false;

  @override
  void didChangeDependencies() {
    _loadingWhenClick = widget.loadingButtonWhenClick;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    printDebug('---->initState  InputGetPassAgain $_loadingWhenClick');

    return Padding(
      padding: const EdgeInsets.all(paddingNews),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          // Text foget pass
          Padding(
            padding: const EdgeInsets.only(top: paddingNews),
            child: Text(
              KString.strGetPassWordAgain,
              style: KfontConstant.styleOfRecommend.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
                color: Color(0xff464E5F),
              ),
            ),
          ),

          // Text please input
          Text(
            '\n Nhập email hoặc số điện thoại bạn đã đăng ký \n để lấy lại mật khẩu',
            style: KfontConstant.defaultStyle,
            textAlign: TextAlign.center,
          ),

          // Input email or phone
          Padding(
            padding: const EdgeInsets.symmetric(vertical: paddingNews),
            child: TextField(
              controller: _emailOrPhoneController,
              keyboardType: TextInputType.text,
              decoration: new InputDecoration(
                hintText: KString.strLoginWithEmailOrPhone,
                errorText: authBloc.errorGetPassAgain,
              ),
              style: KfontConstant.defaultStyle,
              onChanged: (phoneOrEmail) {
                Debounce.milliseconds(
                    DEBOUNCER_DURATION, _checkValue, [phoneOrEmail]);
              },
            ),
          ),

          // Button get pass again
          Padding(
            padding: EdgeInsets.symmetric(vertical: paddingNews * 2),
            child: ButtonElevatedCustom(
              height: 42,
              loadingButtonWhenClick: _loadingWhenClick,
              text: "Lấy lại mật khẩu".toUpperCase(),
              color: CL_BUTTON_LOGIN,
              onTap: _loadingWhenClick
                  ? () => _onTapGetPassAgain(_emailOrPhoneController.text)
                  : null,
            ),
          ),
        ],
      ),
    );
  }

  void _checkValue(String emailOrPhone) {
    setState(() {
      _loadingWhenClick = authBloc.isValidGetPassAgain(emailOrPhone);
    });
  }

  void _onTapGetPassAgain(String emailOrPhone) {
    // Hide key board
    AppHelpers.hideKeyboard(widget.focusNode);

    if (emailOrPhone.isNotEmpty) {
      widget.onTapGetPassButton.call(emailOrPhone);
    }
  }
}
