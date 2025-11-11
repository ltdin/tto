part of 'tab_category_page_bloc.dart';

abstract class TabCategoryPageState extends Equatable {
  const TabCategoryPageState();
  @override
  bool get stringify => true;

  @override
  List<Object> get props => null;
}

class TabCategoryPageInitial extends TabCategoryPageState {
  @override
  List<Object> get props => [];
}

class TabCategoryPageFailure extends TabCategoryPageState {
  const TabCategoryPageFailure();

  @override
  List<Object> get props => [];
}

class TabCategoryPageSuccess extends TabCategoryPageState {
  const TabCategoryPageSuccess({
    this.articles,
    this.zone,
    this.canLoadMore,
    this.page = 1,
  });

  final List<Article> articles;
  final ZoneList zone;
  final bool canLoadMore;
  final int page;

  TabCategoryPageSuccess copyWith({
    ListingByZoneStruct zoneStruct,
    ZoneList zone,
    bool canLoadMore,
    int page,
  }) {
    return TabCategoryPageSuccess(
      articles: zoneStruct ?? this.articles,
      zone: zone ?? this.zone,
      canLoadMore: canLoadMore ?? this.canLoadMore,
      page: page ?? this.page,
    );
  }

  @override
  List<Object> get props => [articles, zone, canLoadMore, page];

  @override
  String toString() =>
      'TabCategoryPageSuccess { articles: ${articles.length} - Page : $page }';
}
