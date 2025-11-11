import 'package:flutter/material.dart';
import 'package:news/models/option.dart';
import 'package:news/pages/newspaper/widgets/item_choose_page.dart';

class ChoosePageWeekendNews extends StatelessWidget {
  const ChoosePageWeekendNews({Key key, this.onSelected}) : super(key: key);

  final ValueChanged<int> onSelected;

  @override
  Widget build(BuildContext context) {
    List<Option> optionsDailyNews = [
      Option(key: 1, name: 'Trang bìa'),
      Option(key: 3, name: 'Vấn đề - Sự kiện'),
      Option(key: 6, name: 'Vấn đề sự kiện'),
      Option(key: 25, name: 'Phóng sự'),
      Option(key: 32, name: 'Văn hóa'),
      Option(key: 37, name: 'Du lịch'),
      Option(key: 40, name: 'Thư giãn'),
      Option(key: 2, name: 'Quảng Cáo'),
      Option(key: 4, name: 'Thời sự quốc tế'),
      Option(key: 18, name: 'Sống khỏe'),
      Option(key: 30, name: 'Thế giới không phẳng'),
      Option(key: 34, name: 'Sáng tác'),
      Option(key: 38, name: 'Thể thao'),
      Option(key: 42, name: 'Tiểu phẩm'),
    ];

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: optionsDailyNews
              .sublist(0, 7)
              .map((item) => ItemChoosePage(item: item, callBack: onSelected))
              .toList(),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: optionsDailyNews
              .sublist(7)
              .map((item) => ItemChoosePage(item: item, callBack: onSelected))
              .toList(),
        ),
      ],
    );
  }
}
