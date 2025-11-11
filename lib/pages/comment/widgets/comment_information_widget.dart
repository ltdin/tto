import 'package:flutter/material.dart';
import 'package:news/pages/comment/viewmodels/comment_view_model.dart';
import 'package:news/pages/comment/widgets/comment_action_bar_widget.dart';
import 'package:news/pages/comment/widgets/comment_content_container_widget.dart';

class TTOCommentInformationWidget extends StatelessWidget {
  final TTOCommentViewModel viewModel;

  const TTOCommentInformationWidget({Key key, @required this.viewModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flexible(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TTOCommentContentContainerWidget(viewModel: viewModel),
        TTOCommentActionBarWidget(viewModel: viewModel)
      ],
    ));
  }
}
