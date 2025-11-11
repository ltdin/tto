part of 'search_list_bloc.dart';

abstract class SearchListEvent extends Equatable {
  const SearchListEvent();

  @override
  List<Object> get props => null;
}

class RetrySearchListEvent extends SearchListEvent {}

class GetSearchListEvent extends SearchListEvent {
  const GetSearchListEvent({this.keyword = ''});
  final String keyword;
}
