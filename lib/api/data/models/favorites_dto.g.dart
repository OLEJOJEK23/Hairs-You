// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favorites_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FavoritesDto _$FavoritesDtoFromJson(Map<String, dynamic> json) => FavoritesDto(
      favoriteMasters: (json['favorite_masters'] as List<dynamic>?)
              ?.map(
                  (e) => FavoriteMasterDto.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      favoriteSalons: (json['favorite_salons'] as List<dynamic>?)
              ?.map((e) => FavoriteSalonDto.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$FavoritesDtoToJson(FavoritesDto instance) =>
    <String, dynamic>{
      'favorite_masters': instance.favoriteMasters,
      'favorite_salons': instance.favoriteSalons,
    };
