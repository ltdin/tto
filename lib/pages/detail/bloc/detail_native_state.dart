part of 'detail_native_bloc.dart';

abstract class DetailNativeState extends Equatable {
  const DetailNativeState();

  @override
  bool get stringify => true;

  @override
  List<Object> get props => null;
}

class DetailNativeInitial extends DetailNativeState {
  @override
  List<Object> get props => [];
}

class DetailNativeFailure extends DetailNativeState {
  const DetailNativeFailure();

  @override
  List<Object> get props => [];
}

class DetailNativeOpenByWebview extends DetailNativeState {
  const DetailNativeOpenByWebview({this.article});

  final ArticleNative article;

  @override
  List<Object> get props => [article];
}

class DetailNativeSuccess extends DetailNativeState {
  const DetailNativeSuccess({this.webData, this.article});

  final String webData;
  final ArticleNative article;

  @override
  List<Object> get props => [webData, article];

  @override
  String toString() => 'PostSuccess { posts: ${webData.length}}';
}
