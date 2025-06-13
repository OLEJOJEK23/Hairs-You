import 'package:hairs_and_you/api/domain/entities/photo.dart';
import 'package:json_annotation/json_annotation.dart';

part 'photos_dto.g.dart';

@JsonSerializable()
class PhotosDto {
  PhotosDto({
    required this.is_primary,
    required this.photo_path,
  });

  final bool is_primary;
  final String photo_path;

  factory PhotosDto.fromJson(Map<String, dynamic> json) =>
      _$PhotosDtoFromJson(json);

  Map<String, dynamic> toJson() => _$PhotosDtoToJson(this);

  Photo toDomain() => Photo(
        isPrimary: is_primary,
        photoURL: photo_path,
      );
}
