import 'package:flutter/material.dart';
import 'package:just_debounce_it/just_debounce_it.dart';
import 'package:news/base/app_helpers.dart';
import 'package:news/blocs/auth_bloc.dart';
import 'package:news/constant/color.dart';
import 'package:news/constant/font.dart';
import 'package:news/constant/length.dart';
import 'package:news/constant/number.dart';
import 'package:news/constant/string.dart';
import 'package:news/models/user_model.dart';
import 'package:news/pages/user/widgets/text_underline.dart';
import 'package:news/widgets/button_elevated_custom.dart';

class InputRegisterInfomation extends StatefulWidget {
  const InputRegisterInfomation({
    Key key,
    this.onTapRegisterButton,
    this.focusNode,
  }) : super(key: key);

  final ValueChanged<UserModel> onTapRegisterButton;
  final FocusScopeNode focusNode;

  @override
  State<InputRegisterInfomation> createState() =>
      _InputRegisterInfomationState();
}

class _InputRegisterInfomationState extends State<InputRegisterInfomation> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  bool _loadingWhenClick = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: paddingNews),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          // Text create account
          Padding(
            padding: const EdgeInsets.symmetric(vertical: paddingNews),
            child: Text(
              "Đăng ký tài khoản báo Tuổi Trẻ để sử dụng đầy đủ tính năng của thành viên,"
              " nhận tin tức mới nhất trên các lĩnh vực và có cơ hội tham gia sớm các sự kiện báo Tuổi Trẻ tổ chức ",
              style: KfontConstant.styleOfContentRrgister,
            ),
          ),

          // Input email
          TextField(
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              hintText: KString.strLoginWithEmailOrPhone,
              errorText: authBloc.errorEmailRegister,
            ),
            style: KfontConstant.defaultStyle,
          ),

          // Input pass
          TextField(
            controller: _passController,
            obscureText: true,
            keyboardType: TextInputType.visiblePassword,
            decoration: new InputDecoration(
              hintText: KString.strInputPassWord,
              errorText: authBloc.errorPassRegister,
            ),
            style: KfontConstant.defaultStyle,
            onChanged: (pass) {
              Debounce.milliseconds(
                DEBOUNCER_DURATION,
                _checkValue,
                [_emailController.text, pass],
              );
            },
          ),

          // Button register
          Padding(
            padding: EdgeInsets.symmetric(vertical: paddingNews32),
            child: ButtonElevatedCustom(
              height: 42,
              loadingButtonWhenClick: _loadingWhenClick,
              text: KString.strRegister.toUpperCase(),
              color: CL_BUTTON_LOGIN,
              onTap: _loadingWhenClick
                  ? () => _onTapRegister(
                        _emailController.text,
                        _passController.text,
                      )
                  : null,
            ),
          ),

          // Accept police
          Padding(
            padding: const EdgeInsets.only(top: 0),
            child: TextUnderline(
              text:
                  'Khi nhấn đăng ký bạn đã đồng ý với quy định của báo Tuổi Trẻ',
              color: textVoteColor,
              onTap: () {},
            ),
          ),
        ],
      ),
    );
  }

  void _checkValue(String email, String pass) {
    setState(() {
      _loadingWhenClick = authBloc.isValidRegister(email, pass);
    });
  }

  void _onTapRegister(String email, String pass) {
    if (email.isNotEmpty && pass.isNotEmpty) {
      if (widget.onTapRegisterButton != null) {
        // Hide key board
        AppHelpers.hideKeyboard(widget.focusNode);

        widget.onTapRegisterButton.call(
          UserModel(
            email: _emailController.text,
            pass: _passController.text,
          ),
        );
      }
    }
  }
}
