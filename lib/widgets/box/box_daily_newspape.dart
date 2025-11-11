import 'package:flutter/material.dart';
import 'package:news/base/app_helpers.dart';
import 'package:news/blocs/news_bloc.dart';
import 'package:news/constant/color.dart';
import 'package:news/constant/length.dart';
import 'package:news/constant/string.dart';
import 'package:news/models/daily_newspaper.dart';
import 'package:news/pages/newspaper/read_daily_newspaper.dart';
import 'package:news/widgets/app_loading.dart';
import 'package:news/widgets/box/item_daily_newspaper.dart';
import 'package:news/widgets/button_elevated_custom.dart';
import 'package:news/widgets/divider_widget.dart';
import 'package:news/widgets/header_box_sso.dart';

class BoxDailyNewspaper extends StatefulWidget {
  const BoxDailyNewspaper({Key key}) : super(key: key);

  @override
  State<BoxDailyNewspaper> createState() => _BoxDailyNewspaperState();
}

class _BoxDailyNewspaperState extends State<BoxDailyNewspaper>
    with AutomaticKeepAliveClientMixin {
  List<DailyNewspaper> _listNewsPaper = [];

  @override
  Widget build(BuildContext context) {
    super.build(context);
    printDebug('Build BoxDailyNewspaper ');

    return Wrap(
      children: [
        DividerWidget(),
        Container(
          margin: EdgeInsets.symmetric(
            vertical: paddingNewsTitle,
          ),
          child: Column(
            children: [
              // Header
              HeaderBoxSSO(
                inmageAsset: 'assets/icons/icon_box_daily_newspaper.svg',
                topic: 'E - Paper',
              ),

              // Slider
              FutureBuilder(
                future: bloc.getLatestNewspaper(),
                builder:
                    (context, AsyncSnapshot<List<DailyNewspaper>> snapshot) {
                  if (snapshot.hasData) {
                    _listNewsPaper = snapshot.data;

                    if (_listNewsPaper is List<DailyNewspaper>) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: paddingNews,
                        ),
                        child: IteamDailyNewspaper(
                          dailyNewspaper: _listNewsPaper[0],
                          onTap: () =>
                              _moveToReadDailyNewspaper(_listNewsPaper[0]),
                        ),
                      );
                    }
                  }

                  return AppLoadingIndicator();
                },
              ),

              // Button
              Padding(
                padding: const EdgeInsets.all(paddingNews),
                child: ButtonElevatedCustom(
                  width: double.maxFinite,
                  height: 50,
                  text: KString.strReadPrintNewspaper,
                  color: buttonVoteColor,
                  onTap: () => _moveToReadDailyNewspaper(_listNewsPaper[0]),
                ),
              ),
            ],
          ),
          decoration: BoxDecoration(
            color: cardNewsBackgroundColor,
            border: Border.all(color: voteBackgroundColor),
            borderRadius: BorderRadius.circular(radius8),
          ),
        )
      ],
    );
  }

  void _moveToReadDailyNewspaper(DailyNewspaper item) {
    Navigator.push(
      context,
      MaterialPageRoute(
        settings: RouteSettings(name: "/daily_newspaper"),
        builder: (context) => ReadDailyNewspaper(
          item: item,
          latestNewsPaper: _listNewsPaper,
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
