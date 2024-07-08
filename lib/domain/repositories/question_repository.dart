import 'package:ar_zoo_explorers/core/failures.dart';
import 'package:ar_zoo_explorers/core/success.dart';
import 'package:ar_zoo_explorers/domain/entities/question_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

abstract class QuestionRepository {
  Future<Either<Failure, Success<QuestionEntity?>>> getQuestion(
      BuildContext context, String learninglearningId);
  Future<Either<Failure, Success<List<QuestionEntity>?>>> getAllQuestion(
    BuildContext context,
  );
}
