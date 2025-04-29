// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'place_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PlaceDto _$PlaceDtoFromJson(Map<String, dynamic> json) => PlaceDto(
      id: json['place_id'] as String,
      name: json['name'] as String,
      address: json['vicinity'] as String?,
      geometry: GeometryDto.fromJson(json['geometry'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PlaceDtoToJson(PlaceDto instance) => <String, dynamic>{
      'place_id': instance.id,
      'name': instance.name,
      'vicinity': instance.address,
      'geometry': instance.geometry,
    };

GeometryDto _$GeometryDtoFromJson(Map<String, dynamic> json) => GeometryDto(
      location: LocationDto.fromJson(json['location'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$GeometryDtoToJson(GeometryDto instance) =>
    <String, dynamic>{
      'location': instance.location,
    };

LocationDto _$LocationDtoFromJson(Map<String, dynamic> json) => LocationDto(
      lat: (json['lat'] as num).toDouble(),
      lng: (json['lng'] as num).toDouble(),
    );

Map<String, dynamic> _$LocationDtoToJson(LocationDto instance) =>
    <String, dynamic>{
      'lat': instance.lat,
      'lng': instance.lng,
    };
