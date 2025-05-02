import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/salon.dart';

part 'salon_dto.g.dart';

@JsonSerializable()
class SalonsDTO {
  SalonsDTO({
    required this.created_at,
    required this.name,
    required this.description,
    required this.street_address,
    required this.photo_url,
    required this.rating,
    required this.city_name,
    required this.start_time,
    required this.end_time,
  });

  final String name;
  final String description;
  final String street_address;
  final String photo_url;
  final double rating;
  final String city_name;
  final String created_at;
  final String start_time;
  final String end_time;

  factory SalonsDTO.fromJson(Map<String, dynamic> json) =>
      _$SalonsDTOFromJson(json);

  Map<String, dynamic> toJson() => _$SalonsDTOToJson(this);

  Salon toDomain() {
    TimeOfDay parseTime(String time) {
      final parts = time.split(":");
      return TimeOfDay(
        hour: int.parse(parts[0]),
        minute: int.parse(parts[1]),
      );
    }

    return Salon(
      name: name,
      description: description,
      streetAddress: street_address,
      photoURL: photo_url,
      rating: rating,
      cityName: city_name,
      startTime: parseTime(start_time),
      endTime: parseTime(end_time),
      createdAt: DateTime.parse(created_at),
    );
  }
}
