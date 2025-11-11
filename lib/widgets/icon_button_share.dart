import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:share/share.dart';

class IconButtonShare extends StatelessWidget {
  const IconButtonShare({
    Key key,
    this.url,
    this.subject,
    this.color = Colors.black54,
    this.onTap,
  }) : super(key: key);

  final String url;
  final String subject;
  final VoidCallback onTap;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      color: color,
      icon: SvgPicture.asset('assets/icons/icon_share.svg'),
      onPressed: () {
        onTap != null ? onTap.call() : Share.share(url, subject: subject);
      },
    );
  }
}
