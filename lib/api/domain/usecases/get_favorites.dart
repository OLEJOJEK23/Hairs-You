import 'package:dartz/dartz.dart';
import 'package:hairs_and_you/api/core/error/Failure.dart';
import 'package:hairs_and_you/api/domain/entities/favorites.dart';
import 'package:hairs_and_you/api/domain/repositories/favorite_repository.dart';

class GetFavorites {
  final FavoriteRepository repository;

  GetFavorites(this.repository);

  Future<Either<Failure, Favorites>> call({
    required String userID,
  }) async {
    return await repository.getFavorites(userID: userID);
  }
}
