import 'package:flutter/material.dart';
import 'package:news/models/option.dart';
import 'package:news/pages/newspaper/widgets/item_choose_page.dart';

class ChoosePageDailyNews extends StatelessWidget {
  const ChoosePageDailyNews({Key key, this.onSelected}) : super(key: key);

  final ValueChanged<int> onSelected;

  @override
  Widget build(BuildContext context) {
    List<Option> optionsDailyNews = [
      Option(key: 1, name: 'Trang nhất'),
      Option(key: 6, name: 'Kinh tế'),
      Option(key: 10, name: 'Nhịp sống trẻ'),
      Option(key: 14, name: 'Sống khỏe'),
      Option(key: 16, name: 'Thể thao'),
      Option(key: 2, name: 'Thời sự quốc tế'),
      Option(key: 8, name: 'Bạn đọc Tuổi Trẻ'),
      Option(key: 12, name: 'Giáo dục'),
      Option(key: 15, name: 'Văn hóa giải trí'),
      Option(key: 18, name: 'Phóng sự'),
    ];

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: optionsDailyNews
              .sublist(0, 5)
              .map((item) => ItemChoosePage(item: item, callBack: onSelected))
              .toList(),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: optionsDailyNews
              .sublist(5)
              .map((item) => ItemChoosePage(item: item, callBack: onSelected))
              .toList(),
        ),
      ],
    );
  }
}
