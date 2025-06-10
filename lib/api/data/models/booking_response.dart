import 'package:json_annotation/json_annotation.dart';

part 'booking_response.g.dart';

@JsonSerializable()
class BookingResponseDto {
  final bool success;
  final String? message;

  BookingResponseDto({
    required this.success,
    this.message,
  });

  factory BookingResponseDto.fromJson(Map<String, dynamic> json) =>
      _$BookingResponseDtoFromJson(json);

  Map<String, dynamic> toJson() => _$BookingResponseDtoToJson(this);
}
