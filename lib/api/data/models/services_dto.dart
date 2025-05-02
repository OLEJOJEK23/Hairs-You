import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/service.dart';

part 'services_dto.g.dart';

@JsonSerializable()
class ServicesDto {
  ServicesDto({
    required this.service_name,
    required this.id,
    required this.duration,
    required this.price,
  });

  final String service_name;
  final String id;
  final int duration;
  final double price;

  factory ServicesDto.fromJson(Map<String, dynamic> json) =>
      _$ServicesDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ServicesDtoToJson(this);

  Services toDomain() => Services(
        id: id,
        service_name: service_name,
        duration: duration,
        price: price,
      );
}
