import 'package:ar_zoo_explorers/core/failures.dart';
import 'package:ar_zoo_explorers/core/success.dart';
import 'package:ar_zoo_explorers/domain/entities/animal_detail_entity.dart';
import 'package:dartz/dartz.dart';

import '../../domain/repositories/animal_detail_repository.dart';
import '../data/sources/firebase/firebase_firestore_source.dart';
import '../helpers/exception_handler.dart';

class AnimalDetailRepositoryImplement implements AnimalDetailRepository {
  final FirebaseFirestoreSource _firestoreSource = FirebaseFirestoreSource();

  @override
  Future<Either<Failure, Success<List<AnimalDetailEntity>>>>
      getAllAnimalDetails() {
    return ResponseHandler.processResponse(() async {
      return Success(
        data: await _firestoreSource.getAllAnimalDetails() ?? [],
      );
    });
  }

  @override
  Future<Either<Failure, Success<AnimalDetailEntity>>> getAnimalDetailModel(
      String id) {
    return ResponseHandler.processResponse(() async {
      return Success(
          data: await _firestoreSource.getAnimalDetailModel(id) ??
              AnimalDetailEntity(
                  id: id,
                  modelId: '',
                  description: '',
                  classification: '',
                  conservation: '',
                  reproduction: '',
                  culturalFigure: '',
                  views: 0));
    });
  }

  @override
  Future<Either<Failure, Success<AnimalDetailEntity>>>
      getAnimalDetailModelByModelId(String modelId) {
    return ResponseHandler.processResponse(() async {
      return Success(
          data: await _firestoreSource.getAnimalDetailModelByModelId(modelId) ??
              AnimalDetailEntity(
                  id: '',
                  modelId: '',
                  description: '',
                  classification: '',
                  conservation: '',
                  reproduction: '',
                  culturalFigure: '',
                  views: 0));
    });
  }

  @override
  Future<Either<Failure, Success<AnimalDetailEntity>>> updateViewAnimalDetail(
      {required String id, required int views}) {
    return ResponseHandler.processResponse(() async {
      return Success(
          data: await _firestoreSource.updateViewsAnimalDetail(
                  id: id, views: views) ??
              AnimalDetailEntity(
                  id: id,
                  modelId: '',
                  description: '',
                  classification: '',
                  conservation: '',
                  reproduction: '',
                  culturalFigure: '',
                  views: 0));
    });
  }
}
