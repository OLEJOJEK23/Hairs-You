// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'salons_types_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SalonsTypesDto _$SalonsTypesDtoFromJson(Map<String, dynamic> json) =>
    SalonsTypesDto(
      type_name: json['type_name'] as String,
      id: (json['id'] as num).toInt(),
    );

Map<String, dynamic> _$SalonsTypesDtoToJson(SalonsTypesDto instance) =>
    <String, dynamic>{
      'type_name': instance.type_name,
      'id': instance.id,
    };
