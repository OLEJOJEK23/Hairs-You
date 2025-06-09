import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:hairs_and_you/api/core/error/Failure.dart';
import 'package:hairs_and_you/api/data/datasources/local/cache_manager.dart';
import 'package:hairs_and_you/api/data/datasources/remote/api_service.dart';
import 'package:hairs_and_you/api/data/models/salon_dto.dart';
import 'package:hairs_and_you/api/data/models/salons_types_dto.dart';
import 'package:hairs_and_you/api/data/models/special_offer_dto.dart';
import 'package:hairs_and_you/api/domain/entities/salon.dart';
import 'package:hairs_and_you/api/domain/entities/salonsTypes.dart';
import 'package:hairs_and_you/api/domain/entities/shortSalon.dart';
import 'package:hairs_and_you/api/domain/entities/special_offer.dart';

import '../../domain/repositories/salons_repository.dart';
import '../models/short_salons_dto.dart';

class SalonsRepositoryImpl implements SalonsRepository {
  SalonsRepositoryImpl({required this.apiService, required this.cacheManager});

  final ApiService apiService;
  final CacheManager cacheManager;

  @override
  Future<Either<Failure, List<ShortSalon>>> getShortSalons({
    String? sortBy,
  }) async {
    try {
      final cachedData = await cacheManager.getData('short_salons');
      if (cachedData != null) {
        return Right((cachedData as List)
            .map((e) => ShortSalonsDTO.fromJson(e).toDomain())
            .toList());
      }
      final response = await apiService.getShortSalons(location: sortBy);
      final shortSalons = response.map((dto) => dto.toDomain()).toList();

      await cacheManager.saveData(
        "short_salons",
        response.map((e) => e.toJson()).toList(),
      );

      return Right(shortSalons);
    } on DioException catch (e) {
      return Left(ServerFailure("API error: ${e.message}"));
    } catch (e) {
      return Left(ServerFailure('Unexpected error: $e'));
    }
  }

  @override
  Future<Either<Failure, List<SpecialOffer>>> getSpecialOffers() async {
    try {
      final cachedData = await cacheManager.getData('special_offers');
      if (cachedData != null) {
        return Right((cachedData as List)
            .map((e) => SpecialOfferDTO.fromJson(e).toDomain())
            .toList());
      }
      final response = await apiService.getSpecialOffers();
      final specialOffers = response.map((dto) => dto.toDomain()).toList();

      await cacheManager.saveData(
        "special_offers",
        response.map((e) => e.toJson()).toList(),
      );

      return Right(specialOffers);
    } on DioException catch (e) {
      return Left(ServerFailure("API error: ${e.message}"));
    } catch (e) {
      return Left(ServerFailure('Unexpected error: $e'));
    }
  }

  @override
  Future<Either<Failure, List<Salon>>> getSalons({
    String? salonID,
    String? userID,
  }) async {
    try {
      final cachedData = await cacheManager.getData('salons');
      if (cachedData != null) {
        return Right((cachedData as List)
            .map((e) => SalonsDTO.fromJson(e).toDomain())
            .toList());
      }
      final response =
          await apiService.getSalons(salonID: salonID, userID: userID);
      final salons = response.map((dto) => dto.toDomain()).toList();

      await cacheManager.saveData(
        "salons",
        response.map((e) => e.toJson()).toList(),
      );

      return Right(salons);
    } on DioException catch (e) {
      return Left(ServerFailure("API error: ${e.message}"));
    } catch (e) {
      return Left(ServerFailure('Unexpected error: $e'));
    }
  }

  @override
  Future<Either<Failure, List<SalonsTypes>>> getSalonsTypes() async {
    try {
      final cachedData = await cacheManager.getData('salons_types');
      if (cachedData != null) {
        return Right((cachedData as List)
            .map((e) => SalonsTypesDto.fromJson(e).toDomain())
            .toList());
      }
      final response = await apiService.getSalonsTypes();
      final salonsTypes = response.map((dto) => dto.toDomain()).toList();

      await cacheManager.saveData(
        "salons_types",
        response.map((e) => e.toJson()).toList(),
      );

      return Right(salonsTypes);
    } on DioException catch (e) {
      return Left(ServerFailure("API error: ${e.message}"));
    } catch (e) {
      return Left(ServerFailure('Unexpected error: $e'));
    }
  }
}
