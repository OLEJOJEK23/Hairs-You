import 'dart:ui';
import 'package:flutter_bloc/flutter_bloc.dart';
import "package:equatable/equatable.dart";
import 'package:hairs_and_you/repositories/settings_repository/settings.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit({required SettingsRepositoryInterface settingsRepository
  }) : _settingsRepository = settingsRepository,
        super(const ThemeState(Brightness.light)) {
    _checkThemeState();
  }

  final SettingsRepositoryInterface _settingsRepository;

  Future<void> changeTheme(Brightness brightness) async {
    emit(ThemeState(brightness));
    await _settingsRepository.setDarkThemeState(
        brightness == Brightness.dark,
    );
  }

  void _checkThemeState () {
    try {
      final themeState = _settingsRepository.isDarkThemeSelected()
          ? Brightness.dark
          : Brightness.light;
      emit(ThemeState(themeState));
    } catch (e) {
      print(e.toString());
    }
  }
}
