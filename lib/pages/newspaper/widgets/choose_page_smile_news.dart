import 'package:flutter/material.dart';
import 'package:news/models/option.dart';
import 'package:news/pages/newspaper/widgets/item_choose_page.dart';

class ChoosePageSmileNews extends StatelessWidget {
  const ChoosePageSmileNews({Key key, this.onSelected}) : super(key: key);

  final ValueChanged<int> onSelected;

  @override
  Widget build(BuildContext context) {
    List<Option> optionsDailyNews = [
      Option(key: 1, name: 'Bìa 1'),
      Option(key: 3, name: 'Trang trắng'),
      Option(key: 14, name: 'Top 10'),
      Option(key: 16, name: 'Buôn chuyện nghề'),
      Option(key: 20, name: 'Quán mắc cỡ'),
      Option(key: 27, name: 'Lẩu thập cẩm'),
      Option(key: 30, name: 'Linda kiều'),
      Option(key: 34, name: 'Chuyên đề'),
      Option(key: 37, name: 'A lô'),
      Option(key: 39, name: 'Bìa 3'),
      Option(key: 13, name: 'Bức tranh vân cẩu'),
      Option(key: 15, name: 'Hội chợ cười'),
      Option(key: 17, name: 'Lắt léo chữ nghĩa'),
      Option(key: 22, name: 'Thỏ thẻ bác sĩ'),
      Option(key: 29, name: 'Nỗi lòng'),
      Option(key: 32, name: 'Tranh biếm'),
      Option(key: 36, name: 'Muôn mặt đời cười'),
      Option(key: 38, name: 'Tiệm tạp hóa'),
      Option(key: 40, name: 'Bìa 4'),
    ];

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: optionsDailyNews
              .sublist(0, 10)
              .map((item) => ItemChoosePage(item: item, callBack: onSelected))
              .toList(),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: optionsDailyNews
              .sublist(10)
              .map((item) => ItemChoosePage(item: item, callBack: onSelected))
              .toList(),
        ),
      ],
    );
  }
}
