import 'package:json_annotation/json_annotation.dart';

part 'autocomplete_response_dto.g.dart';

@JsonSerializable()
class AutocompleteResponseDto {
  @JsonKey(name: 'predictions')
  final List<PredictionDto> predictions;

  AutocompleteResponseDto({required this.predictions});

  factory AutocompleteResponseDto.fromJson(Map<String, dynamic> json) =>
      _$AutocompleteResponseDtoFromJson(json);

  Map<String, dynamic> toJson() => _$AutocompleteResponseDtoToJson(this);
}

@JsonSerializable()
class PredictionDto {
  final String description;
  @JsonKey(name: 'place_id')
  final String placeId;

  PredictionDto({required this.description, required this.placeId});

  factory PredictionDto.fromJson(Map<String, dynamic> json) =>
      _$PredictionDtoFromJson(json);

  Map<String, dynamic> toJson() => _$PredictionDtoToJson(this);
}
