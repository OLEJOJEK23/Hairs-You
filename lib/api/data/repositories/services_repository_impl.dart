import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:hairs_and_you/api/core/error/Failure.dart';
import 'package:hairs_and_you/api/data/datasources/local/cache_manager.dart';
import 'package:hairs_and_you/api/data/datasources/remote/api_service.dart';
import 'package:hairs_and_you/api/data/models/services_dto.dart';
import 'package:hairs_and_you/api/domain/entities/service.dart';
import 'package:hairs_and_you/api/domain/repositories/services_repository.dart';

class ServicesRepositoryImpl implements ServicesRepository {
  ServicesRepositoryImpl(
      {required this.apiService, required this.cacheManager});

  final ApiService apiService;
  final CacheManager cacheManager;

  @override
  Future<Either<Failure, List<Services>>> getServices(
      {required String salonID}) async {
    try {
      final cachedData = await cacheManager.getData('services');
      if (cachedData != null) {
        return Right((cachedData as List)
            .map((e) => ServicesDto.fromJson(e).toDomain())
            .toList());
      }
      final response = await apiService.getServices(salonID: salonID);
      final services = response.map((dto) => dto.toDomain()).toList();

      await cacheManager.saveData(
        "services",
        response.map((e) => e.toJson()).toList(),
      );

      return Right(services);
    } on DioException catch (e) {
      return Left(ServerFailure("API error: ${e.message}"));
    } catch (e) {
      return Left(ServerFailure('Unexpected error: $e'));
    }
  }
}
