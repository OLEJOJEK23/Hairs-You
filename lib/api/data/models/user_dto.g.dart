// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserDto _$UserDtoFromJson(Map<String, dynamic> json) => UserDto(
      display_name: json['display_name'] as String,
      email: json['email'] as String?,
      phone: json['phone'] as String?,
      created_at: json['created_at'] as String,
      photo_url: json['photo_url'] as String,
      rating: (json['rating'] as num).toDouble(),
    );

Map<String, dynamic> _$UserDtoToJson(UserDto instance) => <String, dynamic>{
      'display_name': instance.display_name,
      'email': instance.email,
      'phone': instance.phone,
      'photo_url': instance.photo_url,
      'created_at': instance.created_at,
      'rating': instance.rating,
    };
