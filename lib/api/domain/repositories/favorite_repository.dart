import 'package:dartz/dartz.dart';

import '../../core/error/Failure.dart';
import '../entities/favorites.dart';

abstract class FavoriteRepository {
  Future<Either<Failure, Favorites>> getFavorites({
    required String userID,
  });
}
