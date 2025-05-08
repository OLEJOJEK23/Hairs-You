import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:hairs_and_you/api/core/error/Failure.dart';
import 'package:hairs_and_you/api/data/datasources/local/cache_manager.dart';
import 'package:hairs_and_you/api/data/datasources/remote/api_service.dart';
import 'package:hairs_and_you/api/data/models/user_dto.dart';
import 'package:hairs_and_you/api/domain/entities/user.dart';
import 'package:hairs_and_you/api/domain/repositories/users_repository.dart';

class UsersRepositoryImpl implements UsersRepository {
  UsersRepositoryImpl({required this.apiService, required this.cacheManager});

  final ApiService apiService;
  final CacheManager cacheManager;

  @override
  Future<Either<Failure, List<Users>>> getUsers(
      {required String userID}) async {
    try {
      final cachedData = await cacheManager.getData('users');
      if (cachedData != null) {
        return Right((cachedData as List)
            .map((e) => UserDto.fromJson(e).toDomain())
            .toList());
      }
      final response = await apiService.getUsers(userID: userID);
      final users = response.map((dto) => dto.toDomain()).toList();

      await cacheManager.saveData(
        "users",
        response.map((e) => e.toJson()).toList(),
      );

      return Right(users);
    } on DioException catch (e) {
      return Left(ServerFailure("API error: ${e.message}"));
    } catch (e) {
      return Left(ServerFailure('Unexpected error: $e'));
    }
  }
}
