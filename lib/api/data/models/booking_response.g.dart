// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'booking_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BookingResponseDto _$BookingResponseDtoFromJson(Map<String, dynamic> json) =>
    BookingResponseDto(
      success: json['success'] as bool,
      message: json['message'] as String?,
    );

Map<String, dynamic> _$BookingResponseDtoToJson(BookingResponseDto instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
    };
