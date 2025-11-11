import 'package:flutter/material.dart';
import 'package:news/models/option.dart';

class ItemChoosePage extends StatelessWidget {
  const ItemChoosePage({
    Key key,
    @required this.item,
    @required this.callBack,
  }) : super(key: key);

  final Option item;
  final ValueChanged<int> callBack;

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme.subtitle1;

    return InkWell(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: Text(item.name, style: textStyle),
      ),
      onTap: () => callBack.call(item.key),
    );
  }
}
