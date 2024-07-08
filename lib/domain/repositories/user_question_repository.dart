import 'package:ar_zoo_explorers/core/failures.dart';
import 'package:ar_zoo_explorers/core/success.dart';
import 'package:ar_zoo_explorers/domain/entities/user_question_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

abstract class UserQuestionReposity {
  Future<Either<Failure, Success<UserQuestionEntity?>>> getQuestionByUser(
      BuildContext context, String userId, String userQuestionId);
  Future<Either<Failure, Success<List<UserQuestionEntity>?>>>
      getAllQuestionByUser(BuildContext context);
  Future<Either<Failure, Success<UserQuestionEntity?>>> updateQuestionByUser(
      BuildContext context, UserQuestionEntity userQuestionEntity);
  Future<Either<Failure, Success<UserQuestionEntity?>>>
      createOrGetQuestionByUser(
          BuildContext context, UserQuestionEntity userQuestionEntity);
}
