part of 'video_list_bloc.dart';

abstract class VideoListEvent extends Equatable {
  const VideoListEvent();

  @override
  List<Object> get props => null;
}

class RetryListEvent extends VideoListEvent {}

class GetVideoListEvent extends VideoListEvent {
  const GetVideoListEvent();
}
