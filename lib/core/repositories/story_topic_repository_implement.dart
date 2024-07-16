import 'package:ar_zoo_explorers/core/data/sources/firebase/firebase_firestore_source.dart';
import 'package:ar_zoo_explorers/core/failures.dart';
import 'package:ar_zoo_explorers/core/helpers/exception_handler.dart';
import 'package:ar_zoo_explorers/core/success.dart';
import 'package:ar_zoo_explorers/domain/entities/story_topic_entity.dart';
import 'package:ar_zoo_explorers/domain/repositories/story_topic_repository.dart';
import 'package:dartz/dartz.dart';

class StoryTopicRepositoryImplement implements StoryTopicRepository {
  final FirebaseFirestoreSource _firestoreSource = FirebaseFirestoreSource();
  @override
  Future<Either<Failure, Success<List<StoryTopicEntity>>>> getAllStoryTopics() {
    return ResponseHandler.processResponse(() async {
      return Success(
        data: await _firestoreSource.getAllStoryTopicModels() ?? [],
      );
    });
  }

  @override
  Future<Either<Failure, Success<StoryTopicEntity>>> getStoryTopic(String id) {
    return ResponseHandler.processResponse(() async {
      return Success(
        data: await _firestoreSource.getStoryTopicModel(id) ??
            StoryTopicEntity(
                id: '', name: '', title: {}, imageUrl: '', status: true),
      );
    });
  }
}
