import 'package:dartz/dartz.dart';
import 'package:hairs_and_you/api/core/error/Failure.dart';
import 'package:hairs_and_you/api/domain/entities/shortSalon.dart';
import 'package:hairs_and_you/api/domain/entities/special_offer.dart';

abstract class SalonsRepository {
  Future<Either<Failure, List<ShortSalon>>> getShortSalons({
    String? sortBy,
  });

  Future<Either<Failure, List<SpecialOffer>>> getSpecialOffers();
}
