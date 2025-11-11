import 'package:flutter/material.dart';
import 'package:news/blocs/user_bloc.dart';
import 'package:news/pages/comment/viewmodels/comment_view_model.dart';
import 'package:news/base/app_helpers.dart';

class TTOCommentAvatarWidget extends StatelessWidget {
  final TTOCommentViewModel viewModel;

  const TTOCommentAvatarWidget({Key key, @required this.viewModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    ImageProvider image = AssetImage("assets/icons/ic_avatar.png");

    if (userBloc.photoBytes != null &&
        viewModel.commentModel.senderEmail == userBloc.userInfo.email) {
      image = MemoryImage(userBloc.photoBytes);
    } else if (AppHelpers.safeString(
          viewModel.commentModel.senderAvatarAbsoluteURL,
        ).length !=
        0) {
      image = NetworkImage(
        AppHelpers.safeString(viewModel.commentModel.senderAvatarAbsoluteURL),
      );
    }

    return Container(
      padding: viewModel.settingsUI.avatarPadding,
      child: CircleAvatar(
        backgroundImage: image,
        radius: viewModel.settingsUI.avatarSize.width / 2,
      ),
    );
  }
}
