import 'package:ar_zoo_explorers/core/data/sources/firebase/firebase_firestore_source.dart';
import 'package:ar_zoo_explorers/core/failures.dart';
import 'package:ar_zoo_explorers/core/helpers/exception_handler.dart';
import 'package:ar_zoo_explorers/core/success.dart';
import 'package:ar_zoo_explorers/domain/entities/learning_category_entity.dart';
import 'package:ar_zoo_explorers/domain/repositories/learning_category_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

class LearningCategoryRepositoryImplement
    implements LearningCategoryRepository {
  final FirebaseFirestoreSource _firestoreSource = FirebaseFirestoreSource();
  @override
  Future<Either<Failure, Success<LearningCategoryEntity?>>> getLearningCategory(
      BuildContext context, String learninglearningId) {
    return ResponseHandler.processResponse(() async {
      return Success(
          data: await _firestoreSource.getLearningCategory(
              context, learninglearningId));
    });
  }

  @override
  Future<Either<Failure, Success<List<LearningCategoryEntity>?>>>
      getAllLearningCategory(
    BuildContext context,
  ) {
    return ResponseHandler.processResponse(() async {
      return Success(
          data: await _firestoreSource.getAllLearningCategory(context));
    });
  }
}
