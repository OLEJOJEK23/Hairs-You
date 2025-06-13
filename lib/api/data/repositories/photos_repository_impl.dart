import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:hairs_and_you/api/core/error/Failure.dart';
import 'package:hairs_and_you/api/data/datasources/local/cache_manager.dart';
import 'package:hairs_and_you/api/data/datasources/remote/api_service.dart';
import 'package:hairs_and_you/api/data/models/photos_dto.dart';
import 'package:hairs_and_you/api/domain/entities/photo.dart';
import 'package:hairs_and_you/api/domain/repositories/photos_repository.dart';

class PhotosRepositoryImpl implements PhotosRepository {
  PhotosRepositoryImpl({required this.apiService, required this.cacheManager});

  final ApiService apiService;
  final CacheManager cacheManager;

  @override
  Future<Either<Failure, List<Photo>>> getPhotos(
      {required String entityType, required String entityID}) async {
    try {
      final cachedData = await cacheManager.getData('photos');
      if (cachedData != null) {
        return Right((cachedData as List)
            .map((e) => PhotosDto.fromJson(e).toDomain())
            .toList());
      }
      final response = await apiService.getPhotos(
          entityID: entityID, entityType: entityType);
      final photos = response.map((dto) => dto.toDomain()).toList();

      await cacheManager.saveData(
        "photos",
        response.map((e) => e.toJson()).toList(),
      );

      return Right(photos);
    } on DioException catch (e) {
      return Left(ServerFailure("API error: ${e.message}"));
    } catch (e) {
      return Left(ServerFailure('Unexpected error: $e'));
    }
  }
}
