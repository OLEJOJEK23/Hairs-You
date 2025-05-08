import 'package:dartz/dartz.dart';
import 'package:hairs_and_you/api/core/error/Failure.dart';
import 'package:hairs_and_you/api/domain/entities/user.dart';

abstract class UsersRepository {
  Future<Either<Failure, List<Users>>> getUsers({
    required String userID,
  });
}
