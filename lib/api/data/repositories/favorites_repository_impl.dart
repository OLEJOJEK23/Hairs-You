import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:hairs_and_you/api/data/datasources/local/cache_manager.dart';
import 'package:hairs_and_you/api/data/datasources/remote/api_service.dart';
import 'package:hairs_and_you/api/data/models/favorites_dto.dart';
import 'package:hairs_and_you/api/domain/entities/favorites.dart';
import 'package:hairs_and_you/api/domain/repositories/favorite_repository.dart';

import '../../core/error/Failure.dart';

class FavoritesRepositoryImpl implements FavoriteRepository {
  FavoritesRepositoryImpl({
    required this.apiService,
    required this.cacheManager,
  });

  final ApiService apiService;
  final CacheManager cacheManager;

  @override
  Future<Either<Failure, Favorites>> getFavorites(
      {required String userID}) async {
    try {
      final cachedData = await cacheManager.getData('favorites_$userID');
      if (cachedData != null) {
        return Right(FavoritesDto.fromJson(cachedData).toDomain());
      }
      final response = await apiService.getFavorites(userID: userID);
      final favorites = response.toDomain();

      await cacheManager.saveData(
        "favorites_$userID",
        response.toJson(),
      );

      return Right(favorites);
    } on DioException catch (e) {
      return Left(ServerFailure(
          "API error: ${e.message ?? 'Unknown error'}, status: ${e.response?.statusCode}, data: ${e.response?.data}"));
    } catch (e) {
      return Left(ServerFailure('Unexpected error: $e'));
    }
  }
}
