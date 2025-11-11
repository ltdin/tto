part of 'tab_category_page_bloc.dart';

abstract class TabCategoryPageEvent extends Equatable {
  const TabCategoryPageEvent();

  @override
  List<Object> get props => null;
}

class RefeshListTabCategoryEvent extends TabCategoryPageEvent {
  const RefeshListTabCategoryEvent({this.zone});
  final ZoneList zone;
}

class GetTabCategoryListEvent extends TabCategoryPageEvent {
  const GetTabCategoryListEvent({this.zone});
  final ZoneList zone;
}

class TabCategoryLoadMoreListEvent extends TabCategoryPageEvent {
  const TabCategoryLoadMoreListEvent({this.zone});
  final ZoneList zone;
}
