part of 'recently_read_bloc.dart';

abstract class RecentlyReadEvent extends Equatable {
  const RecentlyReadEvent();

  @override
  List<Object> get props => [];
}

class GetRecentlyReadEvent extends RecentlyReadEvent {
  const GetRecentlyReadEvent();
}
