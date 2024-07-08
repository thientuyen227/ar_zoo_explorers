import 'package:ar_zoo_explorers/core/failures.dart';
import 'package:ar_zoo_explorers/core/success.dart';
import 'package:ar_zoo_explorers/domain/entities/writing_practice_user_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

abstract class WritingPracticeUserRepository {
  Future<Either<Failure, Success<WritingPracticeUserEntity?>>>
      getWritingPracticeUser(
          BuildContext context, String userId, String writingPracticeId);
  Future<Either<Failure, Success<List<WritingPracticeUserEntity>?>>>
      getAllWritingPracticeUser(BuildContext context);
  Future<Either<Failure, Success<WritingPracticeUserEntity?>>>
      updateWritingPracticeUser(BuildContext context,
          WritingPracticeUserEntity writingPracticeUserEntity);
  Future<Either<Failure, Success<WritingPracticeUserEntity?>>>
      createOrGetWritingPractice(BuildContext context,
          WritingPracticeUserEntity writingPracticeUserEntity);
  Future<Either<Failure, Success<String>>> uploadImageToFirebase(
      BuildContext context, Uint8List imageBytes, String imageName);
}
