import 'package:dartz/dartz.dart';
import 'package:hairs_and_you/api/core/error/Failure.dart';
import 'package:hairs_and_you/api/domain/entities/service.dart';
import 'package:hairs_and_you/api/domain/repositories/services_repository.dart';

class GetServices {
  final ServicesRepository repository;

  GetServices(this.repository);

  Future<Either<Failure, List<Services>>> call({
    required String salonID,
  }) async {
    return await repository.getServices(salonID: salonID);
  }
}
