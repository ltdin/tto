import 'package:flutter/material.dart';
import 'package:news/base/app_helpers.dart';
import 'package:news/blocs/news_bloc.dart';
import 'package:news/constant/color.dart';
import 'package:news/models/daily_newspaper.dart';
import 'package:news/widgets/app_loading.dart';
import 'package:news/widgets/image_network_loading.dart';

class DailyNewsMenu extends StatefulWidget {
  const DailyNewsMenu({
    Key key,
    this.onClickItemMenu,
    this.latestNewsPaper,
    this.latestSpecialtyNews,
  }) : super(key: key);

  final Function(ItemMenuType, int, String) onClickItemMenu;
  final List<DailyNewspaper> latestNewsPaper;
  final List<DailyNewspaper> latestSpecialtyNews;

  @override
  State<DailyNewsMenu> createState() => _DailyNewsMenuState();
}

class _DailyNewsMenuState extends State<DailyNewsMenu> {
  List<DailyNewspaper> _latestNewspapers = [];

  @override
  void initState() {
    _latestNewspapers = widget.latestNewsPaper;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    printDebug('Build DailyNewsMenu');

    final _divider = Divider(height: 0.5, color: Colors.grey);
    return ListView(
      children: [
        // List image
        Container(
          padding: const EdgeInsets.all(16.0),
          height: 128,
          child: FutureBuilder(
            future: bloc.getDailyAndSpecialtyNews(),
            builder: (context, AsyncSnapshot<List<DailyNewspaper>> snapshot) {
              if (snapshot.hasData && snapshot.data.isNotEmpty) {
                _latestNewspapers = snapshot.data;

                return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  physics: AlwaysScrollableScrollPhysics(),
                  itemCount: _latestNewspapers.length,
                  itemBuilder: (context, int index) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 16.0),
                      child: InkWell(
                        child: Stack(
                          children: [
                            ImageNetworkLoading(
                              width: 72,
                              urlImage: _latestNewspapers[index].thumbnailUrl,
                            ),

                            // Place holder
                            if (_latestNewspapers[index].isDacSan)
                              Container(
                                width: 72,
                                color: _latestNewspapers[index].isHideDacSan
                                    ? CL_DISABLED.withOpacity(0.618)
                                    : Colors.transparent,
                              )
                          ],
                        ),
                        onTap: () {
                          if (_latestNewspapers[index].isHideDacSan) {
                            return;
                          }

                          widget.onClickItemMenu.call(
                            _getItemMenuType(index),
                            _latestNewspapers[index].publishedAt,
                            _latestNewspapers[index].getStrAppId,
                          );
                        },
                      ),
                    );
                  },
                );
              } else if (snapshot.hasError) {
                return Center(child: Text(snapshot.error.toString()));
              }

              return AppLoadingIndicator();
            },
          ),
        ),

        // Text daily news
        _divider,
        ItemMenuDailyNews(
          title: 'Tuổi trẻ nhật báo',
          onTap: () => widget.onClickItemMenu.call(
            ItemMenuType.DailyNews,
            _latestNewspapers[0].publishedAt,
            _latestNewspapers[0].getStrAppId,
          ),
        ),

        // Text TTCT
        _divider,
        ItemMenuDailyNews(
          title: 'Tuổi trẻ cuối tuần',
          onTap: () => widget.onClickItemMenu.call(
            ItemMenuType.Weekend,
            _latestNewspapers[2].publishedAt,
            _latestNewspapers[2].getStrAppId,
          ),
        ),

        // Text TTC
        _divider,
        ItemMenuDailyNews(
          title: 'Tuổi trẻ cười',
          onTap: () => widget.onClickItemMenu.call(
            ItemMenuType.SmileNews,
            _latestNewspapers[1].publishedAt,
            _latestNewspapers[1].getStrAppId,
          ),
        ),

        //Text TT Ds
        _divider,
        ItemMenuDailyNews(
          title: 'Tuổi trẻ đặc san',
          onTap: () {
            widget.onClickItemMenu.call(
              ItemMenuType.SpecialtyNews,
              _latestNewspapers[3].publishedAt,
              _latestNewspapers[3].getStrAppId,
            );
          },
        ),

        // Text TT instruct
        _divider,
        ItemMenuDailyNews(
          title: 'Hướng dẫn',
          onTap: () => widget.onClickItemMenu.call(
            ItemMenuType.Instruct,
            0,
            '0',
          ),
        ),
      ],
    );
  }

  // Get
  ItemMenuType _getItemMenuType(int index) {
    switch (index) {
      case 0:
        return ItemMenuType.DailyNewsImage;
        break;

      case 1:
        return ItemMenuType.SmileNewsImage;
        break;

      case 2:
        return ItemMenuType.WeekendNewsImage;
        break;

      case 3:
        return ItemMenuType.SpecialtyNewsImage;

      default:
        return ItemMenuType.DailyNewsImage;
    }
  }
}

class ItemMenuDailyNews extends StatelessWidget {
  const ItemMenuDailyNews({
    Key key,
    @required this.title,
    @required this.onTap,
  }) : super(key: key);

  final String title;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(
          title.toUpperCase(),
          style: Theme.of(context)
              .textTheme
              .subtitle1
              .copyWith(fontWeight: FontWeight.bold),
        ),
      ),
      onTap: onTap,
    );
  }
}

enum ItemMenuType {
  DailyNewsImage,
  SmileNewsImage,
  WeekendNewsImage,
  SpecialtyNewsImage,
  DailyNews,
  SmileNews,
  SpecialtyNews,
  Weekend,
  Instruct,
}
