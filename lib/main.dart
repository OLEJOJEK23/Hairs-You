import 'package:dio/dio.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:hairs_and_you/controllers/Auth_contoroller.dart';
import 'package:hairs_and_you/controllers/Link_account_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Hairs_and_you_app.dart';
import 'api/core/network/dio_client.dart';
import 'api/data/datasources/local/cache_manager.dart';
import 'api/data/datasources/remote/api_service.dart';
import 'api/data/repositories/place_repository_impl.dart';
import 'api/domain/repositories/place_repository.dart';
import 'api/domain/usecases/get_nearby_salons.dart';
import 'api/domain/usecases/get_place_suggestions.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  final sharedPreferences = await SharedPreferences.getInstance();
  GetIt.I.registerLazySingleton(() => sharedPreferences);
  GetIt.I.registerLazySingleton(() => AuthController());
  GetIt.I.registerLazySingleton(() => LinkAccountController());

  // Регистрация зависимостей для API
  GetIt.I.registerLazySingleton(() => DioClient.googleMapsInstance);
  GetIt.I.registerLazySingleton(() => ApiService(GetIt.I<Dio>()));
  GetIt.I.registerLazySingleton<CacheManager>(
      () => CacheManagerImpl(GetIt.I<SharedPreferences>()));
  GetIt.I.registerLazySingleton<PlaceRepository>(
    () => PlaceRepositoryImpl(
      apiService: GetIt.I<ApiService>(),
      cacheManager: GetIt.I<CacheManager>(),
    ),
  );
  GetIt.I
      .registerLazySingleton(() => GetNearbySalons(GetIt.I<PlaceRepository>()));
  GetIt.I.registerLazySingleton(
      () => GetPlaceSuggestions(GetIt.I<PlaceRepository>()));
  runApp(const HairsAndYouApp());
}
