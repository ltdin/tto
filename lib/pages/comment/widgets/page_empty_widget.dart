import 'package:flutter/material.dart';
// view models
import 'package:news/pages/comment/viewmodels/comment_page_view_model.dart';
// settings
import 'package:news/pages/comment/settings/comment_page_settings_ui.dart';

class TTOCommentPageEmptyWidget extends StatelessWidget {
  final TTOCommentPageViewModel viewModel;
  final TTOCommentPageSettingsUI settingsUI;

  TTOCommentPageEmptyWidget({Key key, this.viewModel, this.settingsUI})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.fromLTRB(12.0, 12.0, 12.0, 12.0),
        child: Text(
          "Hãy là người bình luận đầu tiên",
          textAlign: TextAlign.center,
          style: settingsUI.firstCommentStyle,
        ),
      ),
    );
  }
}
