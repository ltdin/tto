import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/base/app_helpers.dart';
import 'package:news/blocs/news_bloc.dart';
import 'package:news/models/article_model.dart';
import 'package:news/models/comment_model.dart';

part 'comment_event.dart';
part 'comment_state.dart';

class CommentBloc extends Bloc<CommentEvent, CommentState> {
  CommentBloc() : super(CommentListInitial());

  @override
  Stream<CommentState> mapEventToState(CommentEvent event) async* {
    final currentState = state;

    if (event is GetListCommentEvent) {
      final listTTOComment =
          await bloc.newsGetComment(event.article.newsId ?? "");

      if (listTTOComment != null) {
        yield CommentListSuccess(listTtoComment: listTTOComment);
      }
    }

    //
    if (event is AddCommentEvent) {
      if (currentState is CommentListSuccess) {
        printDebug(
          'currentState is CommentListSuccess ${currentState.listTtoComment.length}',
        );
        currentState.listTtoComment.insert(0, event.itemComment);
        printDebug(
          'currentState is CommentListSuccess ${currentState.listTtoComment.length}',
        );
        final newListTtoComment = currentState.listTtoComment;
        yield CommentListSuccess(
          listTtoComment: newListTtoComment,
          time: DateTime.now(),
        );
      } else {
        yield CommentListSuccess(listTtoComment: [event.itemComment]);
      }
    }
  }
}
