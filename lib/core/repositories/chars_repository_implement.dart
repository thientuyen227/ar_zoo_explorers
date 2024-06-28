import 'package:ar_zoo_explorers/core/data/sources/firebase/firebase_firestore_source.dart';
import 'package:ar_zoo_explorers/core/failures.dart';
import 'package:ar_zoo_explorers/core/helpers/exception_handler.dart';
import 'package:ar_zoo_explorers/core/success.dart';
import 'package:ar_zoo_explorers/domain/entities/chars_entity.dart';
import 'package:ar_zoo_explorers/domain/repositories/chars_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

class CharsRepositoryImplement implements CharsRepository {
  final FirebaseFirestoreSource _firestoreSource = FirebaseFirestoreSource();
  @override
  Future<Either<Failure, Success<CharsEntity?>>> getChars(
      BuildContext context, String charsId) {
    return ResponseHandler.processResponse(() async {
      return Success(data: await _firestoreSource.getChars(context, charsId));
    });
  }

  @override
  Future<Either<Failure, Success<List<CharsEntity>?>>> getAllChars(
    BuildContext context,
  ) {
    return ResponseHandler.processResponse(() async {
      return Success(data: await _firestoreSource.getAllChars(context));
    });
  }
}
