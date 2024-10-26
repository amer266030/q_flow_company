import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'app_theme_state.dart';

class AppThemeCubit extends Cubit<ThemeMode> {
  AppThemeCubit() : super(ThemeMode.system) {
    _loadTheme();
  }

  Future<void> _saveTheme(ThemeMode mode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('theme', mode.toString());
  }

  Future<void> _loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final savedTheme = prefs.getString('theme');

    if (savedTheme != null) {
      if (savedTheme == ThemeMode.light.toString()) {
        emit(ThemeMode.light);
      } else if (savedTheme == ThemeMode.dark.toString()) {
        emit(ThemeMode.dark);
      } else {
        emit(ThemeMode.system);
      }
    }
  }

  void changeTheme(ThemeMode mode) {
    mode = (mode == ThemeMode.light) ? ThemeMode.dark : ThemeMode.light;
    _saveTheme(mode);
    emit(mode);
  }
}
