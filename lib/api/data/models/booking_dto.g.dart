// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'booking_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BookingDto _$BookingDtoFromJson(Map<String, dynamic> json) => BookingDto(
      booking_time: json['booking_time'] as String,
      master_id: json['master_id'] as String,
      master_name: json['master_name'] as String,
      salon_address: json['salon_address'] as String,
      salon_id: json['salon_id'] as String,
      salon_name: json['salon_name'] as String,
      salons_city: json['salons_city'] as String,
      service_id: json['service_id'] as String,
      service_name: json['service_name'] as String,
      status: json['status'] as String,
    );

Map<String, dynamic> _$BookingDtoToJson(BookingDto instance) =>
    <String, dynamic>{
      'booking_time': instance.booking_time,
      'master_id': instance.master_id,
      'master_name': instance.master_name,
      'salon_address': instance.salon_address,
      'salon_id': instance.salon_id,
      'salon_name': instance.salon_name,
      'salons_city': instance.salons_city,
      'service_id': instance.service_id,
      'service_name': instance.service_name,
      'status': instance.status,
    };
