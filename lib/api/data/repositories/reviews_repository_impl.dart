import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:hairs_and_you/api/core/error/Failure.dart';
import 'package:hairs_and_you/api/data/datasources/local/cache_manager.dart';
import 'package:hairs_and_you/api/data/datasources/remote/api_service.dart';
import 'package:hairs_and_you/api/data/models/review_dto.dart';
import 'package:hairs_and_you/api/domain/entities/review.dart';
import 'package:hairs_and_you/api/domain/repositories/reviews_repository.dart';

class ReviewsRepositoryImpl implements ReviewsRepository {
  ReviewsRepositoryImpl({required this.apiService, required this.cacheManager});

  final ApiService apiService;
  final CacheManager cacheManager;

  @override
  Future<Either<Failure, List<Review>>> getReviews({required salonID}) async {
    try {
      final cachedData = await cacheManager.getData('reviews');
      if (cachedData != null) {
        return Right((cachedData as List)
            .map((e) => ReviewDto.fromJson(e).toDomain())
            .toList());
      }
      final response = await apiService.getReviews(salonID: salonID);
      final reviews = response.map((dto) => dto.toDomain()).toList();

      await cacheManager.saveData(
        "reviews",
        response.map((e) => e.toJson()).toList(),
      );

      return Right(reviews);
    } on DioException catch (e) {
      return Left(ServerFailure("API error: ${e.message}"));
    } catch (e) {
      return Left(ServerFailure('Unexpected error: $e'));
    }
  }
}
