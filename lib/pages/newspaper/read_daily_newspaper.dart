import 'package:bookfx/bookfx.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cupertino_datetime_picker/flutter_cupertino_datetime_picker.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:news/base/app_helpers.dart';
import 'package:news/blocs/user_bloc.dart';
import 'package:news/constant/color.dart';
import 'package:news/constant/length.dart';
import 'package:news/models/daily_newspaper.dart';
import 'package:news/models/newspaper.dart';
import 'package:news/pages/newspaper/bloc/newspaper_bloc.dart';
import 'package:news/pages/newspaper/instruct_content.dart';
import 'package:news/pages/newspaper/list_newspapers_content.dart';
import 'package:news/pages/newspaper/widgets/choose_page_smile_news.dart';
import 'package:news/pages/newspaper/widgets/choose_page_weekend_news.dart';
import 'package:news/pages/newspaper/widgets/handle_error_newspaper.dart';
import 'package:news/pages/newspaper/widgets/item_newspaper_page.dart';
import 'package:news/pages/newspaper/widgets/choose_page_daily_news.dart';
import 'package:news/pages/newspaper/widgets/choose_page_specialty_news.dart';
import 'package:news/pages/newspaper/widgets/daily_new_menu.dart';
import 'package:news/widgets/app_loading_animation.dart';
import 'package:news/widgets/button/accept_button.dart';
import 'package:news/widgets/button/icon_text_outline_button.dart';
import 'package:news/widgets/image_asset.dart';
import 'package:news/widgets/linear_progress_indicator_widget.dart';

class ReadDailyNewspaper extends StatefulWidget {
  const ReadDailyNewspaper({Key key, @required this.item, this.latestNewsPaper})
      : super(key: key);

  final DailyNewspaper item;
  final List<DailyNewspaper> latestNewsPaper;

  @override
  State<ReadDailyNewspaper> createState() => _ReadDailyNewspaperState();
}

