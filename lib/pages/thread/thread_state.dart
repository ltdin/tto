part of 'thread_bloc.dart';

abstract class ThreadState extends Equatable {
  const ThreadState();

  @override
  List<Object> get props => [];
}

class ThreadInitial extends ThreadState {}

class ThreadFailure extends ThreadState {}

class ThreadSuccess extends ThreadState {
  final List<ThreadModel> threads;
  final ZoneList zone;
  final int page;
  final bool canLoadMore;

  ThreadSuccess({this.threads, this.zone, this.page = 1, this.canLoadMore = true});

  ThreadSuccess copyWith({
    List<ThreadModel> threads,
    ZoneList zone,
    int page,
    bool canLoadMore,
  }) {
    return ThreadSuccess(
      threads: threads ?? this.threads,
      zone: zone ?? this.zone,
      page: page ?? this.page,
      canLoadMore: canLoadMore ?? this.canLoadMore,
    );
  }

  @override
  List<Object> get props => [threads, zone, page, canLoadMore];
}

