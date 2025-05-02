import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/shortSalon.dart';

part 'short_salons_dto.g.dart';

@JsonSerializable()
class ShortSalonsDTO {
  ShortSalonsDTO({
    required this.id,
    required this.name,
    required this.description,
    required this.street_address,
    required this.photo_url,
    required this.rating,
    required this.city_name,
  });

  final String id;
  final String name;
  final String description;
  final String street_address;
  final String photo_url;
  final double rating;
  final String city_name;

  factory ShortSalonsDTO.fromJson(Map<String, dynamic> json) =>
      _$ShortSalonsDTOFromJson(json);

  Map<String, dynamic> toJson() => _$ShortSalonsDTOToJson(this);

  ShortSalon toDomain() => ShortSalon(
      id: id,
      name: name,
      description: description,
      address: street_address,
      photoURL: photo_url,
      rating: rating,
      city_name: city_name);
}
