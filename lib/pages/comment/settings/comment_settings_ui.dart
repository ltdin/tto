import 'package:flutter/material.dart';
// utils
import 'package:news/util/text_style_util.dart';

class TTOCommentSettingsUI {
  final EdgeInsets padding;
  final Size avatarSize;
  final EdgeInsets avatarPadding;
  final EdgeInsets contentContainerPadding = EdgeInsets.all(10.0);
  final Color contentContainerBackgroundColor;
  final BorderRadius contentContainerBorderRadius =
      BorderRadius.all(Radius.circular(2.0));

  final TextStyle dateStyle = TTOTextStyle.regular(
      color: Colors.black.withOpacity(0.6), fontSize: 14.0);
  final TextStyle likeStyle =
      TTOTextStyle.medium(color: Colors.black.withOpacity(0.8), fontSize: 14.0);
  final TextStyle likeActiveStyle =
      TTOTextStyle.medium(color: Colors.red, fontSize: 14.0);
  final TextStyle replyStyle =
      TTOTextStyle.medium(color: Colors.black.withOpacity(0.8), fontSize: 14.0);
  final TextStyle replyActiveStyle =
      TTOTextStyle.medium(color: Colors.red, fontSize: 14.0);
  final TextStyle numLikesStyle = TTOTextStyle.regular(
      color: Colors.black.withOpacity(0.8), fontSize: 14.0);
  final TextStyle verificationStyle =
      TTOTextStyle.regular(color: Colors.red.withOpacity(0.6), fontSize: 14.0);
  final EdgeInsets actionBarPadding = EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 0.0);

  TTOCommentSettingsUI(
      {this.padding = EdgeInsets.zero,
      this.avatarSize = Size.zero,
      this.avatarPadding = EdgeInsets.zero,
      this.contentContainerBackgroundColor = Colors.white});

  TTOCommentSettingsUI.main()
      : padding = EdgeInsets.fromLTRB(0.0, 0.0, 10.0, 10.0),
        avatarSize = Size.square(42.0),
        avatarPadding = EdgeInsets.zero,
        contentContainerBackgroundColor =
            Color(0xff222222).withOpacity(0.05) /*light gray*/;

  TTOCommentSettingsUI.sub()
      : padding = EdgeInsets.fromLTRB(47.0, 0.0, 0.0, 10.0),
        avatarSize = Size.square(24.0),
        avatarPadding = EdgeInsets.only(top: 5.0),
        contentContainerBackgroundColor =
            Color(0xFF222222).withOpacity(0.05) /*light gray*/;

  TTOCommentSettingsUI.mainUnverified()
      : padding = EdgeInsets.fromLTRB(0.0, 0.0, 10.0, 10.0),
        avatarSize = Size.square(42.0),
        avatarPadding = EdgeInsets.zero,
        contentContainerBackgroundColor =
            Color(0xFFEE3322).withOpacity(0.05) /*light red*/;

  TTOCommentSettingsUI.subUnverified()
      : padding = EdgeInsets.fromLTRB(47.0, 0.0, 0.0, 10.0),
        avatarSize = Size.square(24.0),
        avatarPadding = EdgeInsets.only(top: 5.0),
        contentContainerBackgroundColor =
            Color(0xFFEE3322).withOpacity(0.05) /*light red*/;
}

class TTOCommentLoadMoreSettingsUI {
  final EdgeInsets padding = EdgeInsets.fromLTRB(80.0, 7.0, 0.0, 12.0);
  final TextStyle labelStyle = TTOTextStyle.regular(
      color: Colors.black.withOpacity(0.8), fontSize: 14.0);
}
