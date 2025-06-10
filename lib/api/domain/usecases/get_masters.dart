import 'package:dartz/dartz.dart';
import 'package:hairs_and_you/api/core/error/Failure.dart';
import 'package:hairs_and_you/api/domain/entities/master.dart';
import 'package:hairs_and_you/api/domain/repositories/masters_repository.dart';

class GetMasters {
  final MastersRepository repository;

  GetMasters(this.repository);

  Future<Either<Failure, List<Master>>> call({
    String? salonID,
    String? userID,
    String? masterID,
  }) async {
    return await repository.getMasters(
        salonID: salonID, userID: userID, masterID: masterID);
  }
}
