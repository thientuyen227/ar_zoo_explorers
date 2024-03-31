import 'package:ar_zoo_explorers/core/failures.dart';
import 'package:ar_zoo_explorers/core/success.dart';
import 'package:ar_zoo_explorers/domain/entities/animal_category_entity.dart';
import 'package:dartz/dartz.dart';

import '../../domain/repositories/animal_category_repository.dart';
import '../data/sources/firebase/firebase_firestore_source.dart';
import '../helpers/exception_handler.dart';

class AnimalCategoryRepositoryImplement implements AnimalCategoryRepository {
  final FirebaseFirestoreSource _firestoreSource = FirebaseFirestoreSource();
  @override
  Future<Either<Failure, Success<List<AnimalCategoryEntity>>>>
      getAllAnimalCategories() {
    return ResponseHandler.processResponse(() async {
      return Success(
        data: await _firestoreSource.getAllAnimalCategories() ?? [],
      );
    });
  }

  @override
  Future<Either<Failure, Success<AnimalCategoryEntity>>> getAnimalCategoryModel(
      String id) {
    return ResponseHandler.processResponse(() async {
      return Success(
        data: await _firestoreSource.getAnimalCategoryModel(id) ??
            AnimalCategoryEntity(
                id: '', name: '', title: '', imageUrl: '', status: true),
      );
    });
  }
}
