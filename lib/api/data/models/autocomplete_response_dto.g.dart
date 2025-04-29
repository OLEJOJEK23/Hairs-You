// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'autocomplete_response_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AutocompleteResponseDto _$AutocompleteResponseDtoFromJson(
        Map<String, dynamic> json) =>
    AutocompleteResponseDto(
      predictions: (json['predictions'] as List<dynamic>)
          .map((e) => PredictionDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AutocompleteResponseDtoToJson(
        AutocompleteResponseDto instance) =>
    <String, dynamic>{
      'predictions': instance.predictions,
    };

PredictionDto _$PredictionDtoFromJson(Map<String, dynamic> json) =>
    PredictionDto(
      description: json['description'] as String,
      placeId: json['place_id'] as String,
    );

Map<String, dynamic> _$PredictionDtoToJson(PredictionDto instance) =>
    <String, dynamic>{
      'description': instance.description,
      'place_id': instance.placeId,
    };
