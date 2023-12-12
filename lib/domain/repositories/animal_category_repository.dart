import 'package:dartz/dartz.dart';

import '../../core/failures.dart';
import '../../core/success.dart';
import '../entities/animal_category_entity.dart';

abstract class AnimalCategoryRepository {
  Future<Either<Failure, Success<AnimalCategoryEntity>>> getAnimalCategoryModel(
      String id);

  Future<Either<Failure, Success<List<AnimalCategoryEntity>>>>
      getAllAnimalCategories();
}
