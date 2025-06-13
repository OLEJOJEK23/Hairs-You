import 'package:dartz/dartz.dart';
import 'package:hairs_and_you/api/core/error/Failure.dart';
import 'package:hairs_and_you/api/domain/entities/photo.dart';
import 'package:hairs_and_you/api/domain/repositories/photos_repository.dart';

class GetPhotos {
  final PhotosRepository repository;

  GetPhotos(this.repository);

  Future<Either<Failure, List<Photo>>> call({
    required String entityType,
    required String entityID,
  }) async {
    return await repository.getPhotos(
        entityType: entityType, entityID: entityID);
  }
}
