import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/salonsTypes.dart';

part 'salons_types_dto.g.dart';

@JsonSerializable()
class SalonsTypesDto {
  SalonsTypesDto({
    required this.type_name,
    required this.id,
  });

  final String type_name;
  final int id;

  factory SalonsTypesDto.fromJson(Map<String, dynamic> json) =>
      _$SalonsTypesDtoFromJson(json);

  Map<String, dynamic> toJson() => _$SalonsTypesDtoToJson(this);

  SalonsTypes toDomain() => SalonsTypes(
        type: type_name,
        id: id,
      );
}
