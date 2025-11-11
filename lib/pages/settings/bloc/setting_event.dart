part of 'setting_bloc.dart';

abstract class SettingEvent extends Equatable {
  const SettingEvent();

  @override
  List<Object> get props => null;
}

class UpdateThemeSettingEvent extends SettingEvent {
  const UpdateThemeSettingEvent({@required this.themeName});
  final String themeName;
}
