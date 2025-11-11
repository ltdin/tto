part of 'newspaper_bloc.dart';

abstract class NewspaperState extends Equatable {
  const NewspaperState();

  @override
  bool get stringify => true;

  @override
  List<Object> get props => null;
}

class NewspaperInitial extends NewspaperState {}

class ShowAnimationLoading extends NewspaperState {}

class GetDetailNewspaperFailure extends NewspaperState {
  const GetDetailNewspaperFailure();
}

class ShowDetailNewspaperState extends NewspaperState {
  const ShowDetailNewspaperState({this.newspaper});

  final List<Newspaper> newspaper;

  @override
  List<Object> get props => [newspaper];
}

class ShowListNewspapersState extends NewspaperState {
  const ShowListNewspapersState({this.listNewspaperModel});

  final ListNewspaper listNewspaperModel;

  @override
  List<Object> get props => [listNewspaperModel];
}

class ShowInstructPageState extends NewspaperState {
  const ShowInstructPageState();
}
