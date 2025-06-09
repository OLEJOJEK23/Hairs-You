import 'package:dartz/dartz.dart';
import 'package:hairs_and_you/api/core/error/Failure.dart';
import 'package:hairs_and_you/api/domain/repositories/favorite_repository.dart';

class AddFavoriteSalon {
  final FavoriteRepository repository;

  AddFavoriteSalon(this.repository);

  Future<Either<Failure, void>> call({
    required String userID,
    required String salonID,
  }) async {
    return await repository.addFavoriteSalon(userID: userID, salonID: salonID);
  }
}
