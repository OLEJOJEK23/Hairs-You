import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/place.dart';

part 'place_dto.g.dart';

@JsonSerializable()
class PlaceDto {
  @JsonKey(name: 'place_id')
  final String id;
  final String name;
  @JsonKey(name: 'vicinity')
  final String? address;
  @JsonKey(name: 'geometry')
  final GeometryDto geometry;

  PlaceDto({
    required this.id,
    required this.name,
    this.address,
    required this.geometry,
  });

  factory PlaceDto.fromJson(Map<String, dynamic> json) =>
      _$PlaceDtoFromJson(json);

  Map<String, dynamic> toJson() => _$PlaceDtoToJson(this);

  Place toDomain() => Place(
        id: id,
        name: name,
        address: address ?? 'Адрес не указан',
        latitude: geometry.location.lat,
        longitude: geometry.location.lng,
      );
}

@JsonSerializable()
class GeometryDto {
  final LocationDto location;

  GeometryDto({required this.location});

  factory GeometryDto.fromJson(Map<String, dynamic> json) =>
      _$GeometryDtoFromJson(json);

  Map<String, dynamic> toJson() => _$GeometryDtoToJson(this);
}

@JsonSerializable()
class LocationDto {
  final double lat;
  final double lng;

  LocationDto({required this.lat, required this.lng});

  factory LocationDto.fromJson(Map<String, dynamic> json) =>
      _$LocationDtoFromJson(json);

  Map<String, dynamic> toJson() => _$LocationDtoToJson(this);
}
