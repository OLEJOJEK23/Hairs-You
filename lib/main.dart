import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:hairs_and_you/api/data/repositories/reviews_repository_impl.dart';
import 'package:hairs_and_you/api/data/repositories/services_repository_impl.dart';
import 'package:hairs_and_you/api/domain/repositories/reviews_repository.dart';
import 'package:hairs_and_you/api/domain/repositories/salons_repository.dart';
import 'package:hairs_and_you/api/domain/repositories/services_repository.dart';
import 'package:hairs_and_you/api/domain/usecases/get_reviews.dart';
import 'package:hairs_and_you/api/domain/usecases/get_short_salons.dart';
import 'package:hairs_and_you/api/domain/usecases/get_special_offers.dart';
import 'package:hairs_and_you/controllers/Auth_contoroller.dart';
import 'package:hairs_and_you/controllers/Link_account_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Hairs_and_you_app.dart';
import 'api/core/network/dio_client.dart';
import 'api/core/network/network_config.dart';
import 'api/data/datasources/local/cache_manager.dart';
import 'api/data/datasources/remote/api_service.dart';
import 'api/data/repositories/place_repository_impl.dart';
import 'api/data/repositories/salons_repository_impl.dart';
import 'api/domain/repositories/place_repository.dart';
import 'api/domain/usecases/get_nearby_salons.dart';
import 'api/domain/usecases/get_place_suggestions.dart';
import 'api/domain/usecases/get_services.dart';
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

  // Регистрация Dio для Google Maps и бэкенда
  GetIt.I.registerLazySingleton(() => DioClient.googleMapsInstance,
      instanceName: 'googleMapsDio');
  GetIt.I.registerLazySingleton(() => DioClient.backendInstance,
      instanceName: 'backendDio');

  // Регистрация ApiService для Google Maps
  GetIt.I.registerLazySingleton<ApiService>(
    () => ApiService(GetIt.I(instanceName: 'googleMapsDio'),
        baseUrl: NetworkConfig.googleMapsBaseUrl),
    instanceName: 'googleMaps',
  );

  // Регистрация ApiService для бэкенда
  GetIt.I.registerLazySingleton<ApiService>(
    () => ApiService(GetIt.I(instanceName: 'backendDio'),
        baseUrl: NetworkConfig.baseUrl),
    instanceName: 'backend',
  );

  GetIt.I.registerLazySingleton<CacheManager>(
      () => CacheManagerImpl(GetIt.I<SharedPreferences>()));

  // Регистрация репозиториев
  GetIt.I.registerLazySingleton<PlaceRepository>(
    () => PlaceRepositoryImpl(
      apiService: GetIt.I<ApiService>(instanceName: 'googleMaps'),
      cacheManager: GetIt.I<CacheManager>(),
    ),
  );
  GetIt.I.registerLazySingleton<SalonsRepository>(
    () => SalonsRepositoryImpl(
      apiService: GetIt.I<ApiService>(instanceName: 'backend'),
      cacheManager: GetIt.I<CacheManager>(),
    ),
  );
  GetIt.I.registerLazySingleton<ReviewsRepository>(
    () => ReviewsRepositoryImpl(
      apiService: GetIt.I<ApiService>(instanceName: 'backend'),
      cacheManager: GetIt.I<CacheManager>(),
    ),
  );
  GetIt.I.registerLazySingleton<ServicesRepository>(
    () => ServicesRepositoryImpl(
      apiService: GetIt.I<ApiService>(instanceName: 'backend'),
      cacheManager: GetIt.I<CacheManager>(),
    ),
  );

  // Регистрация use cases
  GetIt.I
      .registerLazySingleton(() => GetNearbySalons(GetIt.I<PlaceRepository>()));
  GetIt.I.registerLazySingleton(
      () => GetPlaceSuggestions(GetIt.I<PlaceRepository>()));
  GetIt.I
      .registerLazySingleton(() => GetShortSalons(GetIt.I<SalonsRepository>()));
  GetIt.I.registerLazySingleton(
      () => GetSpecialOffers(GetIt.I<SalonsRepository>()));
  GetIt.I.registerLazySingleton(() => GetReviews(GetIt.I<ReviewsRepository>()));
  GetIt.I
      .registerLazySingleton(() => GetServices(GetIt.I<ServicesRepository>()));

  runApp(const HairsAndYouApp());
}
