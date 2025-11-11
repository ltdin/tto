import 'package:flutter/material.dart';
import 'package:news/pages/comment/viewmodels/comment_view_model.dart';

class TTOCommentActionBarWidget extends StatelessWidget {
  final TTOCommentViewModel viewModel;

  const TTOCommentActionBarWidget({Key key, @required this.viewModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: viewModel.settingsUI.actionBarPadding,
      child: viewModel.commentModel.isVerified ? _buildActionBar() : Offstage(),
    );
  }

  Widget _buildActionBar() {
    String date = viewModel.commentModel.createdDate;

    return Row(
      children: [
        Text(date, style: viewModel.settingsUI.dateStyle),
        // GestureDetector(
        //     child: Padding(
        //       padding: const EdgeInsets.symmetric(horizontal: 4.0),
        //       child: Text("Thích",
        //           style: viewModel.isLiked
        //               ? viewModel.settingsUI.likeActiveStyle
        //               : viewModel.settingsUI.likeStyle),
        //     ),
        //     onTap: () {
        //       //viewModel.like();
        //     }),
        // GestureDetector(
        //     child: Padding(
        //       padding: const EdgeInsets.symmetric(horizontal: 4.0),
        //       child: Text("Trả lời",
        //           style: viewModel.isReplied
        //               ? viewModel.settingsUI.replyActiveStyle
        //               : viewModel.settingsUI.replyStyle),
        //     ),
        //     onTap: () {
        //       //viewModel.reply();
        //     }),
        // Flexible(
        //   child: Row(
        //     mainAxisAlignment: MainAxisAlignment.end,
        //     children: [
        //       Image.asset("assets/icons/ic_liked.png",
        //           width: 15.0, height: 15.0, fit: BoxFit.fill),
        //       Text("${viewModel?.numberOfLikes ?? ''}",
        //           style: viewModel.settingsUI.numLikesStyle)
        //     ],
        //   ),
        // ),
      ],
    );
  }
}
