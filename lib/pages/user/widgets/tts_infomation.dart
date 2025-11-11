import 'package:flutter/material.dart';
import 'package:news/base/app_helpers.dart';
import 'package:news/blocs/user_bloc.dart';
import 'package:news/constant/color.dart';
import 'package:news/constant/font.dart';
import 'package:news/constant/length.dart';
import 'package:news/pages/user/widgets/buy_star.dart';
import 'package:news/pages/user/widgets/extend_star.dart';
import 'package:news/models/globals.dart' as globals;

class TtsInfomation extends StatelessWidget {
  const TtsInfomation({Key key, this.callSwichtAccount}) : super(key: key);

  final VoidCallback callSwichtAccount;

  @override
  Widget build(BuildContext context) {
    final _divider2 = Divider(
      height: 2.0,
      color: Colors.black.withOpacity(0.1),
    );

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: paddingNews),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _divider2,

          Padding(
            padding: const EdgeInsets.only(top: paddingNews),
            child: Text(
              'Tài khoản Tuổi trẻ Sao',
              style: KfontConstant.styleOfTitleUserInfo,
            ),
          ),
          SizedBox(height: 15),

          // Extend & extend day
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Ngày hết hạn',
                    style: TextStyle(
                      fontSize: 16,
                      color: KfontConstant.sapoFontColor,
                    ),
                  ),
                  Text(
                    userBloc.userInfo.getExpire.toString(),
                    style: KfontConstant.styleOfTitleUserInfo,
                  )
                ],
              ),

              // Extend
              // if (globals.isAndroid)
              //   ButtonOutlinedCustom(
              //     width: 100,
              //     content: Text(
              //       'Gia hạn',
              //       style: KfontConstant.styleOfSeeMoreSubZone
              //           .copyWith(color: textVoteColor),
              //     ),
              //     onClick: () => _isShowExtend(context),
              //   ),
            ],
          ),

          Padding(
            padding: const EdgeInsets.only(top: paddingNews),
            child: _divider2,
          ),

          // Interactive Stars
          Padding(
            padding: const EdgeInsets.symmetric(vertical: paddingNews),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //
                Text(
                  'Số sao tương tác',
                  style: KfontConstant.styleOfTitleUserInfo,
                ),

                SizedBox(height: 15),

                // Star number
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text(
                          userBloc.userInfo?.getStar.toString(),
                          style: KfontConstant.styleOfTitleUserInfo,
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.only(left: paddingNewsTitle),
                          child: Image.asset('assets/icons/icon_star.png'),
                        ),
                      ],
                    ),

                    // Buy star
                    // ButtonOutlinedCustom(
                    //   width: 100,
                    //   content: Text(
                    //     'Mua sao',
                    //     style: KfontConstant.styleOfSeeMoreSubZone
                    //         .copyWith(color: textVoteColor),
                    //   ),
                    //   onClick: () => _isShowBuyStar(context),
                    // ),
                  ],
                ),
              ],
            ),
          ),

          // Loggout TTS
          InkWell(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: paddingNews),
              child: Text(
                globals.isIntoTTStar
                    ? 'Vào tuổi trẻ Sao'
                    : 'Thoát tuổi trẻ Sao',
                style: TextStyle(
                  fontSize: 18,
                  color: popupBuyStarColor,
                ),
              ),
            ),
            onTap: () =>
                callSwichtAccount != null ? callSwichtAccount.call() : null,
          ),
        ],
      ),
    );
  }

  // ignore: unused_element
  void _isShowExtend(BuildContext context) {
    AppHelpers.showDialogForWidget(context,
        widget: Container(
          margin: EdgeInsets.symmetric(
            horizontal: paddingNews,
            vertical: 20,
          ),
          child: ExtendStar(userInfo: userBloc.userInfo),
        ),
        barrierDismissible: true);
  }

  // ignore: unused_element
  void _isShowBuyStar(BuildContext context) {
    AppHelpers.showDialogForWidget(context,
        widget: Container(
          margin: EdgeInsets.symmetric(
            horizontal: paddingNews,
            vertical: 60,
          ),
          child: BuyStar(userInfo: userBloc.userInfo),
        ),
        barrierDismissible: true);
  }
}
