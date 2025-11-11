part of 'recently_read_bloc.dart';

abstract class RecentlyReadState extends Equatable {
  const RecentlyReadState();

  @override
  bool get stringify => true;

  @override
  List<Object> get props => null;
}

class RecentlyReadInitial extends RecentlyReadState {
  @override
  List<Object> get props => [];
}

class RecentlyReadNodata extends RecentlyReadState {
  @override
  List<Object> get props => [];
}

class ViewedNewsSuccess extends RecentlyReadState {
  const ViewedNewsSuccess({this.articles});

  final List<Article> articles;

  ViewedNewsSuccess copyWith({List<Article> spots}) {
    return ViewedNewsSuccess(
      articles: spots ?? this.articles,
    );
  }

  @override
  List<Object> get props => [articles];

  @override
  String toString() => 'RecentlyReadSuccess { posts: ${articles.length}}';
}
