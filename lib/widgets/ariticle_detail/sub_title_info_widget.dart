import 'package:flutter/material.dart';

class SubTitleInfoWidget extends StatelessWidget {
  SubTitleInfoWidget({
    Key key,
    @required this.subTitleOne,
    this.subTitleTwo,
  }) : super(key: key);

  final String subTitleOne;
  final String subTitleTwo;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 10, top: 10),
      child: RichText(
        text: TextSpan(
            text: this.subTitleOne,
            style: TextStyle(
                color: Colors.red, fontWeight: FontWeight.bold, fontSize: 10),
            children: <TextSpan>[
              TextSpan(
                text: this.subTitleTwo,
                style: TextStyle(
                    color: Color(0xff222222),
                    fontSize: 10,
                    fontWeight: FontWeight.normal),
              )
            ]),
      ),
    );
  }
}
