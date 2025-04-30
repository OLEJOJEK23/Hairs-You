import 'package:dartz/dartz.dart';
import 'package:hairs_and_you/api/core/error/Failure.dart';
import 'package:hairs_and_you/api/domain/entities/shortSalon.dart';

import '../repositories/salons_repository.dart';

class GetShortSalons {
  final SalonsRepository repository;

  GetShortSalons(this.repository);

  Future<Either<Failure, List<ShortSalon>>> call({
    String? sortBy,
  }) async {
    return await repository.getShortSalons(sortBy: sortBy);
  }
}
