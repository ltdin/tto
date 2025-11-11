import 'package:flutter/material.dart';
import 'package:news/constant/color.dart';
import 'package:news/constant/string.dart';

class RetryWidget extends StatelessWidget {
  const RetryWidget({
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
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            KString.msgNoData,
            style: textStyle,
          ),
          SizedBox(height: 5),
          TextButton(
            onPressed: () => onClickRetry(),
            child: Text(
              'Tải lại',
              style: textStyle.copyWith(color: Colors.white),
            ),
            style: ElevatedButton.styleFrom(backgroundColor: PRIMARY_COLOR),
          )
        ],
      ),
    );
  }
}
