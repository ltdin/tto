part of 'detail_native_bloc.dart';

abstract class DetailNativeEvent extends Equatable {
  const DetailNativeEvent();

  @override
  List<Object> get props => null;
}

class RetryDetailNativeEvent extends DetailNativeEvent {}

class GetDetailNativeEvent extends DetailNativeEvent {
  const GetDetailNativeEvent({@required this.newsId});
  final String newsId;
}
