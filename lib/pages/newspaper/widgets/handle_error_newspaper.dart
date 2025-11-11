import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:news/base/app_helpers.dart';
import 'package:news/constant/color.dart';
import 'package:news/constant/length.dart';
import 'package:news/pages/newspaper/widgets/daily_new_menu.dart';
import 'package:news/widgets/button/icon_text_outline_button.dart';

class HandleErrorNewspaper extends StatelessWidget {
  const HandleErrorNewspaper(
      {Key key,
      this.itemMenuType,
      this.onClickShowDateTimePicker,
      this.timestamp})
      : super(key: key);

  final ItemMenuType itemMenuType;
  final int timestamp;
  final VoidCallback onClickShowDateTimePicker;

  @override
  Widget build(BuildContext context) {
    final double _sizeOptionIcon = 14.0;
    final _sizeBox16 = SizedBox(height: 16);

    return isDailyNewsPage
        ? SizedBox(
            child: Column(
              children: [
                _sizeBox16,

                // Row calendar
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: paddingNews + radius4,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(width: 80, height: 0),

                      // Choose day
                      IconTextOutlineButton(
                        title: getStrDayFromTimestamp,
                        icon: SvgPicture.asset(
                          'assets/icons/icon_calendar.svg',
                          width: _sizeOptionIcon,
                        ),
                        color: borderOptionButtonColor,
                        borderRadius: 5.0,
                        onPressed: onClickShowDateTimePicker,
                      ),
                    ],
                  ),
                ),

                // Divider
                Padding(
                  padding: const EdgeInsets.only(top: paddingNews),
                  child: Divider(
                    height: 5,
                    color: borderOptionButtonColor,
                  ),
                ),

                // Message
                Expanded(
                  child: NewspaperErrorMessage(
                    message: 'Bạn chưa mua số báo này',
                  ),
                )
              ],
            ),
          )
        : NewspaperErrorMessage(message: 'Bạn chưa mua số báo này');
  }

  // Get
  bool get isDailyNewsPage => itemMenuType == ItemMenuType.DailyNews;
  String get getStrDayFromTimestamp =>
      AppHelpers.getStrDayFromMiliSeconds(timestamp);
}

class NewspaperErrorMessage extends StatelessWidget {
  const NewspaperErrorMessage({
    Key key,
    this.message,
    this.fontSize,
    this.iconSize = 80,
  }) : super(key: key);

  final String message;
  final double fontSize;
  final double iconSize;

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme.headline4;

    return SizedBox(
      width: double.maxFinite,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: paddingNews),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset('assets/icons/icon_waning.svg',
                width: iconSize ?? 80),
            Text(
              message,
              style: textStyle.copyWith(
                color: Colors.black87,
                fontSize: fontSize ?? textStyle.fontSize - 6,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
