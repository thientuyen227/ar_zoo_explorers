import 'package:ar_zoo_explorers/core/failures.dart';
import 'package:ar_zoo_explorers/core/success.dart';
import 'package:ar_zoo_explorers/domain/entities/vocabulary_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

abstract class VocabularyRepository {
  Future<Either<Failure, Success<VocabularyEntity?>>> getVocabulary(
      BuildContext context, String vocabularyId);
  Future<Either<Failure, Success<List<VocabularyEntity>?>>> getAllVocabulary(
    BuildContext context,
  );
}
