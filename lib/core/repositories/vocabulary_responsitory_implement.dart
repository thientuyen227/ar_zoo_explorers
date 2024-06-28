import 'package:ar_zoo_explorers/core/data/sources/firebase/firebase_firestore_source.dart';
import 'package:ar_zoo_explorers/core/failures.dart';
import 'package:ar_zoo_explorers/core/helpers/exception_handler.dart';
import 'package:ar_zoo_explorers/core/success.dart';
import 'package:ar_zoo_explorers/domain/entities/vocabulary_entity.dart';
import 'package:ar_zoo_explorers/domain/repositories/vocabulary_responsitory.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

class VocabularyRepositoryImplement implements VocabularyRepository {
  final FirebaseFirestoreSource _firestoreSource = FirebaseFirestoreSource();
  @override
  Future<Either<Failure, Success<VocabularyEntity?>>> getVocabulary(
      BuildContext context, String vocabularyId) {
    return ResponseHandler.processResponse(() async {
      return Success(
          data: await _firestoreSource.getVocabulary(context, vocabularyId));
    });
  }

  @override
  Future<Either<Failure, Success<List<VocabularyEntity>?>>> getAllVocabulary(
    BuildContext context,
  ) {
    return ResponseHandler.processResponse(() async {
      return Success(data: await _firestoreSource.getAllVocabulary(context));
    });
  }
}
