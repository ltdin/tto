import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:news/base/app_helpers.dart';
import 'package:news/blocs/auth_bloc.dart';
import 'package:news/constant/color.dart';
import 'package:news/constant/enum.dart';
import 'package:news/constant/font.dart';
import 'package:news/constant/length.dart';
import 'package:news/constant/string.dart';
import 'package:news/models/user_model.dart';
import 'package:news/pages/user/widgets/text_underline.dart';
import 'package:news/widgets/button_elevated_custom.dart';
import 'package:news/widgets/no_video.dart';

class InputLogin extends StatefulWidget {
  const InputLogin({
    Key key,
    this.onTapLoginButton,
    this.onMoveTo,
    this.userModelAutoFill,
    this.focusNode,
  }) : super(key: key);

  final ValueChanged<UserModel> onTapLoginButton;
  final ValueChanged<UserPage> onMoveTo;
  final UserModel userModelAutoFill;
  final FocusScopeNode focusNode;

  @override
  State<InputLogin> createState() => _InputLoginState();
}

class _InputLoginState extends State<InputLogin> {
  TextEditingController _emailController;
  TextEditingController _passController;

  @override
  void initState() {
    _emailController =
        TextEditingController(text: widget?.userModelAutoFill?.getEmail ?? '');
    _passController =
        TextEditingController(text: widget?.userModelAutoFill?.getPass ?? '');

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: paddingNews),
      child: AutofillGroup(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Input user
            TextField(
              controller: _emailController,
              enableSuggestions: true,
              autofillHints: [AutofillHints.username],
              keyboardType: TextInputType.emailAddress,
              decoration: new InputDecoration(
                hintText: KString.strLoginWithEmailOrPhone,
                errorText: authBloc.errorEmailLogin,
              ),
              style: KfontConstant.defaultStyle,
            ),

            // Input pass
            TextField(
              controller: _passController,
              enableSuggestions: true,
              autofillHints: [AutofillHints.password],
              obscureText: true,
              keyboardType: TextInputType.visiblePassword,
              decoration: new InputDecoration(
                hintText: KString.strInputPassWord,
                errorText: authBloc.errorPassRegister,
              ),
              style: KfontConstant.defaultStyle,
              onEditingComplete: () =>
                  TextInput.finishAutofillContext(shouldSave: true),
              onSubmitted: (_) => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const Scaffold(body: NoVideo())),
              ),
            ),

            // Get pass again
            Padding(
              padding: const EdgeInsets.only(top: paddingNews),
              child: TextUnderline(
                text: KString.strGetPassWord,
                onTap: () {
                  if (widget.onMoveTo != null) {
                    widget.onMoveTo.call(UserPage.INPUT_GET_PASS_AGAIN);
                  }
                },
              ),
            ),

            // Button login
            Padding(
              padding: EdgeInsets.symmetric(vertical: paddingNews * 2),
              child: ButtonElevatedCustom(
                height: 42,
                loadingButtonWhenClick: true,
                text: KString.strLogin.toUpperCase(),
                color: CL_BUTTON_LOGIN,
                onTap: () => _onTapLoginButton(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onTapLoginButton() {
    if (widget.onTapLoginButton != null) {
      // Auto fill
      TextInput.finishAutofillContext(shouldSave: true);

      // Hide key board
      AppHelpers.hideKeyboard(widget.focusNode);

      widget.onTapLoginButton.call(
        UserModel(
          email: _emailController.text,
          pass: _passController.text,
        ),
      );
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passController.dispose();
    super.dispose();
  }
}
