part of 'home_list_bloc.dart';

abstract class HomeListEvent extends Equatable {
  const HomeListEvent();

  @override
  List<Object> get props => null;
}

class RefreshHomeListEvent extends HomeListEvent {}

class RetryHomeListEvent extends HomeListEvent {}

class GetHomeListEvent extends HomeListEvent {
  const GetHomeListEvent();
}
