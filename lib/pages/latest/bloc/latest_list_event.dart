part of 'latest_list_bloc.dart';

abstract class LatestListEvent extends Equatable {
  const LatestListEvent();

  @override
  List<Object> get props => [];
}

class RefreshListLatestEvent extends LatestListEvent {}

class GetLatestListEvent extends LatestListEvent {
  const GetLatestListEvent();
}

class LoadMoreLatestListEvent extends LatestListEvent {
  const LoadMoreLatestListEvent();
}
