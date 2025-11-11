part of 'comment_bloc.dart';

abstract class CommentEvent extends Equatable {
  const CommentEvent();

  @override
  List<Object> get props => null;
}

class GetListCommentEvent extends CommentEvent {
  const GetListCommentEvent({this.article});
  final Article article;
}

class AddCommentEvent extends CommentEvent {
  const AddCommentEvent({this.itemComment});

  final TTOCommentJSONModel itemComment;
}
