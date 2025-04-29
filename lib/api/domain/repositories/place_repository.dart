import 'package:dartz/dartz.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../core/error/failure.dart';
import '../entities/place.dart';

abstract class PlaceRepository {
  Future<Either<Failure, List<Place>>> getNearbySalons(LatLng position);
}
