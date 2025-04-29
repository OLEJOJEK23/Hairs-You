abstract class CacheManager {
  Future<void> saveData(String key, dynamic data);

  Future<dynamic> getData(String key);

  Future<void> clearCache();
}

class CacheManagerImpl implements CacheManager {
  @override
  Future<void> saveData(String key, dynamic data) async {
    // TODO: Реализовать с Hive или SharedPreferences
  }

  @override
  Future<dynamic> getData(String key) async {
    // TODO: Реализовать
    return null;
  }

  @override
  Future<void> clearCache() async {
    // TODO: Реализовать
  }
}
