import 'package:dartz/dartz.dart';
import 'package:hairs_and_you/api/core/error/Failure.dart';
import 'package:hairs_and_you/api/domain/repositories/users_repository.dart';

class AddBooking {
  final UsersRepository repository;

  AddBooking(this.repository);

  Future<Either<Failure, void>> call({
    required String userID,
    required String salonID,
    required String serviceID,
    required DateTime dateTime,
    required String masterID,
  }) async {
    return await repository.createBooking(
        userId: userID,
        salonId: salonID,
        serviceId: serviceID,
        bookingTime: dateTime,
        masterId: masterID);
  }
}
