import 'package:dartz/dartz.dart';
import 'package:hairs_and_you/api/core/error/Failure.dart';
import 'package:hairs_and_you/api/domain/entities/service.dart';

abstract class ServicesRepository {
  Future<Either<Failure, List<Services>>> getServices({
    required String salonID,
  });
}
