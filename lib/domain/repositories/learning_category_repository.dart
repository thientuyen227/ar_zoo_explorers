import 'package:ar_zoo_explorers/core/failures.dart';
import 'package:ar_zoo_explorers/core/success.dart';
import 'package:ar_zoo_explorers/domain/entities/learning_category_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

abstract class LearningCategoryRepository {
  Future<Either<Failure, Success<LearningCategoryEntity?>>> getLearningCategory(
      BuildContext context, String learninglearningId);
  Future<Either<Failure, Success<List<LearningCategoryEntity>?>>>
      getAllLearningCategory(
    BuildContext context,
  );
}
