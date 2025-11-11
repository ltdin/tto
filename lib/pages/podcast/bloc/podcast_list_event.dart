part of 'podcast_list_bloc.dart';

abstract class PodcastListEvent extends Equatable {
  const PodcastListEvent();

  @override
  List<Object> get props => null;
}

class PodcastRetryListEvent extends PodcastListEvent {}

class GetPodcastListEvent extends PodcastListEvent {
  const GetPodcastListEvent();
}
