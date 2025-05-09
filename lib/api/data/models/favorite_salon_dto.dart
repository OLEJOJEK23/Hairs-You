import 'package:hairs_and_you/api/domain/entities/favorite_salon.dart';
import 'package:json_annotation/json_annotation.dart';

part 'favorite_salon_dto.g.dart';

@JsonSerializable()
class FavoriteSalonDto {
  @JsonKey(defaultValue: '')
  final String salon_id;
  final String name;
  @JsonKey(name: 'street_address')
  final String streetAddress;
  @JsonKey(name: 'city_name')
  final String cityName;
  @JsonKey(name: 'photo_url')
  final String photoUrl;
  final double rating;

  FavoriteSalonDto({
    required this.salon_id,
    required this.name,
    required this.streetAddress,
    required this.cityName,
    required this.photoUrl,
    required this.rating,
  });

  factory FavoriteSalonDto.fromJson(Map<String, dynamic> json) {
    final dto = _$FavoriteSalonDtoFromJson(json);
    return dto;
  }

  Map<String, dynamic> toJson() => _$FavoriteSalonDtoToJson(this);

  FavoriteSalon toDomain() => FavoriteSalon(
        salonId: salon_id,
        name: name,
        streetAddress: streetAddress,
        cityName: cityName,
        photoURL: photoUrl,
        rating: rating,
      );
}
