import 'package:ar_zoo_explorers/core/data/models/user_animal_model.dart';
import 'package:ar_zoo_explorers/core/data/sources/firebase/firebase_firestore_source.dart';
import 'package:ar_zoo_explorers/core/failures.dart';
import 'package:ar_zoo_explorers/core/success.dart';
import 'package:ar_zoo_explorers/domain/entities/user_animal_entity.dart';
import 'package:dartz/dartz.dart';

import '../../domain/repositories/user_animal_repository.dart';
import '../helpers/exception_handler.dart';

class UserAnimalRepositoryImplement implements UserAnimalRepository {
  final FirebaseFirestoreSource _firestoreSource = FirebaseFirestoreSource();

  @override
  Future<Either<Failure, Success<UserAnimalEntity>>> createUserAnimal(
      {required String userId,
      required String modelId,
      required bool isLoved}) {
    return ResponseHandler.processResponse(() async {
      return Success(
          data: await _firestoreSource.createUserAnimal(UserAnimalModel(
                  id: '',
                  userId: userId,
                  modelId: modelId,
                  isLoved: isLoved)) ??
              UserAnimalEntity(
                  id: '', userId: '', modelId: '', isLoved: false));
    });
  }

  @override
  Future<Either<Failure, Success<UserAnimalEntity>>> getUserAnimal(String id) {
    return ResponseHandler.processResponse(() async {
      return Success(
        data: await _firestoreSource.getUserAnimal(id) ??
            UserAnimalEntity(id: '', userId: '', modelId: '', isLoved: false),
      );
    });
  }

  @override
  Future<Either<Failure, Success<UserAnimalEntity>>>
      getUserAnimalByUserIdAndModelId(String userId, String modelId) {
    return ResponseHandler.processResponse(() async {
      return Success(
        data: await _firestoreSource.getUserAnimalByUserIdAndModelId(
                userId, modelId) ??
            UserAnimalEntity(id: '', userId: '', modelId: '', isLoved: false),
      );
    });
  }

  @override
  Future<Either<Failure, Success<bool>>> getUserAnimalIsLoved(
      String userId, String modelId) {
    return ResponseHandler.processResponse(() async {
      return Success(
        data: await _firestoreSource.getUserAnimalIsLoved(userId, modelId) ??
            false,
      );
    });
  }

  @override
  Future<Either<Failure, Success<UserAnimalEntity>>> updateUserAnimal(
      {required String id,
      required String userId,
      required String modelId,
      required bool isLoved}) {
    return ResponseHandler.processResponse(() async {
      return Success(
        data: await _firestoreSource.updateUserAnimal(
                id: id, userId: userId, modelId: modelId, isLoved: isLoved) ??
            UserAnimalEntity(id: '', userId: '', modelId: '', isLoved: false),
      );
    });
  }
}
