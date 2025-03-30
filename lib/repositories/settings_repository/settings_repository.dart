import 'package:get_it/get_it.dart';
import 'package:hairs_and_you/repositories/settings_repository/settings.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsRepository implements SettingsRepositoryInterface {
  SettingsRepository();

  final sharedPreferences = GetIt.I.get<SharedPreferences>();

  static const _isDarkThemeSelected = "theme_state";

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
