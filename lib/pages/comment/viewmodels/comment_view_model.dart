import 'package:flutter/foundation.dart';
import 'package:news/models/comment_model.dart';
import 'package:news/pages/comment/viewmodels/comment_page_view_model.dart';
import 'package:news/pages/comment/settings/comment_settings_ui.dart';
import 'package:news/base/app_helpers.dart';
import 'package:news/models/globals.dart' as globals;

abstract class TTOCommentItemViewModel {
  final TTOCommentPageViewModel pageViewModel;
  final bool isHidden;

  const TTOCommentItemViewModel({this.pageViewModel, this.isHidden = false});
}

class TTOCommentViewModel extends TTOCommentItemViewModel {
  final TTOCommentJSONModel commentModel;
  TTOCommentSettingsUI settingsUI;
  final TTOCommentViewModel parentCommentViewModel;

  bool isExanded = false;
  VoidCallback onExpandChanged;
  bool isLiked = false;
  VoidCallback onLikeChanged;
  int get numberOfLikes {
    return commentModel.like != null
        ? commentModel.like + (isLiked ? 1 : 0)
        : 0;
  }

  bool isReplied = false;

  TTOCommentViewModel({
    TTOCommentPageViewModel pageViewModel,
    bool isHidden = false,
    @required this.commentModel,
    this.parentCommentViewModel,
  }) : super(pageViewModel: pageViewModel, isHidden: isHidden) {
    settingsUI = parentCommentViewModel == null
        ? AppHelpers.safeString(commentModel.id).length != 0
            ? TTOCommentSettingsUI.main()
            : TTOCommentSettingsUI.mainUnverified()
        : AppHelpers.safeString(commentModel.id).length != 0
            ? TTOCommentSettingsUI.sub()
            : TTOCommentSettingsUI.subUnverified();

    observeInteractiveComment();
  }

  void observeInteractiveComment() {
    if (onLikeChanged != null) {
      onLikeChanged();
    }
  }
}

void reply() {
  if (!globals.isLoggedIn) {
    return;
  }
}

class TTOCommentLoadMoreViewModel extends TTOCommentItemViewModel {
  List<TTOCommentViewModel> commentViewModels;
  TTOCommentLoadMoreSettingsUI settingsUI;

  TTOCommentLoadMoreViewModel({TTOCommentPageViewModel pageViewModel})
      : super(pageViewModel: pageViewModel) {
    commentViewModels = [];
    settingsUI = new TTOCommentLoadMoreSettingsUI();
  }
}
