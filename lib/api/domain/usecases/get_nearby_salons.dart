import 'package:dartz/dartz.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../core/error/failure.dart';
import '../entities/place.dart';
import '../repositories/place_repository.dart';

class GetNearbySalons {
  final PlaceRepository repository;

  GetNearbySalons(this.repository);

  Future<Either<Failure, List<Place>>> call(LatLng position) async {
    return await repository.getNearbySalons(position);
  }
}
