// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'services_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ServicesDto _$ServicesDtoFromJson(Map<String, dynamic> json) => ServicesDto(
      service_name: json['service_name'] as String,
      id: json['id'] as String,
      duration: (json['duration'] as num).toInt(),
      price: (json['price'] as num).toDouble(),
    );

Map<String, dynamic> _$ServicesDtoToJson(ServicesDto instance) =>
    <String, dynamic>{
      'service_name': instance.service_name,
      'id': instance.id,
      'duration': instance.duration,
      'price': instance.price,
    };
