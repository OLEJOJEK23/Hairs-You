import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:hairs_and_you/api/core/error/Failure.dart';
import 'package:hairs_and_you/api/data/datasources/local/cache_manager.dart';
import 'package:hairs_and_you/api/data/datasources/remote/api_service.dart';
import 'package:hairs_and_you/api/domain/entities/shortSalon.dart';

import '../../domain/repositories/salons_repository.dart';
import '../models/short_salons_dto.dart';

class SalonsRepositoryImpl implements SalonsRepository {
  SalonsRepositoryImpl({required this.apiService, required this.cacheManager});

  final ApiService apiService;
  final CacheManager cacheManager;

  @override
  Future<Either<Failure, List<ShortSalon>>> getShortSalons({
    String? sortBy,
  }) async {
    try {
      final cachedData = await cacheManager.getData('services');
      if (cachedData != null) {
        return Right((cachedData as List)
            .map((e) => ShortSalonsDTO.fromJson(e).toDomain())
            .toList());
      }
      final response = await apiService.getShortSalons(location: sortBy);
      final shortSalons = response.map((dto) => dto.toDomain()).toList();

      await cacheManager.saveData(
        "short_salons",
        response.map((e) => e.toJson()).toList(),
      );

      return Right(shortSalons);
    } on DioException catch (e) {
      return Left(ServerFailure("API error: ${e.message}"));
    } catch (e) {
      return Left(ServerFailure('Unexpected error: $e'));
    }
  }
}
