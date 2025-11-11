import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/base/app_cache.dart';
import 'package:news/base/app_theme.dart';

part 'setting_event.dart';
part 'setting_state.dart';

class SettingBloc extends Bloc<SettingEvent, SettingState> {
  SettingBloc() : super(SettingInitial());

  @override
  Stream<SettingState> mapEventToState(SettingEvent event) async* {
    // Handle update theme
    if (event is UpdateThemeSettingEvent) {
      // Set theme in cache
      AppCache().themeSetting = event.themeName;
      final _currentTheme = AppTheme().currentTheme;

      yield SettingThemeSuccess(theme: _currentTheme);
    }
  }
}
