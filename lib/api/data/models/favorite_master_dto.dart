import 'package:hairs_and_you/api/domain/entities/favorite_master.dart';
import 'package:json_annotation/json_annotation.dart';

part 'favorite_master_dto.g.dart';

@JsonSerializable()
class FavoriteMasterDto {
  @JsonKey(defaultValue: '')
  final String master_id;
  final String name;
  final String? description;
  final String experience;
  @JsonKey(name: 'photo_url')
  final String photoUrl;

  FavoriteMasterDto({
    required this.master_id,
    required this.name,
    this.description,
    required this.experience,
    required this.photoUrl,
  });

  factory FavoriteMasterDto.fromJson(Map<String, dynamic> json) {
    final dto = _$FavoriteMasterDtoFromJson(json);
    return dto;
  }

  Map<String, dynamic> toJson() => _$FavoriteMasterDtoToJson(this);

  FavoriteMaster toDomain() => FavoriteMaster(
        masterID: master_id,
        name: name,
        description: description ?? 'нет описания',
        experience: experience,
        photoURL: photoUrl,
      );
}
