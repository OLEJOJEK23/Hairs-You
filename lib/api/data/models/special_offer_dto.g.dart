// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'special_offer_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SpecialOfferDTO _$SpecialOfferDTOFromJson(Map<String, dynamic> json) =>
    SpecialOfferDTO(
      id: json['id'] as String,
      salon_id: json['salon_id'] as String,
      description: json['description'] as String,
      photo_url: json['photo_url'] as String,
      title: json['title'] as String,
      address: json['address'] as String,
    );

Map<String, dynamic> _$SpecialOfferDTOToJson(SpecialOfferDTO instance) =>
    <String, dynamic>{
      'id': instance.id,
      'salon_id': instance.salon_id,
      'description': instance.description,
      'photo_url': instance.photo_url,
      'title': instance.title,
      'address': instance.address,
    };
