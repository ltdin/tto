import 'package:flutter/material.dart';

class LogoLoggedIn extends StatelessWidget {
  const LogoLoggedIn({Key key, this.onTap}) : super(key: key);

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: CircleAvatar(
        backgroundColor: Colors.transparent,
        radius: 24,
        child: ClipOval(
          child: Image.asset(
            'assets/icons/icon_account_logged.jpg',
            height: 24,
            width: 24,
          ),
        ),
      ),
      onPressed: () => onTap != null ? onTap.call() : null,
    );
  }
}
