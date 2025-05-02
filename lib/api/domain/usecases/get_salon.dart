import 'package:dartz/dartz.dart';
import 'package:hairs_and_you/api/core/error/Failure.dart';
import 'package:hairs_and_you/api/domain/entities/salon.dart';

import '../repositories/salons_repository.dart';

class GetSalons {
  final SalonsRepository repository;

  GetSalons(this.repository);

  Future<Either<Failure, List<Salon>>> call({
    String? salonID,
  }) async {
    return await repository.getSalons(salonID: salonID);
  }
}
