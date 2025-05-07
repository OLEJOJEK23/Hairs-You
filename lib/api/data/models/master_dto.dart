import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/master.dart';

part 'master_dto.g.dart';

@JsonSerializable()
class MasterDto {
  MasterDto({
    required this.full_name,
    required this.description,
    required this.experience,
    required this.created_at,
    required this.id,
    required this.is_favorite,
    required this.photo_url,
  });

  final String full_name;
  final String? description;
  final String experience;
  final String id;
  final bool is_favorite;
  final String photo_url;
  final String created_at;

  factory MasterDto.fromJson(Map<String, dynamic> json) =>
      _$MasterDtoFromJson(json);

  Map<String, dynamic> toJson() => _$MasterDtoToJson(this);

  Master toDomain() => Master(
        fullName: full_name,
        description: description,
        experience: experience,
        createdAt: created_at,
        id: id,
        isFavorite: is_favorite,
        photoURL: photo_url,
      );
}
