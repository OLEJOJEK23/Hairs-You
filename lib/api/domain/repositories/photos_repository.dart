import 'package:dartz/dartz.dart';
import 'package:hairs_and_you/api/core/error/Failure.dart';
import 'package:hairs_and_you/api/domain/entities/photo.dart';

abstract class PhotosRepository {
  Future<Either<Failure, List<Photo>>> getPhotos({
    required String entityType,
    required String entityID,
  });
}
