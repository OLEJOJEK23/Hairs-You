import 'package:dartz/dartz.dart';
import 'package:hairs_and_you/api/core/error/Failure.dart';
import 'package:hairs_and_you/api/domain/entities/salonsTypes.dart';
import 'package:hairs_and_you/api/domain/repositories/salons_repository.dart';

class GetSalonsTypes {
  final SalonsRepository repository;

  GetSalonsTypes(this.repository);

  Future<Either<Failure, List<SalonsTypes>>> call() async {
    return await repository.getSalonsTypes();
  }
}
