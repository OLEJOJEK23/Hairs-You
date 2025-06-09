import 'package:dartz/dartz.dart';

import '../../core/error/Failure.dart';
import '../entities/favorites.dart';

abstract class FavoriteRepository {
  Future<Either<Failure, Favorites>> getFavorites({
    required String userID,
  });

  Future<Either<Failure, void>> addFavoriteMaster({
    required String userID,
    required String masterID,
  });

  Future<Either<Failure, void>> addFavoriteSalon({
    required String userID,
    required String salonID,
  });

  Future<Either<Failure, void>> deleteFavoriteMaster({
    required String userID,
    required String masterID,
  });

  Future<Either<Failure, void>> deleteFavoriteSalon({
    required String userID,
    required String salonID,
  });
}
