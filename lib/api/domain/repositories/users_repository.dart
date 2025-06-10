import 'package:dartz/dartz.dart';
import 'package:hairs_and_you/api/core/error/Failure.dart';
import 'package:hairs_and_you/api/domain/entities/booking.dart';
import 'package:hairs_and_you/api/domain/entities/user.dart';

abstract class UsersRepository {
  Future<Either<Failure, List<Users>>> getUsers({
    required String userID,
  });

  Future<Either<Failure, List<Booking>>> getBookings({
    required String userID,
    String? status,
  });

  Future<Either<Failure, void>> createBooking({
    required String userId,
    required String salonId,
    required String serviceId,
    required DateTime bookingTime,
    required String masterId,
  });
}
