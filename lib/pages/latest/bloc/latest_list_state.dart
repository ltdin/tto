part of 'latest_list_bloc.dart';

abstract class LatestListState extends Equatable {
  const LatestListState();

  @override
  bool get stringify => true;

  @override
  List<Object> get props => null;
}

class LatestListInitial extends LatestListState {
  @override
  List<Object> get props => [];
}

class LatestListFailure extends LatestListState {
  const LatestListFailure();

  @override
  List<Object> get props => [];
}

class LatestListSuccess extends LatestListState {
  const LatestListSuccess({
    this.pages = 1,
    this.articles,
    this.canLoadMore,
  });
  final int pages;
  final List<Article> articles;
  final bool canLoadMore;

  LatestListSuccess copyWith({
    int page,
    List<Article> articles,
    bool canLoadMore,
  }) {
    return LatestListSuccess(
      pages: page ?? this.pages,
      articles: articles ?? this.articles,
      canLoadMore: canLoadMore ?? this.canLoadMore,
    );
  }

  @override
  List<Object> get props => [pages, articles, canLoadMore];

  @override
  String toString() =>
      'PostSuccess { posts: ${articles.length},  page: $pages }';
}
