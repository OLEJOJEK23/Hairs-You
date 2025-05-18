import 'package:dartz/dartz.dart';
import 'package:hairs_and_you/api/core/error/Failure.dart';
import 'package:hairs_and_you/api/domain/entities/booking.dart';
import 'package:hairs_and_you/api/domain/repositories/users_repository.dart';

class GetBookings {
  final UsersRepository repository;

  GetBookings(this.repository);

  Future<Either<Failure, List<Booking>>> call({
    required String userID,
    String? status,
  }) async {
    return await repository.getBookings(userID: userID, status: status);
  }
}
