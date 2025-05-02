import 'package:dartz/dartz.dart';
import 'package:hairs_and_you/api/core/error/Failure.dart';
import 'package:hairs_and_you/api/domain/entities/review.dart';

abstract class ReviewsRepository {
  Future<Either<Failure, List<Review>>> getReviews({
    required String salonID,
  });
}