class _ReadDailyNewspaperState extends State<ReadDailyNewspaper> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  PageController _pageController = PageController(initialPage: 0);
  NewspaperBloc _newspaperBloc = NewspaperBloc();

  int _currentPageIndex = 0;
  ItemMenuType _currentPageType = ItemMenuType.DailyNews;
  List<Newspaper> _newspaper = [];
  int _dayMillisecondsParams;
  final _sizeBox16 = SizedBox(height: 16);
  BookController bookController = BookController();

  @override
  void initState() {
    _dayMillisecondsParams = widget.item.getIntPublishedAt;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    printDebug('Build ReadDailyNewspaper');

    final _titleStyle = Theme.of(context).textTheme.subtitle1;
    final double _sizeIcon = 18.0;
    final double _sizeOptionIcon = 14.0;
    final size = MediaQuery.of(context).size;

    return MultiBlocProvider(
      providers: [
        BlocProvider<NewspaperBloc>(
          create: (context) => _newspaperBloc
            ..add(
              GetDetailNewspaperEvent(publishedAt: '$_dayMillisecondsParams'),
            ),
        ),
      ],
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          backgroundColor: PRIMARY_COLOR,
          leading: BackButton(color: CL_WHITE),
          leadingWidth: 40,
          title: Row(
            children: [
              SvgPicture.asset(
                'assets/icons/icon_daily_news_user.svg',
                height: 24,
              ),
              Text('  ${userBloc.userInfo.getUserName}',
                  style: _titleStyle.copyWith(color: CL_WHITE))
            ],
          ),
          actions: [
            IconButton(
              icon: SvgPicture.asset(
                'assets/icons/icon_daily_news_sort.svg',
                height: 40,
                color: CL_WHITE,
              ),
              onPressed: () => _scaffoldKey.currentState.openDrawer(),
            )
          ],
        ),
        body: BlocBuilder<NewspaperBloc, NewspaperState>(
          builder: (context, NewspaperState state) {
            // Loading animation
            if (state is ShowAnimationLoading) {
              return const AppLoadingAnimation();
            }

            // State is ShowListNewspapersState
            if (state is ShowListNewspapersState) {
              return ListNewspapersContent(
                listNewspaperModel: state.listNewspaperModel,
                currentPageType: _currentPageType,
                onClickItem: (miliSeconds, appId, type) {
                  resetValue(int.tryParse(miliSeconds), type);
                  _handleOpenNews(miliSeconds, appId);
                },
              );
            }

            // State is ShowDetailNewspaperState
            if (state is ShowDetailNewspaperState) {
              _newspaper = state.newspaper;

              return Stack(
                children: [
                  Column(
                    children: [
                      _sizeBox16,

                      // Two option
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: paddingNews + radius4,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // Choose category
                            IconTextOutlineButton(
                              title: 'Chọn trang',
                              icon: SvgPicture.asset(
                                'assets/icons/icon_filter.svg',
                                width: _sizeOptionIcon,
                              ),
                              color: borderOptionButtonColor,
                              borderRadius: 5.0,
                              onPressed: () =>
                                  _showPageOption(context, _currentPageType),
                            ),

                            // Choose day
                            isDailyNewsPage
                                ? IconTextOutlineButton(
                                    title: getStrDayFromTimestamp,
                                    icon: SvgPicture.asset(
                                      'assets/icons/icon_calendar.svg',
                                      width: _sizeOptionIcon,
                                    ),
                                    color: borderOptionButtonColor,
                                    borderRadius: 5.0,
                                    onPressed: () =>
                                        _showDateTimePicker(context),
                                  )
                                : SizedBox(width: 80, height: 0)
                          ],
                        ),
                      ),

                      _sizeBox16,

                      Expanded(
                        child: Container(
                          // ignore: missing_required_param
                          child: BookFx(
                            controller: bookController,
                            size: Size(size.width, size.height),
                            pageCount: _newspaper.length,
                            currentPage: (index) {
                              final item = _newspaper.elementAt(index);
                              print('current index is $index');
                              return ItemNewspaperPage(
                                newspaper: item,
                                tabIndex: index,
                              );
                            },
                            // lastCallBack: (index) {
                            //   print('last index is $index');
                            // },
                            // nextCallBack: (index){
                            //   print('next index is $index');
                            // },
                            // nextPage: (index) {
                            //   final item = _newspaper.elementAt(index);
                            //   return ItemNewspaperPage(
                            //     newspaper: item,
                            //     tabIndex: index,
                            //   );
                            // },
                          ),
                        ),
                      ),
                    ],
                  ),

                  // Left icon
                  Positioned(
                    left: 0.0,
                    top: 0.0,
                    bottom: 0.0,
                    child: ImageAsset(
                      imageAsset: 'assets/icons/icon_back_red.png',
                      width: _sizeIcon,
                      height: _sizeIcon,
                      onTap: () => _goToPreviousPage(),
                    ),
                  ),

                  // Right icon
                  Positioned(
                    right: 0.0,
                    top: 0.0,
                    bottom: 0.0,
                    child: ImageAsset(
                      imageAsset: 'assets/icons/icon_next_red.png',
                      width: _sizeIcon,
                      height: _sizeIcon,
                      onTap: () => _goToNextPage(),
                    ),
                  )
                ],
              );
            }

            // State is GetDetailNewspaperFailure
            if (state is GetDetailNewspaperFailure) {
              return HandleErrorNewspaper(
                timestamp: _dayMillisecondsParams,
                itemMenuType: _currentPageType,
                onClickShowDateTimePicker: () => _showDateTimePicker(context),
              );
            }

            // State is OpenInstructPageState
            if (state is ShowInstructPageState) {
              return InstructContent();
            }

            // Loading progress
            return LinearProgressIndicatorWidget();
          },
        ),
        drawer: Drawer(
          elevation: 3,
          child: DailyNewsMenu(
            latestNewsPaper: widget.latestNewsPaper,
            onClickItemMenu: _onClickItemMenu,
          ),
        ),
      ),
    );
  }

  // Function
  void _onClickItemMenu(ItemMenuType type, int publishedAt, String appId) {
    // Close drawer
    _scaffoldKey.currentState.closeDrawer();

    // Update value
    resetValue(publishedAt, type);

    // Check item type is click image
    if ([
      ItemMenuType.DailyNewsImage,
      ItemMenuType.SmileNewsImage,
      ItemMenuType.WeekendNewsImage,
      ItemMenuType.SpecialtyNewsImage,
    ].contains(type)) {
      _handleOpenListNewspapers(appId: appId);
      return;
    }

    // Check item type is click text
    if ([
      ItemMenuType.DailyNews,
      ItemMenuType.SmileNews,
      ItemMenuType.Weekend,
      ItemMenuType.SpecialtyNews,
    ].contains(type)) {
      _handleOpenLastestNews(appId);
      return;
    }

    // Check type = Instruct
    if (type == ItemMenuType.Instruct) {
      _handleOpenInstruct();
      return;
    }
  }

  void _handleOpenLastestNews(String appId) {
    _newspaperBloc.add(
      GetDetailLastestNewspaperEvent(appId: appId),
    );
  }

  void _handleOpenNews(String strMilliseconds, String appId) {
    _newspaperBloc.add(
      GetDetailNewspaperEvent(publishedAt: strMilliseconds, appId: appId),
    );
  }

  void _handleOpenListNewspapers({String appId}) {
    _newspaperBloc.add(ShowListNewspapersEvent(appId: appId));
  }

  void _handleOpenInstruct() {
    _newspaperBloc.add(ShowInstructPageEvent());
  }

  void _goToNextPage() {
    if (_currentPageIndex < _newspaper.length - 1) {
      _currentPageIndex++;

      // _pageController.nextPage(duration: _duration, curve: _curve);
      bookController.next();
    }
  }

  void _goToPreviousPage() {
    if (_currentPageIndex > 0) {
      _currentPageIndex--;

      // _pageController.previousPage(duration: _duration, curve: _curve);
      bookController.last();
    }
  }

  void _goToPage(int page) {
    _currentPageIndex = page;
    bookController.goTo(page);
    // _pageController.jumpToPage(page);
  }

  void _showDateTimePicker(context) {
    final style = Theme.of(context).textTheme.headline6;
    final ICON_CLOSE = 'assets/icons/icon_close.svg';
    int millisecondsSinceEpoch;

    const radius = BorderRadius.only(
      topLeft: Radius.circular(6),
      topRight: Radius.circular(6),
    );

    showModalBottomSheet(
      shape: const RoundedRectangleBorder(borderRadius: radius),
      context: context,
      builder: (builder) {
        return Container(
            height: 350.0,
            color: Colors.transparent,
            child: Column(
              children: [
                DateTimePickerWidget(
                  onChange: (date, index) => millisecondsSinceEpoch =
                      (date.millisecondsSinceEpoch ~/ 1000),
                  initDateTime: getDateTimeFromTimestamp,
                  minDateTime: DateTime(2010),
                  maxDateTime: DateTime.now(),
                  pickerTheme: DateTimePickerTheme(
                    showTitle: true,
                    pickerHeight: HEIGHT_PICKER,
                    title: Container(
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: radius,
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 16, top: 8),
                            child: SvgPicture.asset(
                              ICON_CLOSE,
                              color: Colors.transparent,
                            ),
                          ),

                          // Title
                          Padding(
                            padding: EdgeInsets.only(top: 8, right: 8),
                            child: Text('Chọn ngày', style: style),
                          ),

                          // Icon close
                          InkWell(
                            child: Padding(
                              padding: const EdgeInsets.only(right: 16, top: 8),
                              child: SvgPicture.asset(ICON_CLOSE),
                            ),
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                          )
                        ],
                      ),
                    ),
                  ),
                  dateFormat: 'yyyy-MM-dd',
                ),

                // Button accept
                AcceptButton(
                  title: 'Chọn',
                  onTap: () {
                    // Close
                    Navigator.of(context).pop();

                    // Reload data news with choose day
                    _onChangedDay(millisecondsSinceEpoch);
                  },
                ),
              ],
            ));
      },
    );
  }

  void _showPageOption(context, ItemMenuType type) {
    Widget content;
    double height = 300;

    switch (type) {
      case ItemMenuType.DailyNews:
        content = ChoosePageDailyNews(
          onSelected: (page) {
            // Close
            Navigator.of(context).pop();

            // Move to page
            _goToPage(page);
          },
        );
        height = 300;
        break;

      case ItemMenuType.SmileNews:
        height = 544;
        content = ChoosePageSmileNews(
          onSelected: (page) {
            // Close
            Navigator.of(context).pop();

            // Move to page
            _goToPage(page - 1);
          },
        );

        break;

      case ItemMenuType.SpecialtyNews:
        height = 200;
        content = ChoosePageSpecialtyNews(
          onSelected: (page) {
            // Close
            Navigator.of(context).pop();

            // Move to page
            _goToPage(page);
          },
        );
        break;

      default:
        height = 400;
        content = ChoosePageWeekendNews(
          onSelected: (page) {
            // Close
            Navigator.of(context).pop();

            // Move to page
            _goToPage(page - 1);
          },
        );
    }

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (builder) {
        return Container(
          color: Colors.transparent,
          height: height,
          child: Column(
            children: [_sizeBox16, Expanded(child: content), _sizeBox16],
          ),
        );
      },
    );
  }

  void _onChangedDay(int millisecondsSinceEpoch) {
    resetValue(millisecondsSinceEpoch, ItemMenuType.DailyNews);

    _handleOpenNews(_dayMillisecondsParams.toString(), '20');
  }

  void resetValue(int publishedAt, ItemMenuType type) {
    // Set value
    _dayMillisecondsParams = publishedAt;
    _currentPageType = type;

    // Reset value
    if (_currentPageIndex != 0) {
      _currentPageIndex = 0;
      _pageController.jumpToPage(_currentPageIndex);
    }
  }

  // Get
  int get getTimestampCurrentDay => AppHelpers.getTimestampCurrentDay;
  String get getStrDayFromTimestamp =>
      AppHelpers.getStrDayFromMiliSeconds(_dayMillisecondsParams);
  DateTime get getDateTimeFromTimestamp =>
      AppHelpers.getDateTimeFromMiliSeconds(_dayMillisecondsParams);
  bool get isDailyNewsPage => _currentPageType == ItemMenuType.DailyNews;
  String get getCurrentAppId {
    switch (_currentPageType) {
      case ItemMenuType.DailyNews:
        return '20';
        break;

      case ItemMenuType.SmileNews:
        return '15';
        break;

      case ItemMenuType.Weekend:
        return '19';
        break;

      case ItemMenuType.SpecialtyNews:
        return '18';
        break;

      case ItemMenuType.DailyNewsImage:
        return '20';
        break;

      case ItemMenuType.SmileNewsImage:
        return '15';
        break;

      case ItemMenuType.WeekendNewsImage:
        return '19';
        break;

      case ItemMenuType.SpecialtyNewsImage:
        return '18';
        break;

      default:
        return '20';
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}
