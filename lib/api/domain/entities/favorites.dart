import 'package:hairs_and_you/api/domain/entities/favorite_master.dart';
import 'package:hairs_and_you/api/domain/entities/favorite_salon.dart';

class Favorites {
  final List<FavoriteMaster> favoriteMasters;
  final List<FavoriteSalon> favoriteSalons;

  Favorites({
    required this.favoriteMasters,
    required this.favoriteSalons,
  });
}
