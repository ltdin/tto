import 'package:flutter/material.dart';
import 'package:news/base/app_helpers.dart';
import 'package:news/blocs/news_bloc.dart';
import 'package:news/constant/length.dart';
import 'package:news/models/list_newspaper.dart';
import 'package:news/pages/newspaper/widgets/box_pagination.dart';
import 'package:news/pages/newspaper/widgets/daily_new_menu.dart';
import 'package:news/pages/newspaper/widgets/handle_error_newspaper.dart';
import 'package:news/pages/newspaper/widgets/item_newspaper.dart';
import 'package:news/widgets/box/box_bottom_widget.dart';

class ListNewspapersContent extends StatefulWidget {
  const ListNewspapersContent({
    Key key,
    this.listNewspaperModel,
    this.currentPageType = ItemMenuType.DailyNewsImage,
    this.onClickItem,
  }) : super(key: key);

  final ListNewspaper listNewspaperModel;
  final ItemMenuType currentPageType;
  final Function(String, String, ItemMenuType) onClickItem;

  @override
  State<ListNewspapersContent> createState() => _ListNewspapersContentState();
}

class _ListNewspapersContentState extends State<ListNewspapersContent> {
  ListNewspaper _listNewspaperModel;
  String strAppId;

  @override
  void initState() {
    _listNewspaperModel = widget.listNewspaperModel;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    printDebug('Build ListNewspapersContent');
    final titleStyle = Theme.of(context).textTheme.titleLarge;
    final _sizedBox16 = SizedBox(height: paddingNews);

    return SingleChildScrollView(
      padding: EdgeInsets.all(paddingNews),
      child: Column(
        children: [
          _sizedBox16,

          // Title
          Column(
            children: [
              Text(
                getTitleFromPageType.toUpperCase(),
                style: titleStyle.copyWith(fontWeight: FontWeight.bold),
              ),
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.only(top: paddingNews / 2),
                width: paddingNews32 * 3.5,
                height: 3,
                color: Colors.black87,
              ),
            ],
          ),
          SizedBox(height: paddingNews32 * 2.5),

          // List newsPapers
          if (_listNewspaperModel.list.isEmpty) ...[
            NewspaperErrorMessage(
              message: 'Bạn chưa mua số báo này',
              fontSize: 22,
              iconSize: 64,
            )
          ] else ...[
            GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 24,
                mainAxisSpacing: 24,
                childAspectRatio: 0.618,
              ),
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              padding: EdgeInsets.zero,
              itemCount: _listNewspaperModel.list.length,
              itemBuilder: (context, int index) => ItemNewspaper(
                newsPaper: _listNewspaperModel.list[index],
                onClickItem: widget.onClickItem,
              ),
            )
          ],

          // Pagination
          SizedBox(height: paddingNews32 * 2),
          BoxPagination(
            pagination: _listNewspaperModel.pagination,
            onPageChanged: (value) => _onPageChanged(value),
          ),

          // Box info bottom
          SizedBox(height: paddingNews32 * 3),
          BoxBottomInfoWidget(
            padding: EdgeInsets.zero,
            isShowYouthGroupLogo: true,
          )
        ],
      ),
    );
  }

  // Get
  String get getTitleFromPageType {
    switch (widget.currentPageType) {
      case ItemMenuType.DailyNewsImage:
        strAppId = '20';
        return 'Danh sách tuổi trẻ Nhật Báo';
        break;

      case ItemMenuType.SmileNewsImage:
        strAppId = '15';
        return 'Danh sách tuổi trẻ cười';
        break;

      case ItemMenuType.SpecialtyNews:
        strAppId = '18';
        return 'Danh sách tuổi trẻ đặc san';
        break;

      default:
        strAppId = '19';
        return 'Danh sách tuổi trẻ cuối tuần';
    }
  }

  // Function
  Future<void> _onPageChanged(int value) async {
    final newsPaperModel = await bloc.getListNewsPaper(strAppId, '$value');

    // Update
    if (newsPaperModel.isNotEmplty) {
      setState(() {
        _listNewspaperModel = newsPaperModel;
      });
    }
  }
}
