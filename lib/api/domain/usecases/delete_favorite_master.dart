import 'package:dartz/dartz.dart';
import 'package:hairs_and_you/api/core/error/Failure.dart';
import 'package:hairs_and_you/api/domain/repositories/favorite_repository.dart';

class DeleteFavoriteMaster {
  final FavoriteRepository repository;

  DeleteFavoriteMaster(this.repository);

  Future<Either<Failure, void>> call({
    required String userID,
    required String masterID,
  }) async {
    return await repository.deleteFavoriteMaster(
        userID: userID, masterID: masterID);
  }
}
