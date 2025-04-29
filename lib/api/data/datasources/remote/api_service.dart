import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../../core/network/network_config.dart';
import '../../models/autocomplete_response_dto.dart';
import '../../models/nearby_response_dto.dart';
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
}
