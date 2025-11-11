part of 'recommend_list_bloc.dart';

abstract class RecommendListState extends Equatable {
  const RecommendListState();

  @override
  bool get stringify => true;

  @override
  List<Object> get props => null;
}

class RecommendListInitial extends RecommendListState {
  @override
  List<Object> get props => [];
}

class RecommendListFailure extends RecommendListState {
  const RecommendListFailure();

  @override
  List<Object> get props => [];
}

class RecommendListSuccess extends RecommendListState {
  const RecommendListSuccess({
    this.pages = 1,
    this.articles,
    this.canLoadMore,
  });
  final int pages;
  final List<Article> articles;
  final bool canLoadMore;

  RecommendListSuccess copyWith({
    int page,
    List<Article> articles,
    bool canLoadMore,
  }) {
    return RecommendListSuccess(
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
