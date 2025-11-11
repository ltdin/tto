part of 'home_list_bloc.dart';

abstract class HomeListState extends Equatable {
  const HomeListState();

  @override
  bool get stringify => true;

  @override
  List<Object> get props => null;
}

class HomeListInitial extends HomeListState {
  @override
  List<Object> get props => [];
}

class HomeListFailure extends HomeListState {
  const HomeListFailure();

  @override
  List<Object> get props => [];
}

class HomeListSuccess extends HomeListState {
  const HomeListSuccess({this.homeStructs});

  final HomeStruct homeStructs;

  HomeListSuccess copyWith({
    int page,
    HomeStruct homeStructs,
    bool canLoadMore,
  }) {
    return HomeListSuccess(
      homeStructs: homeStructs ?? this.homeStructs,
    );
  }

  @override
  List<Object> get props => [homeStructs];
}
