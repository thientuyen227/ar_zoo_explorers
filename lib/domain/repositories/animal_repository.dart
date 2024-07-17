import 'package:dartz/dartz.dart';

import '../../core/failures.dart';
import '../../core/success.dart';
import '../entities/animal_entity.dart';

abstract class AnimalRepository {
  Future<Either<Failure, Success<AnimalEntity>>> getAnimal(String animalId);
  Future<Either<Failure, Success<AnimalEntity>>> createAnimal({
    required Map<String, String> titles,
    required String icon,
    required String type,
    required String name,
    required String categoryId,
    required bool status,
  });
  Future<Either<Failure, Success<AnimalEntity>>> updateAnimal({
    required String id,
    required Map<String, String> titles,
    required String icon,
    required String type,
    required String name,
    required String categoryId,
    required bool status,
  });

  Future<Either<Failure, Success<List<AnimalEntity>>>> getAllAnimals();
}
