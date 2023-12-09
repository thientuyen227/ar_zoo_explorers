import 'package:dartz/dartz.dart';

import '../../core/failures.dart';
import '../../core/success.dart';
import '../entities/animal_entity.dart';

abstract class AnimalRepository {
  Future<Either<Failure, Success<AnimalEntity>>> getAnimal(String animalId);
  Future<Either<Failure, Success<AnimalEntity>>> createAnimal(
      {required String title,
      required String icon,
      required String type,
      required String name});
  Future<Either<Failure, Success<AnimalEntity>>> updateAnimal(
      {required String id,
      required String title,
      required String icon,
      required String type,
      required String name});
}
