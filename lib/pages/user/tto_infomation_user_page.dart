import 'package:flutter/material.dart';
import 'package:news/base/app_cache.dart';
import 'package:news/base/app_helpers.dart';
import 'package:news/blocs/auth_bloc.dart';
import 'package:news/blocs/user_bloc.dart';
import 'package:news/constant/bool.dart';
import 'package:news/constant/color.dart';
import 'package:news/constant/font.dart';
import 'package:news/constant/length.dart';
import 'package:news/constant/string.dart';
import 'package:news/models/user_model.dart';
import 'package:news/pages/user/empty_page.dart';
import 'package:news/pages/user/user_info_detail.dart';
import 'package:news/pages/user/widgets/tts_infomation.dart';
import 'package:news/pages/user/widgets/register_tts_info_account.dart';
import 'package:news/models/globals.dart' as globals;
import 'package:news/widgets/popup/delete_account.dart';

class TTOInfomationUserPage extends StatelessWidget {
  const TTOInfomationUserPage({
    Key key,
    this.callBackClose,
    this.callBackLogout,
    this.callBackIntoTTStar,
  }) : super(key: key);

  final VoidCallback callBackClose;
  final VoidCallback callBackLogout;
  final VoidCallback callBackIntoTTStar;

  @override
  Widget build(BuildContext context) {
    final _divider15 = Container(
      height: 15.0,
      color: Color.fromARGB(255, 74, 73, 73).withOpacity(0.1),
    );
    final _divider2 = Divider(
      height: 2.0,
      color: Colors.black.withOpacity(0.1),
    );

    return Container(
      color: CL_WHITE,
      height: double.maxFinite,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Welcom
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: paddingNews,
                vertical: paddingNewsTitle,
              ),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Name
                    Expanded(
                      child: Row(
                        children: [
                          Text(
                            'Xin chào',
                            style: KfontConstant.styleOfContentUserInfo,
                          ),
                          SizedBox(width: 8),
                          Container(
                            width: 200,
                            child: Text(
                              userBloc.userInfo?.getUserName,
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 18),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Icon close
                    IconButton(
                      padding: const EdgeInsets.only(left: paddingNewsTitle),
                      icon: Icon(Icons.close, color: Colors.grey),
                      onPressed: () =>
                          callBackClose != null ? callBackClose.call() : null,
                    )
                  ]),
            ),

            // Account infomation
            _divider15,
            Padding(
              padding: const EdgeInsets.all(paddingNews),
              child: Text(
                'Thông tin tài khoản',
                style: KfontConstant.styleOfContentUserInfo,
              ),
            ),

            if (userBloc.userInfo.isSSOAccount) ...{
              TtsInfomation(callSwichtAccount: _swichtAccount)
            } else ...{
              if (globals.isShowFullFunction) RegisterTtsInfoAccount()
            },

            _divider15,

            // Setting
            if (globals.isShowFullFunction)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: paddingNews),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.symmetric(vertical: paddingNews),
                      child: Text(
                        'Cài đặt',
                        style: KfontConstant.styleOfContentUserInfo,
                      ),
                    ),
                    _divider2,
                    Padding(
                      padding:
                          const EdgeInsets.symmetric(vertical: paddingNews),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 1,
                              child: InkWell(
                                child: Text(
                                  'Cài đặt tài khoản',
                                  style: KfontConstant.styleOfTitleUserInfo,
                                ),
                                onTap: () => _moveToSettingAccount(
                                  context,
                                  userBloc.userInfo,
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: InkWell(
                                child: Text(
                                  'Tin đã lưu',
                                  style: KfontConstant.styleOfTitleUserInfo,
                                  textAlign: TextAlign.right,
                                ),
                                onTap: () =>
                                    _moveToEmpltyPage(context, 'Tin đã lưu'),
                              ),
                            ),
                          ]),
                    ),
                    _divider2,
                    Padding(
                      padding:
                          const EdgeInsets.symmetric(vertical: paddingNews),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 1,
                              child: InkWell(
                                child: Text(
                                  'Bình luận của bạn',
                                  style: KfontConstant.styleOfTitleUserInfo,
                                ),
                                onTap: () => _moveToEmpltyPage(
                                    context, 'Bình luận của bạn'),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: InkWell(
                                child: Text(
                                  'Lịch sử giao dịch',
                                  style: KfontConstant.styleOfTitleUserInfo,
                                  textAlign: TextAlign.right,
                                ),
                                onTap: () => _moveToEmpltyPage(
                                    context, 'Lịch sử giao dịch'),
                              ),
                            ),
                          ]),
                    ),
                    _divider2,
                  ],
                ),
              ),

            // Loggout account
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: paddingNews,
                horizontal: paddingNews,
              ),
              child: Row(
                children: [
                  InkWell(
                    child: Text(
                      'Đăng xuất',
                      style: TextStyle(fontSize: 18, color: popupBuyStarColor),
                    ),
                    onTap: () async {
                      if (callBackLogout != null) {
                        _logout();
                      }
                    },
                  ),

                  // Delete account
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: InkWell(
                        child: Text(
                          KString.strDeleteAccount,
                          style: TextStyle(fontSize: 18, color: PRIMARY_COLOR),
                        ),
                        onTap: () async {
                          // Show info ticker
                          AppHelpers.showDialogForWidget(
                            context,
                            widget: DeleteAccount(
                              onAccept: () async {
                                if (callBackLogout != null) {
                                  _logout();
                                  authBloc.deleteAccount();
                                  authBloc.getPassAgain(
                                    userBloc.userInfo.getEmail,
                                  );
                                }
                              },
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),

            //
          ],
        ),
      ),
    );
  }

  Future<void> _logout() async {
    // Set flag login
    globals.isLoggedIn = FLAG_OFF;
    AppCache().isLoggedIn = globals.isLoggedIn;

    // Set flag tts
    globals.isTTStar = FLAG_OFF;
    AppCache().isTTStar = globals.isTTStar;

    // Check result
    callBackLogout.call();

    // Send otp
    authBloc.logout();
  }

  Future<void> _swichtAccount() async {
    if (globals.isIntoTTStar) {
      if (callBackIntoTTStar != null) {
        // Set flag tts
        globals.isTTStar = FLAG_ON;
        AppCache().isTTStar = globals.isTTStar;

        // Check result
        callBackIntoTTStar.call();
      }
    } else {
      // Set flag tts
      globals.isTTStar = FLAG_OFF;
      AppCache().isTTStar = globals.isTTStar;

      // Check result
      callBackLogout.call();
    }
  }

  void _moveToEmpltyPage(BuildContext context, String title) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EmptyPage(title: title),
      ),
    );
  }

  void _moveToSettingAccount(BuildContext context, UserModel userInfo) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => UserInfoDetail(userInfo: userInfo),
      ),
    );
  }
}
