part of 'newspaper_bloc.dart';

abstract class NewspaperEvent extends Equatable {
  const NewspaperEvent();

  @override
  List<Object> get props => null;
}

class RetryDetailNativeEvent extends NewspaperEvent {}

class GetDetailNewspaperEvent extends NewspaperEvent {
  const GetDetailNewspaperEvent(
      {this.appId = '20', @required this.publishedAt});

  final String publishedAt;
  final String appId;
}

class GetDetailLastestNewspaperEvent extends NewspaperEvent {
  const GetDetailLastestNewspaperEvent({this.appId = '20'});

  final String appId;
}

class ShowInstructPageEvent extends NewspaperEvent {}

class ShowListNewspapersEvent extends NewspaperEvent {
  const ShowListNewspapersEvent({this.appId = '20', this.page = '1'});

  final String appId;
  final String page;
}
