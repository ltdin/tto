part of 'search_list_bloc.dart';

abstract class SearchListState extends Equatable {
  const SearchListState();

  @override
  bool get stringify => true;

  @override
  List<Object> get props => null;
}

class SearchListInitial extends SearchListState {
  @override
  List<Object> get props => [];
}

class SearchListLoading extends SearchListState {
  @override
  List<Object> get props => [];
}

class SearchListFailure extends SearchListState {
  const SearchListFailure();

  @override
  List<Object> get props => [];
}

class SearchListSuccess extends SearchListState {
  const SearchListSuccess({this.articles});

  final List<Article> articles;

  SearchListSuccess copyWith({List<Article> spots}) {
    return SearchListSuccess(
      articles: spots ?? this.articles,
    );
  }

  @override
  List<Object> get props => [articles];

  @override
  String toString() => 'PostSuccess { posts: ${articles.length}}';
}
