import 'package:ar_zoo_explorers/core/failures.dart';
import 'package:ar_zoo_explorers/core/success.dart';
import 'package:ar_zoo_explorers/domain/entities/question_entity.dart';
import 'package:dartz/dartz.dart';

abstract class QuestionRepository {
  Future<Either<Failure, Success<QuestionEntity?>>> getQuestion(
      String learningCategoryId);
  Future<Either<Failure, Success<List<QuestionEntity>?>>> getAllQuestion();
  Future<Either<Failure, Success<QuestionEntity?>>> updateQuestion(
      QuestionEntity learningCategoryEntity);
}
