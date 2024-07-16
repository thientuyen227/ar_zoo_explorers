import 'package:ar_zoo_explorers/core/failures.dart';
import 'package:ar_zoo_explorers/core/success.dart';
import 'package:ar_zoo_explorers/domain/entities/model_category_entity.dart';
import 'package:dartz/dartz.dart';

import '../../domain/repositories/model_category_repository.dart';
import '../data/sources/firebase/firebase_firestore_source.dart';
import '../helpers/exception_handler.dart';

class ModelCategoryRepositoryImplement implements ModelCategoryRepository {
  final FirebaseFirestoreSource _firestoreSource = FirebaseFirestoreSource();
  @override
  Future<Either<Failure, Success<List<ModelCategoryEntity>>>>
      getAllModelCategories() {
    return ResponseHandler.processResponse(() async {
      return Success(
        data: await _firestoreSource.getAllModelCategories() ?? [],
      );
    });
  }

  @override
  Future<Either<Failure, Success<ModelCategoryEntity>>> getModelCategory(
      String id) {
    return ResponseHandler.processResponse(() async {
      return Success(
        data: await _firestoreSource.getModelCategory(id) ??
            ModelCategoryEntity(
                id: '',
                name: '',
                title: {'vi': "", 'en': ""},
                imageUrl: '',
                status: true),
      );
    });
  }
}
