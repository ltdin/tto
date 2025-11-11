part of 'recommend_list_bloc.dart';

abstract class RecommendListEvent extends Equatable {
  const RecommendListEvent();

  @override
  List<Object> get props => [];
}

class RefreshListRecommendEvent extends RecommendListEvent {}

class GetRecommendListEvent extends RecommendListEvent {
  const GetRecommendListEvent();
}
