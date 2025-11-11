part of 'comment_bloc.dart';

abstract class CommentState extends Equatable {
  const CommentState();

  @override
  bool get stringify => true;

  @override
  List<Object> get props => null;
}

class CommentListInitial extends CommentState {
  @override
  List<Object> get props => [];
}

class CommentListFailure extends CommentState {
  const CommentListFailure();

  @override
  List<Object> get props => [];
}

class CommentListSuccess extends CommentState {
  const CommentListSuccess({
    this.listTtoComment,
    this.time,
  });

  final List<TTOCommentJSONModel> listTtoComment;
  final DateTime time;

  @override
  List<Object> get props => [listTtoComment, time];

  @override
  String toString() => 'CommentListSuccess { posts: ${listTtoComment.length}}';
}
