// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'review_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReviewDto _$ReviewDtoFromJson(Map<String, dynamic> json) => ReviewDto(
      display_name: json['display_name'] as String,
      text: json['text'] as String,
      rating: (json['rating'] as num).toDouble(),
      created_at: json['created_at'] as String,
    );

Map<String, dynamic> _$ReviewDtoToJson(ReviewDto instance) => <String, dynamic>{
      'display_name': instance.display_name,
      'text': instance.text,
      'rating': instance.rating,
      'created_at': instance.created_at,
    };
