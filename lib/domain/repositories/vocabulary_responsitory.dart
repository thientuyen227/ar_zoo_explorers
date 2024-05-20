import 'package:ar_zoo_explorers/core/failures.dart';
import 'package:ar_zoo_explorers/core/success.dart';
import 'package:ar_zoo_explorers/domain/entities/vocabulary_entity.dart';
import 'package:dartz/dartz.dart';

abstract class VocabularyRepository {
  Future<Either<Failure, Success<VocabularyEntity?>>> getVocabulary(
      String vocabularyId);
  Future<Either<Failure, Success<List<VocabularyEntity>?>>> getAllVocabulary();
}
