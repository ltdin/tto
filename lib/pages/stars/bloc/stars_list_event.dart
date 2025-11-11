part of 'stars_list_bloc.dart';

abstract class StarsListEvent extends Equatable {
  const StarsListEvent();

  @override
  List<Object> get props => [];
}

class RefreshListStarsEvent extends StarsListEvent {}

class GetStarsListEvent extends StarsListEvent {
  const GetStarsListEvent();
}
