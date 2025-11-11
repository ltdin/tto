import 'package:flutter/material.dart';
import 'package:news/base/app_netcore.dart';
import 'package:news/blocs/auth_bloc.dart';
import 'package:news/blocs/user_bloc.dart';
import 'package:news/constant/color.dart';
import 'package:news/constant/enum.dart';
import 'package:news/constant/font.dart';
import 'package:news/constant/length.dart';
import 'package:news/constant/string.dart';
import 'package:news/models/user_model.dart';
import 'package:news/pages/user/widgets/get_pass_success.dart';
import 'package:news/pages/user/widgets/input_login.dart';
import 'package:news/pages/user/widgets/input_get_pass_again.dart';
import 'package:news/pages/user/widgets/input_register_infomation.dart';
import 'package:news/pages/user/widgets/register_success.dart';
import 'package:news/pages/user/widgets/verify_otp.dart';
import 'package:news/base/app_helpers.dart';
import 'package:news/widgets/box/box_bottom_widget.dart';
import 'package:news/widgets/logo_tto_widget.dart';
import 'package:smartech_base/smartech_base.dart';
import 'package:news/models/globals.dart' as globals;

class AuthPage extends StatefulWidget {
  const AuthPage({Key key, this.callbackAfterLogin}) : super(key: key);

  final VoidCallback callbackAfterLogin;

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage>
    with SingleTickerProviderStateMixin {
  FocusScopeNode focusNode = FocusScopeNode();
  UserPage _layoutCurrent = UserPage.INPUT_LOGIN_AND_REGISTER;
  String _numberPhone = '';
  UserModel _userModelAutoFill;
  TabController _tabController;

  final _selectedColor = Color(0xffED1C24);
  final _unselectedColor = Color(0xff464E5F);

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    printDebug('--------------- Build Login Page ---------------');
    focusNode = FocusScope.of(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: CL_WHITE,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Theme.of(context).indicatorColor,
        leading: BackButton(color: CL_WHITE),
        title: LogoTTOWidget(assets: globals.getWhiteLogoTTOSvg, scale: 1.5),
      ),
      body: Column(
        children: [
          ...getContentLayout,

          //  Box Bottom
          BoxBottomInfoWidget(
            backgroundColor: CL_WHITE,
            fullInfo: false,
          )
        ],
      ),
    );
  }

  List<Widget> get getContentLayout {
    switch (_layoutCurrent) {
      case UserPage.INPUT_LOGIN_AND_REGISTER:
        return [
          Padding(
            padding: const EdgeInsets.only(
              top: paddingNews,
              left: paddingNews,
              right: paddingNews,
            ),
            child: TabBar(
              controller: _tabController,
              tabs: [
                Tab(text: KString.strLogin.toUpperCase()),
                Tab(text: KString.strCreateAccount.toUpperCase())
              ],
              labelStyle: KfontConstant.tabLabelAuthStyle,
              labelColor: _selectedColor,
              indicatorColor: _selectedColor,
              unselectedLabelColor: _unselectedColor,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: paddingNews),
            child: SizedBox(
              height: 0.5,
              child: Container(color: CL_DISABLED),
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              physics: NeverScrollableScrollPhysics(),
              children: [
                InputLogin(
                  focusNode: focusNode,
                  userModelAutoFill: _userModelAutoFill,
                  onTapLoginButton: _login,
                  onMoveTo: _onMoveTo,
                ),
                InputRegisterInfomation(
                  focusNode: focusNode,
                  onTapRegisterButton: _register,
                )
              ],
            ),
          ),
        ];
        break;

      case UserPage.VERIFY_OTP:
        return [
          VerifyOtp(
            numberPhone: _numberPhone,
            onOtpCallBack: _verifyOtp,
            onMoveTo: _onMoveTo,
          )
        ];
        break;

      case UserPage.INPUT_GET_PASS_AGAIN:
        return [
          Expanded(
            child: InputGetPassAgain(
              focusNode: focusNode,
              onTapGetPassButton: _getPassAgain,
              onMoveTo: _onMoveTo,
            ),
          )
        ];
        break;

      case UserPage.GET_PASS_SUCCESS:
        return [
          Expanded(
            child: GetPassSuccess(
              focusNode: focusNode,
              onTapBackButton: () => Navigator.pop(context),
            ),
          )
        ];
        break;

      case UserPage.REGISTER_SUCCESS:
        return [
          Expanded(
            child: RegisterSuccess(
              focusNode: focusNode,
              onTapBackButton: () => Navigator.pop(context),
            ),
          )
        ];
        break;

      default:
        return [Offstage()];
    }
  }

  void _onMoveTo(UserPage page) {
    setState(() {
      _layoutCurrent = page;
    });
  }

  Future<void> _verifyOtp(String otp) async {
    // Send otp
    final verifyIsSuccess = await authBloc.verifyOtp(_numberPhone, otp);

    // Check result
    if (verifyIsSuccess) {
      Navigator.pop(context);

      // Set user
      _setUserId();

      //
      if (widget.callbackAfterLogin != null) {
        widget.callbackAfterLogin.call();
      }
    } else {
      _onMoveTo(UserPage.VERIFY_OTP);
    }
  }

  Future<void> _login(UserModel userModel) async {
    // Send otp
    final sendIsSuccess = await authBloc.login(userModel.email, userModel.pass);

    // Check result
    if (sendIsSuccess) {
      // Set user
      _setUserId();

      // Pop
      Navigator.pop(context);

      //
      if (widget.callbackAfterLogin != null) {
        widget.callbackAfterLogin.call();
      }
    } else {}
  }

  Future<void> _getPassAgain(String phoneOrEmail) async {
    // Send otp
    final isGetPassSuccess = await authBloc.getPassAgain(phoneOrEmail);

    // Check result
    if (isGetPassSuccess) {
      _onMoveTo(UserPage.GET_PASS_SUCCESS);
    } else {
      _onMoveTo(UserPage.INPUT_GET_PASS_AGAIN);
    }
  }

  Future<void> _register(UserModel userModel) async {
    // Register
    final isRegisterSuccess =
        await authBloc.register(userModel.email, userModel.pass);

    // Check result
    if (isRegisterSuccess) {
      // Set user
      _setUserId();

      // Set
      _userModelAutoFill = userModel;

      // Move to register success
      _onMoveTo(UserPage.REGISTER_SUCCESS);
    }
  }

  void _setUserId() {
    final id = userBloc.userInfo.getId;

    // Login for Netcore
    Smartech().login(id);

    // Set user Id for Netcore
    AppNetcore().setUserIdentity(id: id);
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }
}
