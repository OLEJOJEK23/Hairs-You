// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favorite_master_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FavoriteMasterDto _$FavoriteMasterDtoFromJson(Map<String, dynamic> json) =>
    FavoriteMasterDto(
      master_id: json['master_id'] as String? ?? '',
      name: json['name'] as String,
      description: json['description'] as String?,
      experience: json['experience'] as String,
      photoUrl: json['photo_url'] as String,
    );

Map<String, dynamic> _$FavoriteMasterDtoToJson(FavoriteMasterDto instance) =>
    <String, dynamic>{
      'master_id': instance.master_id,
      'name': instance.name,
      'description': instance.description,
      'experience': instance.experience,
      'photo_url': instance.photoUrl,
    };
