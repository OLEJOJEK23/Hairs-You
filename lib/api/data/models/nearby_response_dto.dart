import 'package:json_annotation/json_annotation.dart';

import 'place_dto.dart';

part 'nearby_response_dto.g.dart';

@JsonSerializable()
class NearbyResponseDto {
  @JsonKey(name: 'results')
  final List<PlaceDto> results;

  NearbyResponseDto({required this.results});

  factory NearbyResponseDto.fromJson(Map<String, dynamic> json) =>
      _$NearbyResponseDtoFromJson(json);

  Map<String, dynamic> toJson() => _$NearbyResponseDtoToJson(this);
}
