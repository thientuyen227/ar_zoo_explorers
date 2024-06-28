import 'package:ar_zoo_explorers/core/data/sources/firebase/firebase_firestore_source.dart';
import 'package:ar_zoo_explorers/core/failures.dart';
import 'package:ar_zoo_explorers/core/helpers/exception_handler.dart';
import 'package:ar_zoo_explorers/core/success.dart';
import 'package:ar_zoo_explorers/domain/entities/question_entity.dart';
import 'package:ar_zoo_explorers/domain/repositories/question_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

class QuestionRepositoryImplement implements QuestionRepository {
  final FirebaseFirestoreSource _firestoreSource = FirebaseFirestoreSource();
  @override
  Future<Either<Failure, Success<QuestionEntity?>>> getQuestion(
      BuildContext context, String questionId) {
    return ResponseHandler.processResponse(() async {
      return Success(
          data: await _firestoreSource.getQuestion(context, questionId));
    });
  }

  @override
  Future<Either<Failure, Success<List<QuestionEntity>?>>> getAllQuestion(
    BuildContext context,
  ) {
    return ResponseHandler.processResponse(() async {
      return Success(data: await _firestoreSource.getAllQuestion(context));
    });
  }
}
