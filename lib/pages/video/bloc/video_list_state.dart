part of 'video_list_bloc.dart';

abstract class VideoListState extends Equatable {
  const VideoListState();

  @override
  bool get stringify => true;

  @override
  List<Object> get props => null;
}

class VideoListInitial extends VideoListState {
  @override
  List<Object> get props => [];
}

class VideoListFailure extends VideoListState {
  const VideoListFailure();

  @override
  List<Object> get props => [];
}

class VideoListSuccess extends VideoListState {
  const VideoListSuccess({this.articles});

  final List<Article> articles;

  VideoListSuccess copyWith({List<Article> spots}) {
    return VideoListSuccess(
      articles: spots ?? this.articles,
    );
  }

  @override
  List<Object> get props => [articles];

  @override
  String toString() => 'PostSuccess { posts: ${articles.length}}';
}
