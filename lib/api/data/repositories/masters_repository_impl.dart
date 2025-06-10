import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:hairs_and_you/api/core/error/Failure.dart';
import 'package:hairs_and_you/api/data/datasources/local/cache_manager.dart';
import 'package:hairs_and_you/api/data/datasources/remote/api_service.dart';
import 'package:hairs_and_you/api/data/models/master_dto.dart';
import 'package:hairs_and_you/api/domain/repositories/masters_repository.dart';

import '../../domain/entities/master.dart';

class MastersRepositoryImpl implements MastersRepository {
  MastersRepositoryImpl({required this.apiService, required this.cacheManager});

  final ApiService apiService;
  final CacheManager cacheManager;

  @override
  Future<Either<Failure, List<Master>>> getMasters({
    String? salonID,
    String? userID,
    String? masterID,
  }) async {
    try {
      final cachedData = await cacheManager.getData('masters');
      if (cachedData != null) {
        return Right((cachedData as List)
            .map((e) => MasterDto.fromJson(e).toDomain())
            .toList());
      }
      final response = await apiService.getMasters(
          salonID: salonID, userID: userID, masterID: masterID);
      final masters = response.map((dto) => dto.toDomain()).toList();

      await cacheManager.saveData(
        "masters",
        response.map((e) => e.toJson()).toList(),
      );

      return Right(masters);
    } on DioException catch (e) {
      return Left(ServerFailure("API error: ${e.message}"));
    } catch (e) {
      return Left(ServerFailure('Unexpected error: $e'));
    }
  }
}
