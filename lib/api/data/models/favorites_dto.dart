import 'package:hairs_and_you/api/data/models/favorite_master_dto.dart';
import 'package:hairs_and_you/api/data/models/favorite_salon_dto.dart';
import 'package:hairs_and_you/api/domain/entities/favorites.dart';
import 'package:json_annotation/json_annotation.dart';

part 'favorites_dto.g.dart';

@JsonSerializable()
class FavoritesDto {
  @JsonKey(name: 'favorite_masters', defaultValue: [])
  final List<FavoriteMasterDto> favoriteMasters;
  @JsonKey(name: 'favorite_salons', defaultValue: [])
  final List<FavoriteSalonDto> favoriteSalons;

  FavoritesDto({
    required this.favoriteMasters,
    required this.favoriteSalons,
  });

  factory FavoritesDto.fromJson(Map<String, dynamic> json) {
    final dto = _$FavoritesDtoFromJson(json);
    return dto;
  }

  Map<String, dynamic> toJson() => _$FavoritesDtoToJson(this);

  Favorites toDomain() {
    final favorites = Favorites(
      favoriteMasters: favoriteMasters.map((dto) => dto.toDomain()).toList(),
      favoriteSalons: favoriteSalons.map((dto) => dto.toDomain()).toList(),
    );
    
    return favorites;
  }
}
