part of 'setting_bloc.dart';

abstract class SettingState extends Equatable {
  const SettingState();

  @override
  bool get stringify => true;

  @override
  List<Object> get props => null;
}

class SettingInitial extends SettingState {
  @override
  List<Object> get props => [];
}

class SettingThemeSuccess extends SettingState {
  const SettingThemeSuccess({this.theme});

  final ThemeData theme;

  @override
  List<Object> get props => [theme];
}
