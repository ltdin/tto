part of 'ads_bloc.dart';

abstract class AdsState extends Equatable {
  const AdsState();

  @override
  List<Object> get props => [];
}

class AdsInitial extends AdsState {}

class UpdateFlagSuccess extends AdsState {
  UpdateFlagSuccess({this.flag});

  final bool flag;
  final DateTime _time = DateTime.now();

  @override
  List<Object> get props => [_time, flag];
}
