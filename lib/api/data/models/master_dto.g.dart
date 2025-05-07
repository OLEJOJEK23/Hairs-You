// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'master_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MasterDto _$MasterDtoFromJson(Map<String, dynamic> json) => MasterDto(
      full_name: json['full_name'] as String,
      description: json['description'] as String?,
      experience: json['experience'] as String,
      created_at: json['created_at'] as String,
      id: json['id'] as String,
      is_favorite: json['is_favorite'] as bool,
      photo_url: json['photo_url'] as String,
    );

Map<String, dynamic> _$MasterDtoToJson(MasterDto instance) => <String, dynamic>{
      'full_name': instance.full_name,
      'description': instance.description,
      'experience': instance.experience,
      'id': instance.id,
      'is_favorite': instance.is_favorite,
      'photo_url': instance.photo_url,
      'created_at': instance.created_at,
    };
