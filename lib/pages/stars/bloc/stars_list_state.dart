part of 'stars_list_bloc.dart';

abstract class StarsListState extends Equatable {
  const StarsListState();

  @override
  bool get stringify => true;

  @override
  List<Object> get props => null;
}

class StarsListInitial extends StarsListState {
  @override
  List<Object> get props => [];
}

class StarsListFailure extends StarsListState {
  const StarsListFailure();

  @override
  List<Object> get props => [];
}

class StarsListSuccess extends StarsListState {
  const StarsListSuccess({
    this.pages = 1,
    this.articles,
  });
  final int pages;
  final List<Article> articles;

  StarsListSuccess copyWith({
    int page,
    List<Article> articles,
    bool canLoadMore,
  }) {
    return StarsListSuccess(
      pages: page ?? this.pages,
      articles: articles ?? this.articles,
    );
  }

  @override
  List<Object> get props => [pages, articles];

  @override
  String toString() =>
      'PostSuccess { posts: ${articles.length},  page: $pages }';
}
