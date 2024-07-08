import 'package:ar_zoo_explorers/core/data/sources/firebase/firebase_firestore_source.dart';
import 'package:ar_zoo_explorers/core/failures.dart';
import 'package:ar_zoo_explorers/core/helpers/exception_handler.dart';
import 'package:ar_zoo_explorers/core/success.dart';
import 'package:ar_zoo_explorers/domain/entities/user_question_entity.dart';
import 'package:ar_zoo_explorers/domain/repositories/user_question_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/src/widgets/framework.dart';

class UserQuestionRepositoryImplement implements UserQuestionReposity {
  final FirebaseFirestoreSource _firestoreSource = FirebaseFirestoreSource();
  @override
  Future<Either<Failure, Success<UserQuestionEntity?>>>
      createOrGetQuestionByUser(
          BuildContext context, UserQuestionEntity userQuestionEntity) {
    return ResponseHandler.processResponse(() async {
      return Success(
          data: await _firestoreSource.createOrGetQuestionByUser(
              context,
              UserQuestionEntity(
                  id: '',
                  learningId: userQuestionEntity.learningId,
                  indexQuestion: userQuestionEntity.indexQuestion,
                  userId: userQuestionEntity.userId)));
    });
  }

  @override
  Future<Either<Failure, Success<List<UserQuestionEntity>?>>>
      getAllQuestionByUser(BuildContext context) {
    return ResponseHandler.processResponse(() async {
      return Success(
          data: await _firestoreSource.getAllQuestionByUser(context));
    });
  }

  @override
  Future<Either<Failure, Success<UserQuestionEntity?>>> getQuestionByUser(
      BuildContext context, String userId, String userQuestionId) {
    return ResponseHandler.processResponse(() async {
      return Success(
          data: await _firestoreSource.getQuestionByUser(
              context, userId, userQuestionId));
    });
  }

  @override
  Future<Either<Failure, Success<UserQuestionEntity?>>> updateQuestionByUser(
      BuildContext context, UserQuestionEntity userQuestionEntity) {
    return ResponseHandler.processResponse(() async {
      return Success(
          data: await _firestoreSource.updateQuestionByUser(
              context, userQuestionEntity));
    });
  }
}
