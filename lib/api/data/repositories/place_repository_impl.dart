import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../core/error/failure.dart';
import '../../domain/entities/place.dart';
import '../../domain/repositories/place_repository.dart';
import '../datasources/local/cache_manager.dart';
import '../datasources/remote/api_service.dart';
import '../models/place_dto.dart';

class PlaceRepositoryImpl implements PlaceRepository {
  final ApiService apiService;
  final CacheManager cacheManager;

  PlaceRepositoryImpl({
    required this.apiService,
    required this.cacheManager,
  });

  @override
  Future<Either<Failure, List<Place>>> getNearbySalons(LatLng position) async {
    try {
      // Проверяем кэш
      final cachedData = await cacheManager
          .getData('nearby_salons_${position.latitude}_${position.longitude}');
      if (cachedData != null) {
        return Right((cachedData as List)
            .map((e) => PlaceDto.fromJson(e).toDomain())
            .toList());
      }

      // Запрос к API
      final response = await apiService.getNearbySalons(
        location: '${position.latitude},${position.longitude}',
      );
      final places = response.results.map((dto) => dto.toDomain()).toList();

      // Сохраняем в кэш
      await cacheManager.saveData(
        'nearby_salons_${position.latitude}_${position.longitude}',
        response.results.map((e) => e.toJson()).toList(),
      );

      return Right(places);
    } on DioException catch (e) {
      return Left(ServerFailure('API error: ${e.message}'));
    } catch (e) {
      return Left(ServerFailure('Unexpected error: $e'));
    }
  }
}
