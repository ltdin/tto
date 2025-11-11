import 'package:flutter/material.dart';
import 'package:news/models/tto_bottom_tabbar_model.dart';
import 'package:news/widgets/tab_item.dart';

class TTOBottomTabbar extends StatelessWidget {
  TTOBottomTabbar({
    this.items,
    this.centerItemText,
    this.height = kToolbarHeight,
    this.iconSize = 26.0,
    this.color,
    this.selectedColor,
    this.notchedShape,
    this.onTabSelected,
    this.selectedIndex = 0,
  }) {
    assert(this.items.length == 3);
  }

  final List<TTOBottomTabbarModel> items;
  final String centerItemText;
  final double height;
  final double iconSize;
  final Color color;
  final Color selectedColor;
  final NotchedShape notchedShape;
  final ValueChanged<int> onTabSelected;
  final int selectedIndex;

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      elevation: 1,
      shape: notchedShape,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(items.length, (int index) {
          return TabItem(
            selectedIndex: selectedIndex,
            widget: this,
            item: items[index],
            index: index,
            onPressed: (int index) {
              onTabSelected(index);
            },
          );
        }),
      ),
    );
  }
}
