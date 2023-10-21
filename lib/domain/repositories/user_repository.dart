import 'package:ar_zoo_explorers/core/failures.dart';
import 'package:ar_zoo_explorers/core/success.dart';
import 'package:ar_zoo_explorers/domain/entities/user_entity.dart';
import 'package:dartz/dartz.dart';

abstract class AuthRepository {
  Future<Either<Failure, Success<UserEntity>>> signUp({
    required String fullname,
    required String email,
    required String password,
  });

  Future<Either<Failure, Success<UserEntity>>> login(
      {required String email, required String password});

  Future<Either<Failure, Success<UserEntity>>> loginWithGoogle();

  Future<Either<Failure, Success<UserEntity>>> loginWithFacebook();

  Future<Either<Failure, Success>> logout();
}
