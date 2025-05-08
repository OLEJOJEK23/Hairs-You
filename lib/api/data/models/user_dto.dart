import 'package:hairs_and_you/api/domain/entities/user.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_dto.g.dart';

@JsonSerializable()
class UserDto {
  UserDto({
    required this.display_name,
    required this.email,
    required this.phone,
    required this.created_at,
    required this.photo_url,
    required this.rating,
  });

  final String display_name;
  final String? email;
  final String? phone;
  final String photo_url;
  final String created_at;
  final double rating;

  factory UserDto.fromJson(Map<String, dynamic> json) =>
      _$UserDtoFromJson(json);

  Map<String, dynamic> toJson() => _$UserDtoToJson(this);

  Users toDomain() => Users(
        displayName: display_name,
        email: email,
        phone: phone,
        createdAt: created_at,
        photoURL: photo_url,
        rating: rating,
      );
}
