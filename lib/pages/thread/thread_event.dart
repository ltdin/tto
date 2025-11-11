part of 'thread_bloc.dart';

abstract class ThreadEvent extends Equatable {
  const ThreadEvent();

  @override
  List<Object> get props => [];
}

class GetThreadListEvent extends ThreadEvent {
  const GetThreadListEvent({this.zone, this.pageIndex = 1});

  final ZoneList zone;
  final int pageIndex;

  @override
  List<Object> get props => [zone, pageIndex];
}

class LoadMoreThreadEvent extends ThreadEvent {
  const LoadMoreThreadEvent({this.zone, this.pageIndex = 1});

  final ZoneList zone;
  final int pageIndex;

  @override
  List<Object> get props => [zone, pageIndex];
}

class RefreshThreadListEvent extends ThreadEvent {
  const RefreshThreadListEvent({this.zone});

  final ZoneList zone;

  @override
  List<Object> get props => [zone];
}
