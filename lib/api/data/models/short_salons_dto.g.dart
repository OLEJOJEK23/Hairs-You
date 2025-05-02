// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'short_salons_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ShortSalonsDTO _$ShortSalonsDTOFromJson(Map<String, dynamic> json) =>
    ShortSalonsDTO(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      street_address: json['street_address'] as String,
      photo_url: json['photo_url'] as String,
      rating: (json['rating'] as num).toDouble(),
      city_name: json['city_name'] as String,
    );

Map<String, dynamic> _$ShortSalonsDTOToJson(ShortSalonsDTO instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'street_address': instance.street_address,
      'photo_url': instance.photo_url,
      'rating': instance.rating,
      'city_name': instance.city_name
    };
