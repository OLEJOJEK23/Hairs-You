abstract interface class SettingsRepositoryInterface {
  bool isDarkThemeSelected();
  Future<void> setDarkThemeState(bool state);
}