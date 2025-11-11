import 'package:flutter/material.dart';

class LinearProgressIndicatorWidget extends StatelessWidget {
  const LinearProgressIndicatorWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: LinearProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(
          Theme.of(context).indicatorColor,
        ),
        backgroundColor: Colors.white,
      ),
      height: 3,
    );
  }
}
