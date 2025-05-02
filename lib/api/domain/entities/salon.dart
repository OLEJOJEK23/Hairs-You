import 'package:flutter/material.dart';

class Salon {
  Salon({
    required this.createdAt,
    required this.name,
    required this.description,
    required this.streetAddress,
    required this.photoURL,
    required this.rating,
    required this.cityName,
    required this.startTime,
    required this.endTime,
  });

  final String name;
  final String description;
  final String streetAddress;
  final String photoURL;
  final double rating;
  final String cityName;
  final DateTime createdAt;
  final TimeOfDay startTime;
  final TimeOfDay endTime;
}
