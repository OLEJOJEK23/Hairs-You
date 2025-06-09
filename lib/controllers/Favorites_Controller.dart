import 'package:get_it/get_it.dart';
import 'package:hairs_and_you/api/domain/usecases/add_favorite_master.dart';
import 'package:hairs_and_you/api/domain/usecases/add_favorite_salon.dart';
import 'package:hairs_and_you/api/domain/usecases/delete_favorite_master.dart';
import 'package:hairs_and_you/api/domain/usecases/delete_favorite_salon.dart';

class FavoritesController {
  static final AddFavoriteMaster _addFavoriteMaster =
      GetIt.I<AddFavoriteMaster>();
  static final AddFavoriteSalon _addFavoriteSalon = GetIt.I<AddFavoriteSalon>();
  static final DeleteFavoriteMaster _deleteFavoriteMaster =
      GetIt.I<DeleteFavoriteMaster>();
  static final DeleteFavoriteSalon _deleteFavoriteSalon =
      GetIt.I<DeleteFavoriteSalon>();

  Future<void> addFavoriteMaster(String userID, String masterID) async {
    await _addFavoriteMaster(masterID: masterID, userID: userID);
  }

  Future<void> addFavoriteSalon(String userID, String salonID) async {
    await _addFavoriteSalon(salonID: salonID, userID: userID);
  }

  Future<void> removeFavoriteMaster(String userID, String masterID) async {
    await _deleteFavoriteMaster(masterID: masterID, userID: userID);
  }

  Future<void> removeFavoriteSalon(String userID, String salonID) async {
    await _deleteFavoriteSalon(salonID: salonID, userID: userID);
  }
}
