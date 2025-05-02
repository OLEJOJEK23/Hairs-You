import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/special_offer.dart';

part 'special_offer_dto.g.dart';

@JsonSerializable()
class SpecialOfferDTO {
  SpecialOfferDTO({
    required this.id,
    required this.salon_id,
    required this.description,
    required this.photo_url,
    required this.title,
    required this.address,
    required this.city,
  });

  final String id;
  final String salon_id;
  final String description;
  final String photo_url;
  final String title;
  final String address;
  final String city;

  factory SpecialOfferDTO.fromJson(Map<String, dynamic> json) =>
      _$SpecialOfferDTOFromJson(json);

  Map<String, dynamic> toJson() => _$SpecialOfferDTOToJson(this);

  SpecialOffer toDomain() => SpecialOffer(
        id: id,
        salonID: salon_id,
        description: description,
        title: title,
        photoURL: photo_url,
        address: address,
        city: city,
      );
}
