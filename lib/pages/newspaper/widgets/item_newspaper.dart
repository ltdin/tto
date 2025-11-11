import 'package:flutter/material.dart';
import 'package:news/constant/color.dart';
import 'package:news/models/newspaper.dart';
import 'package:news/pages/newspaper/widgets/daily_new_menu.dart';
import 'package:news/widgets/image_network_loading.dart';

class ItemNewspaper extends StatelessWidget {
  const ItemNewspaper({@required this.newsPaper, this.onClickItem});

  final Newspaper newsPaper;
  final Function(String, String, ItemMenuType) onClickItem;

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme.subtitle2;

    return InkWell(
      child: Column(
        children: [
          Expanded(
            child: ImageNetworkLoading(
              urlImage: newsPaper.getUrlImage,
              fit: BoxFit.fill,
            ),
          ),
          SizedBox(height: 8.0),
          Text(
            'Ngày xuất bản',
            style: textStyle.copyWith(
                fontSize: 12,
                color: categoryDefaultColor,
                fontWeight: FontWeight.normal),
          ),
          Text(
            newsPaper.getStrDayFromMiliSeconds,
            style: textStyle.copyWith(
              fontSize: 15,
              color: dayItemNewsPaperColor,
            ),
          ),
        ],
      ),
      onTap: () => onClickItem.call(
        newsPaper.getDayMiliSeconds,
        newsPaper.getAppId,
        getTypeFromAppId,
      ),
    );
  }

  // Get
  ItemMenuType get getTypeFromAppId {
    switch (newsPaper.getAppId) {
      case '15':
        return ItemMenuType.SmileNews;
        break;

      case '19':
        return ItemMenuType.Weekend;
        break;

      default:
        return ItemMenuType.DailyNews;
    }
  }
}
