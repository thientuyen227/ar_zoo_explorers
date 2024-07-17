import 'package:ar_zoo_explorers/core/failures.dart';
import 'package:ar_zoo_explorers/core/helpers/exception_handler.dart';
import 'package:ar_zoo_explorers/core/success.dart';
import 'package:ar_zoo_explorers/domain/entities/animal_entity.dart';
import 'package:ar_zoo_explorers/domain/repositories/animal_repository.dart';
import 'package:dartz/dartz.dart';

import '../data/sources/firebase/firebase_firestore_source.dart';

class AnimalRepositoryImplement implements AnimalRepository {
  final FirebaseFirestoreSource _firestoreSource = FirebaseFirestoreSource();

  @override
  Future<Either<Failure, Success<AnimalEntity>>> createAnimal({
    required Map<String, String> titles,
    required String icon,
    required String type,
    required String name,
    required String categoryId,
    required bool status,
  }) {
    return ResponseHandler.processResponse(() async {
      return Success(
          data: await _firestoreSource.createAnimal(AnimalEntity(
              id: await _firestoreSource.generateUniqueAnimalModelId,
              titles: titles,
              icon: icon,
              type: type,
              name: name,
              categoryId: categoryId,
              status: status)));
    });
  }

  @override
  Future<Either<Failure, Success<AnimalEntity>>> getAnimal(
      String animalModelId) {
    return ResponseHandler.processResponse(() async {
      return Success(data: await _firestoreSource.getAnimal(animalModelId));
    });
  }

  @override
  Future<Either<Failure, Success<AnimalEntity>>> updateAnimal({
    required String id,
    required Map<String, String> titles,
    required String icon,
    required String type,
    required String name,
    required String categoryId,
    required bool status,
  }) {
    return ResponseHandler.processResponse(() async {
      return Success(
          data: await _firestoreSource.updateAnimal(
              id: id,
              titles: titles,
              icon: icon,
              type: type,
              name: name,
              categoryId: categoryId,
              status: status));
    });
  }

  @override
  Future<Either<Failure, Success<List<AnimalEntity>>>> getAllAnimals() {
    return ResponseHandler.processResponse(() async {
      return Success(
        data: await _firestoreSource.getAllAnimals() ?? [],
      );
    });
  }
}
