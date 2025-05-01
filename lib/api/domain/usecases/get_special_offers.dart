import 'package:dartz/dartz.dart';
import 'package:hairs_and_you/api/core/error/Failure.dart';
import 'package:hairs_and_you/api/domain/entities/special_offer.dart';

import '../repositories/salons_repository.dart';

class GetSpecialOffers {
  final SalonsRepository repository;

  GetSpecialOffers(this.repository);

  Future<Either<Failure, List<SpecialOffer>>> call() async {
    return await repository.getSpecialOffers();
  }
}
