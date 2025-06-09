// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'salon_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SalonsDTO _$SalonsDTOFromJson(Map<String, dynamic> json) => SalonsDTO(
      created_at: json['created_at'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      street_address: json['street_address'] as String,
      photo_url: json['photo_url'] as String,
      rating: (json['rating'] as num).toDouble(),
      city_name: json['city_name'] as String,
      start_time: json['start_time'] as String,
      end_time: json['end_time'] as String,
      is_favorite: json['is_favorite'] as bool,
    );

Map<String, dynamic> _$SalonsDTOToJson(SalonsDTO instance) => <String, dynamic>{
      'name': instance.name,
      'description': instance.description,
      'street_address': instance.street_address,
      'photo_url': instance.photo_url,
      'rating': instance.rating,
      'city_name': instance.city_name,
      'created_at': instance.created_at,
      'start_time': instance.start_time,
      'end_time': instance.end_time,
      'is_favorite': instance.is_favorite,
    };
