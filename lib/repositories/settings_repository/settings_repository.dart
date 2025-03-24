import 'package:hairs_and_you/repositories/settings_repository/settings.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsRepository implements SettingsRepositoryInterface {
  SettingsRepository({
    required this.sharedPreferences
  });

  static const _isDarkThemeSelected = "theme_state";

  final SharedPreferences sharedPreferences;



  @override
  bool isDarkThemeSelected() {
    final themeState = sharedPreferences.getBool(_isDarkThemeSelected);
    return themeState ?? false;
  }

  @override
  Future<void> setDarkThemeState(bool state) async {
    await sharedPreferences.setBool(_isDarkThemeSelected, state);
  }

}