part of 'podcast_list_bloc.dart';

abstract class PodcastListState extends Equatable {
  const PodcastListState();

  @override
  bool get stringify => true;

  @override
  List<Object> get props => null;
}

class PodcastListInitial extends PodcastListState {
  @override
  List<Object> get props => [];
}

class PodcastListFailure extends PodcastListState {
  const PodcastListFailure();

  @override
  List<Object> get props => [];
}

class PodcastListSuccess extends PodcastListState {
  const PodcastListSuccess({this.podcasts});

  final List<PodcastModel> podcasts;

  PodcastListSuccess copyWith({List<PodcastModel> spots}) {
    return PodcastListSuccess(
      podcasts: spots ?? this.podcasts,
    );
  }

  @override
  List<Object> get props => [podcasts];

  @override
  String toString() => 'PostSuccess { posts: ${podcasts.length}}';
}
