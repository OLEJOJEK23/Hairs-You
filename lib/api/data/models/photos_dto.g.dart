// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'photos_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PhotosDto _$PhotosDtoFromJson(Map<String, dynamic> json) => PhotosDto(
      is_primary: json['is_primary'] as bool,
      photo_path: json['photo_path'] as String,
    );

Map<String, dynamic> _$PhotosDtoToJson(PhotosDto instance) => <String, dynamic>{
      'is_primary': instance.is_primary,
      'photo_path': instance.photo_path,
    };
