import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:news/constant/font.dart';
import 'package:news/constant/length.dart';

class ItemRegisterSso extends StatelessWidget {
  const ItemRegisterSso({
    Key key,
    this.title,
    this.sapo,
    this.urlImage,
    this.urlIcon,
  }) : super(key: key);

  final String title;
  final String sapo;
  final String urlImage;
  final String urlIcon;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          flex: 2,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  SvgPicture.asset(urlIcon),
                  SizedBox(width: 5),
                  Text(
                    title,
                    style: KfontConstant.styleOfBoxTitleSSo
                        .copyWith(fontWeight: FontWeight.bold),
                  )
                ],
              ),
              SizedBox(height: paddingNewsTitle),
              Text(
                sapo,
                style: KfontConstant.styleOfBoxTitleSSo,
              )
            ],
          ),
        ),
        Expanded(
          flex: 1,
          child: Image.asset(urlImage),
        )
      ],
    );
  }
}
