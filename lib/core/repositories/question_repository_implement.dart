import 'package:ar_zoo_explorers/core/data/sources/firebase/firebase_firestore_source.dart';
import 'package:ar_zoo_explorers/core/failures.dart';
import 'package:ar_zoo_explorers/core/helpers/exception_handler.dart';
import 'package:ar_zoo_explorers/core/success.dart';
import 'package:ar_zoo_explorers/domain/entities/question_entity.dart';
import 'package:ar_zoo_explorers/domain/repositories/question_repository.dart';
import 'package:dartz/dartz.dart';

class QuestionRepositoryImplement implements QuestionRepository {
  final FirebaseFirestoreSource _firestoreSource = FirebaseFirestoreSource();
  @override
  Future<Either<Failure, Success<QuestionEntity?>>> getQuestion(
      String questionId) {
    return ResponseHandler.processResponse(() async {
      return Success(data: await _firestoreSource.getQuestion(questionId));
    });
  }

  @override
  Future<Either<Failure, Success<List<QuestionEntity>?>>> getAllQuestion() {
    return ResponseHandler.processResponse(() async {
      return Success(data: await _firestoreSource.getAllQuestion());
    });
  }

  @override
  Future<Either<Failure, Success<bool>>> deleteQuestion(
      String questionEntityId) {
    return ResponseHandler.processResponse(() async {
      return Success(
          data: await _firestoreSource.deleteQuestion(questionEntityId));
    });
  }

  @override
  Future<Either<Failure, Success<QuestionEntity?>>> updateQuestion(
      QuestionEntity questionEntity) {
    return ResponseHandler.processResponse(() async {
      return Success(
          data: await _firestoreSource.updateQuestion(questionEntity));
    });
  }
}
