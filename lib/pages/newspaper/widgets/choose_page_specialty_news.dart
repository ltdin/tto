import 'package:flutter/material.dart';
import 'package:news/models/option.dart';
import 'package:news/pages/newspaper/widgets/item_choose_page.dart';

class ChoosePageSpecialtyNews extends StatelessWidget {
  const ChoosePageSpecialtyNews({Key key, this.onSelected}) : super(key: key);

  final ValueChanged<int> onSelected;

  @override
  Widget build(BuildContext context) {
    List<Option> optionsDailyNews = [
      Option(key: 1, name: 'Trang bìa'),
      Option(key: 2, name: 'Đặc san'),
    ];

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: optionsDailyNews
          .sublist(0, 2)
          .map((item) => ItemChoosePage(item: item, callBack: onSelected))
          .toList(),
    );
  }
}
