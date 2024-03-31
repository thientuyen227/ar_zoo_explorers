import 'package:dartz/dartz.dart';

import '../../core/failures.dart';
import '../../core/success.dart';
import '../entities/user_animal_entity.dart';

abstract class UserAnimalRepository {
  Future<Either<Failure, Success<UserAnimalEntity>>> getUserAnimal(String id);

  Future<Either<Failure, Success<UserAnimalEntity>>> createUserAnimal({
    required String userId,
    required String modelId,
    required bool isLoved,
  });

  Future<Either<Failure, Success<UserAnimalEntity>>> updateUserAnimal({
    required String id,
    required String userId,
    required String modelId,
    required bool isLoved,
  });

  Future<Either<Failure, Success<UserAnimalEntity>>>
      getUserAnimalByUserIdAndModelId(String userId, String modelId);

  Future<Either<Failure, Success<bool>>> getUserAnimalIsLoved(
      String userId, String modelId);
}
