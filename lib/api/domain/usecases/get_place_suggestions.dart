import 'package:dartz/dartz.dart';

import '../../core/error/failure.dart';
import '../entities/suggestion.dart';
import '../repositories/place_repository.dart';

class GetPlaceSuggestions {
  final PlaceRepository repository;

  GetPlaceSuggestions(this.repository);

  Future<Either<Failure, List<Suggestion>>> call(String input) async {
    return await repository.getPlaceSuggestions(input);
  }
}
