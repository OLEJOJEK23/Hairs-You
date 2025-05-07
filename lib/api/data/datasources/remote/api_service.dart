import 'package:dio/dio.dart';
import 'package:hairs_and_you/api/data/models/master_dto.dart';
import 'package:hairs_and_you/api/data/models/review_dto.dart';
import 'package:hairs_and_you/api/data/models/salon_dto.dart';
import 'package:hairs_and_you/api/data/models/salons_types_dto.dart';
import 'package:hairs_and_you/api/data/models/services_dto.dart';
import 'package:hairs_and_you/api/data/models/special_offer_dto.dart';
import 'package:retrofit/retrofit.dart';

import '../../../core/network/network_config.dart';
import '../../models/autocomplete_response_dto.dart';
import '../../models/nearby_response_dto.dart';
import '../../models/short_salons_dto.dart';
import 'endpoints.dart';

part 'api_service.g.dart';

@RestApi()
abstract class ApiService {
  factory ApiService(Dio dio, {String baseUrl}) = _ApiService;

  @GET(Endpoints.nearbySearch)
  Future<NearbyResponseDto> getNearbySalons({
    @Query('location') required String location,
    @Query('radius') int radius = 5000,
    @Query('type') String type = 'hair_care',
    @Query('language') String language = 'ru',
    @Query('key') String key = NetworkConfig.apiKey,
  });

  @GET(Endpoints.autocomplete)
  Future<AutocompleteResponseDto> getPlaceSuggestions({
    @Query('input') required String input,
    @Query('types') String types = 'address',
    @Query('language') String language = 'ru',
    @Query('key') String key = NetworkConfig.apiKey,
  });

  @GET(Endpoints.getShortSalons)
  Future<List<ShortSalonsDTO>> getShortSalons({
    @Query('sort_by') String? location,
  });

  @GET(Endpoints.getSpecialOffers)
  Future<List<SpecialOfferDTO>> getSpecialOffers();

  @GET(Endpoints.getReviews)
  Future<List<ReviewDto>> getReviews({
    @Query('salon_id') required String salonID,
  });

  @GET(Endpoints.getServices)
  Future<List<ServicesDto>> getServices({
    @Query('salon_id') required String salonID,
  });

  @GET(Endpoints.getSalons)
  Future<List<SalonsDTO>> getSalons({
    @Query('salon_id') String? salonID,
  });

  @GET(Endpoints.getSalonsTypes)
  Future<List<SalonsTypesDto>> getSalonsTypes();

  @GET(Endpoints.getMasters)
  Future<List<MasterDto>> getMasters({
    @Query('salon_id') String? salonID,
    @Query('user_id') String? userID,
  });
}
