// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'nearby_response_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NearbyResponseDto _$NearbyResponseDtoFromJson(Map<String, dynamic> json) =>
    NearbyResponseDto(
      results: (json['results'] as List<dynamic>)
          .map((e) => PlaceDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$NearbyResponseDtoToJson(NearbyResponseDto instance) =>
    <String, dynamic>{
      'results': instance.results,
    };
