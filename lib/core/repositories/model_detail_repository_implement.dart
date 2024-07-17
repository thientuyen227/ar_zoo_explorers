import 'package:ar_zoo_explorers/core/failures.dart';
import 'package:ar_zoo_explorers/core/success.dart';
import 'package:ar_zoo_explorers/domain/entities/model_detail_entity.dart';
import 'package:dartz/dartz.dart';

import '../../domain/repositories/model_detail_repository.dart';
import '../data/sources/firebase/firebase_firestore_source.dart';
import '../helpers/exception_handler.dart';

class ModelDetailRepositoryImplement implements ModelDetailRepository {
  final FirebaseFirestoreSource _firestoreSource = FirebaseFirestoreSource();

  @override
  Future<Either<Failure, Success<List<ModelDetailEntity>>>>
      getAllModelDetails() {
    return ResponseHandler.processResponse(() async {
      return Success(
        data: await _firestoreSource.getAllModelDetails() ?? [],
      );
    });
  }

  @override
  Future<Either<Failure, Success<ModelDetailEntity>>> getModelDetail(
      String id) {
    return ResponseHandler.processResponse(() async {
      return Success(
          data: await _firestoreSource.getModelDetail(id) ??
              ModelDetailEntity(
                id: id,
                modelId: '',
                description: {'en': '', 'vi': ''},
                classification: {'en': '', 'vi': ''},
                conservation: {'en': '', 'vi': ''},
                reproduction: {'en': '', 'vi': ''},
                culturalFigure: {'en': '', 'vi': ''},
                preservation: {'en': '', 'vi': ''},
                culturalSignificance: {'en': '', 'vi': ''},
                maintenance: {'en': '', 'vi': ''},
                manufacturing: {'en': '', 'vi': ''},
                educationalValue: {'en': '', 'vi': ''},
                views: 0,
              ));
    });
  }

  @override
  Future<Either<Failure, Success<ModelDetailEntity>>> getModelDetailByModelId(
      String modelId) {
    return ResponseHandler.processResponse(() async {
      return Success(
          data: await _firestoreSource.getModelDetailModelByModelId(modelId) ??
              ModelDetailEntity(
                id: '',
                modelId: '',
                description: {'en': '', 'vi': ''},
                classification: {'en': '', 'vi': ''},
                conservation: {'en': '', 'vi': ''},
                reproduction: {'en': '', 'vi': ''},
                culturalFigure: {'en': '', 'vi': ''},
                preservation: {'en': '', 'vi': ''},
                culturalSignificance: {'en': '', 'vi': ''},
                maintenance: {'en': '', 'vi': ''},
                manufacturing: {'en': '', 'vi': ''},
                educationalValue: {'en': '', 'vi': ''},
                views: 0,
              ));
    });
  }

  @override
  Future<Either<Failure, Success<ModelDetailEntity>>> updateViewModelDetail(
      {required String id, required int views}) {
    return ResponseHandler.processResponse(() async {
      return Success(
          data: await _firestoreSource.updateViewsModelDetail(
                  id: id, views: views) ??
              ModelDetailEntity(
                id: id,
                modelId: '',
                description: {'en': '', 'vi': ''},
                classification: {'en': '', 'vi': ''},
                conservation: {'en': '', 'vi': ''},
                reproduction: {'en': '', 'vi': ''},
                culturalFigure: {'en': '', 'vi': ''},
                preservation: {'en': '', 'vi': ''},
                culturalSignificance: {'en': '', 'vi': ''},
                maintenance: {'en': '', 'vi': ''},
                manufacturing: {'en': '', 'vi': ''},
                educationalValue: {'en': '', 'vi': ''},
                views: 0,
              ));
    });
  }
}
