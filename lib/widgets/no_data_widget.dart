import 'package:flutter/material.dart';
import 'package:news/constant/color.dart';
import 'package:news/constant/string.dart';

class NoDataWidget extends StatelessWidget {
  const NoDataWidget({
    Key key,
    this.onClickRetry,
  }) : super(key: key);

  final VoidCallback onClickRetry;

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme.subtitle1;
    return Container(
      constraints: BoxConstraints.expand(),
      alignment: Alignment.center,
      child: TextButton(
        onPressed: () {
          if (onClickRetry != null) {
            onClickRetry();
          }
        },
        child: Text(
          KString.msgNoData,
          style: textStyle.copyWith(color: Colors.white),
        ),
        style: ElevatedButton.styleFrom(backgroundColor: PRIMARY_COLOR),
      ),
    );
  }
}
