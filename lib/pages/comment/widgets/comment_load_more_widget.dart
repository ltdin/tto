import 'package:flutter/material.dart';
// view models
import 'package:news/pages/comment/viewmodels/comment_view_model.dart';

class TTOCommentLoadMoreWidget extends StatelessWidget {
  final TTOCommentLoadMoreViewModel viewModel;

  const TTOCommentLoadMoreWidget({Key key, @required this.viewModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        padding: viewModel.settingsUI.padding,
        child: Text(
          "Xem thêm bình luận ...",
          style: viewModel.settingsUI.labelStyle,
        ),
      ),
      onTap: () {
        viewModel.pageViewModel.loadMore(viewModel);
      },
    );
  }
}
