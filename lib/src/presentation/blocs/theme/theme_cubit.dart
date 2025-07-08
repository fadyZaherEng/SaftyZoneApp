import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:safety_zone/src/domain/usecase/get_theme_use_case.dart';
import 'package:safety_zone/src/domain/usecase/set_theme_use_case.dart';

class ThemeCubit extends Cubit<ThemeMode> {
  final GetThemeUseCase _getThemeUseCase;
  final SetThemeUseCase _setThemeUseCase;

  ThemeCubit(
    this._getThemeUseCase,
    this._setThemeUseCase,
  ) : super(ThemeMode.light) {
    getTheme();
  }

  void getTheme() async {
    final isDark = _getThemeUseCase();
    emit(isDark ? ThemeMode.dark : ThemeMode.light);
  }

  void changeTheme() async {
    final isDark = _getThemeUseCase();
    await _setThemeUseCase(!isDark);
    emit(isDark ? ThemeMode.light : ThemeMode.dark);
  }
}
