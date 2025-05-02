import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/review.dart';

part 'review_dto.g.dart';

@JsonSerializable()
class ReviewDto {
  ReviewDto({
    required this.display_name,
    required this.text,
    required this.rating,
    required this.created_at,
  });

  final String display_name;
  final String text;
  final double rating;
  final String created_at;

  factory ReviewDto.fromJson(Map<String, dynamic> json) =>
      _$ReviewDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ReviewDtoToJson(this);

  Review toDomain() => Review(
        display_name: display_name,
        text: text,
        rating: rating,
        created_at: DateTime.parse(created_at),
      );
}
