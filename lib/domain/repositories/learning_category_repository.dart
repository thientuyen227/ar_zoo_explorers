import 'package:ar_zoo_explorers/core/failures.dart';
import 'package:ar_zoo_explorers/core/success.dart';
import 'package:ar_zoo_explorers/domain/entities/learning_category_entity.dart';
import 'package:dartz/dartz.dart';

abstract class LearningCategoryRepository {
  Future<Either<Failure, Success<LearningCategoryEntity?>>> getLearningCategory(
      String learningCategoryId);
  Future<Either<Failure, Success<List<LearningCategoryEntity>?>>>
      getAllLearningCategory();
}
