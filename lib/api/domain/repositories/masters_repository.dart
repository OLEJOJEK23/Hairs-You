import 'package:dartz/dartz.dart';
import 'package:hairs_and_you/api/core/error/Failure.dart';
import 'package:hairs_and_you/api/domain/entities/master.dart';

abstract class MastersRepository {
  Future<Either<Failure, List<Master>>> getMasters({
    String? salonID,
    String? userID,
  });
}
