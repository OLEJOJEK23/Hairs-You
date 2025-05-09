// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favorite_salon_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FavoriteSalonDto _$FavoriteSalonDtoFromJson(Map<String, dynamic> json) =>
    FavoriteSalonDto(
      salon_id: json['salon_id'] as String? ?? '',
      name: json['name'] as String,
      streetAddress: json['street_address'] as String,
      cityName: json['city_name'] as String,
      photoUrl: json['photo_url'] as String,
      rating: (json['rating'] as num).toDouble(),
    );

Map<String, dynamic> _$FavoriteSalonDtoToJson(FavoriteSalonDto instance) =>
    <String, dynamic>{
      'salon_id': instance.salon_id,
      'name': instance.name,
      'street_address': instance.streetAddress,
      'city_name': instance.cityName,
      'photo_url': instance.photoUrl,
      'rating': instance.rating,
    };
