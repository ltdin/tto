part of 'ads_bloc.dart';

abstract class AdsEvent extends Equatable {
  const AdsEvent();

  @override
  List<Object> get props => [];
}

class UpdateKeepAliveClientMixin extends AdsEvent {
  const UpdateKeepAliveClientMixin({this.flag = false});
  final bool flag;

  @override
  List<Object> get props => [flag];
}
