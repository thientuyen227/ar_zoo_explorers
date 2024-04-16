import 'package:ar_zoo_explorers/core/data/sources/firebase/firebase_firestore_source.dart';
import 'package:ar_zoo_explorers/core/failures.dart';
import 'package:ar_zoo_explorers/core/helpers/exception_handler.dart';
import 'package:ar_zoo_explorers/core/success.dart';
import 'package:ar_zoo_explorers/domain/entities/topic_entity.dart';
import 'package:ar_zoo_explorers/domain/repositories/topic_repository.dart';
import 'package:dartz/dartz.dart';

class TopicRepositoryImplement implements TopicRepository {
  final FirebaseFirestoreSource _firestoreSource = FirebaseFirestoreSource();
  @override
  Future<Either<Failure, Success<List<TopicEntity>>>> getAllTopics() {
    return ResponseHandler.processResponse(() async {
      return Success(
        data: await _firestoreSource.getAllTopicModels() ?? [],
      );
    });
  }

  @override
  Future<Either<Failure, Success<TopicEntity>>> getTopic(String id) {
    return ResponseHandler.processResponse(() async {
      return Success(
        data: await _firestoreSource.getTopicModel(id) ??
            TopicEntity(
                id: '', name: '', title: '', imageUrl: '', status: true),
      );
    });
  }
}
