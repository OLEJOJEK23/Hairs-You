import 'package:dartz/dartz.dart';
import 'package:hairs_and_you/api/core/error/Failure.dart';
import 'package:hairs_and_you/api/domain/repositories/favorite_repository.dart';

class AddFavoriteMaster {
  final FavoriteRepository repository;

  AddFavoriteMaster(this.repository);

  Future<Either<Failure, void>> call({
    required String userID,
    required String masterID,
  }) async {
    return await repository.addFavoriteMaster(
        userID: userID, masterID: masterID);
  }
}
