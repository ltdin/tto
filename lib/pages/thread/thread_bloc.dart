import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:news/blocs/news_bloc.dart';
import 'package:news/models/zone_model.dart';
import '../../models/thread_model.dart';

part 'thread_event.dart';
part 'thread_state.dart';

class ThreadBloc extends Bloc<ThreadEvent, ThreadState> {
  ThreadBloc() : super(ThreadInitial());

  @override
  Stream<ThreadState> mapEventToState(ThreadEvent event) async* {
    final currentState = state;

    if (event is GetThreadListEvent) {
      try {
        final threads = await bloc.getThreads(
          zoneId: event.zone.zoneId,
          pageIndex: event.pageIndex,
        );

        yield ThreadSuccess(
          threads: threads,
          zone: event.zone,
          page: event.pageIndex + 1,
          canLoadMore: threads.length >= 20,
        );
      } catch (e) {
        yield ThreadFailure();
      }
    }

    if (event is LoadMoreThreadEvent && currentState is ThreadSuccess) {
      try {
        final newThreads = await bloc.getThreads(
          zoneId: event.zone.zoneId,
          pageIndex: currentState.page,
        );

        final existingIds = currentState.threads.map((t) => t.id).toSet();
        final filtered = newThreads.where((t) => !existingIds.contains(t.id)).toList();

        yield ThreadSuccess(
          threads: currentState.threads + filtered,
          zone: event.zone,
          page: currentState.page + 1,
          canLoadMore: filtered.length >= 20,
        );
      } catch (e) {
        yield currentState.copyWith(canLoadMore: false);
      }
    }

    if (event is RefreshThreadListEvent) {
      try {
        final threads = await bloc.getThreads(
          zoneId: event.zone.zoneId,
          pageIndex: 1,
        );

        yield ThreadSuccess(
          threads: threads,
          zone: event.zone,
          page: 2,
          canLoadMore: threads.length >= 20,
        );
      } catch (e) {
        yield ThreadFailure();
      }
    }
  }
}
