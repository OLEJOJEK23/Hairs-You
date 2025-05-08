import 'package:dartz/dartz.dart';
import 'package:hairs_and_you/api/core/error/Failure.dart';
import 'package:hairs_and_you/api/domain/entities/user.dart';
import 'package:hairs_and_you/api/domain/repositories/users_repository.dart';

class GetUsers {
  final UsersRepository repository;

  GetUsers(this.repository);

  Future<Either<Failure, List<Users>>> call({required userID}) async {
    return await repository.getUsers(userID: userID);
  }
}
