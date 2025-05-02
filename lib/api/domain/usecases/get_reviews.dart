import 'package:dartz/dartz.dart';
import 'package:hairs_and_you/api/core/error/Failure.dart';
import 'package:hairs_and_you/api/domain/entities/review.dart';
import 'package:hairs_and_you/api/domain/repositories/reviews_repository.dart';

class GetReviews {
  final ReviewsRepository repository;

  GetReviews(this.repository);

  Future<Either<Failure, List<Review>>> call({
    required String salonID,
  }) async {
    return await repository.getReviews(salonID: salonID);
  }
}
