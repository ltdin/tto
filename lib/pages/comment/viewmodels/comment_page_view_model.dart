import 'package:flutter/foundation.dart';
import 'package:news/blocs/news_bloc.dart';
import 'package:news/blocs/user_bloc.dart';
import 'package:news/models/article_model.dart';
import 'package:news/models/comment_model.dart';
import 'package:news/models/globals.dart' as globals;
import 'package:news/pages/comment/viewmodels/comment_view_model.dart';

typedef TTOValueCallback<T> = Function(T value);

/// Comment View Model will handle business logic of comment page
class TTOCommentPageViewModel {
  VoidCallback onCommentsChanged;

  List<TTOCommentItemViewModel> _commentViewModels = [];

  TTOCommentPageViewModel() {
    observeUserChanged();
    observeCommentsChanged();

    if (!globals.isLoggedIn) {
      userBloc.loadUserInfoFromCache(completionHandler: onUserLoggedInChanged);
    }
  }

  VoidCallback onUserLoggedInChanged;
  void observeUserChanged() {
    if (onUserLoggedInChanged != null) {
      onUserLoggedInChanged();
    }
  }

  void observeCommentsChanged() {
    // notify view models
    if (onCommentsChanged != null) {
      onCommentsChanged();
    }
  }

  Future<bool> addComment(String content, String name, String email,
      {Article article}) async {
    String parentId = repliedCommentViewModel != null &&
            repliedCommentViewModel.parentCommentViewModel != null
        ? repliedCommentViewModel.parentCommentViewModel.commentModel.id
        : "";

    TTOAddCommentParams params = TTOAddCommentParams(
      userId: "",
      parentId: parentId,
      title: "",
      content: content,
      objectId: article?.newsId,
      objectTitle: article?.title,
      objectUrl: article?.url,
      objectType: 1,
      senderEmail: email,
      senderFullname: name,
      senderAvatar: "",
      senderAddress: "",
      senderPhone: "",
      createdBy: "",
      zoneId: article?.zoneId,
      emotion: "",
    );

    return await bloc.accountAddComment(params);
  }

  void loadMore(TTOCommentLoadMoreViewModel commentLoadMoreViewModel) {
    int index = -1;
    // = filteredCommentViewModels.indexOf(commentLoadMoreViewModel);
    if (index == -1) {
      return;
    }

    _commentViewModels.removeAt(index);
    _commentViewModels.insertAll(
        index, commentLoadMoreViewModel.commentViewModels);

    if (onCommentsChanged != null) {
      onCommentsChanged();
    }
  }

  TTOValueCallback<String> onCommentInputOpened;
  TTOCommentViewModel repliedCommentViewModel;

  void openCommentInput(TTOCommentViewModel commentViewModel) {
    repliedCommentViewModel = commentViewModel;

    if (onCommentInputOpened != null) {
      onCommentInputOpened("@${commentViewModel.commentModel.senderName} ");
    }
  }
}
