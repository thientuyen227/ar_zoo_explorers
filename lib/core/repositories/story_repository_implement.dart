import 'package:ar_zoo_explorers/core/data/models/story_model.dart';
import 'package:ar_zoo_explorers/core/data/sources/firebase/firebase_firestore_source.dart';
import 'package:ar_zoo_explorers/core/failures.dart';
import 'package:ar_zoo_explorers/core/helpers/exception_handler.dart';
import 'package:ar_zoo_explorers/core/success.dart';
import 'package:ar_zoo_explorers/domain/entities/story_entity.dart';
import 'package:ar_zoo_explorers/domain/repositories/story_repository.dart';
import 'package:cloud_firestore_platform_interface/src/timestamp.dart';
import 'package:dartz/dartz.dart';

class StoryRepositoryImplement implements StoryRepository {
  final FirebaseFirestoreSource _firestoreSource = FirebaseFirestoreSource();

  @override
  Future<Either<Failure, Success<StoryEntity>>> createStory(
      {required String author,
      required String avatar,
      required String content,
      required int duration,
      required int listenCount,
      required List<String> modelId,
      required String name,
      required String overView,
      required String reader,
      required Timestamp releaseDate,
      required String sourceUrl,
      required bool status,
      required String title,
      required List<String> topicId}) {
    return ResponseHandler.processResponse(() async {
      return Success(
          data: await _firestoreSource.createStory(StoryModel(
                  id: '',
                  author: author,
                  avatar: avatar,
                  content: content,
                  duration: duration,
                  listenCount: listenCount,
                  modelId: modelId,
                  name: name,
                  overView: overView,
                  reader: reader,
                  releaseDate: releaseDate,
                  sourceUrl: sourceUrl,
                  status: status,
                  title: title,
                  topicId: topicId)) ??
              StoryModel(
                  id: '',
                  author: '',
                  avatar: '',
                  content: '',
                  duration: 0,
                  listenCount: 0,
                  modelId: [],
                  name: '',
                  overView: overView,
                  reader: '',
                  releaseDate: Timestamp.now(),
                  sourceUrl: '',
                  status: true,
                  title: '',
                  topicId: []),
          message: "Get data successfully!");
    });
  }

  @override
  Future<Either<Failure, Success<List<StoryEntity>>>> getAllStories() {
    return ResponseHandler.processResponse(() async {
      return Success(data: await _firestoreSource.getAllStoryModels() ?? []);
    });
  }

  @override
  Future<Either<Failure, Success<List<StoryEntity>>>> getStoriesByModelId(
      String modelId) {
    return ResponseHandler.processResponse(() async {
      return Success(
          data: await _firestoreSource.getStoryModelsByAnimalModelId(modelId) ??
              []);
    });
  }

  @override
  Future<Either<Failure, Success<List<StoryEntity>>>> getStoriesByTopicId(
      String topicId) {
    return ResponseHandler.processResponse(() async {
      return Success(
          data: await _firestoreSource.getStoryModelsByStoryTopicId(topicId) ??
              []);
    });
  }

  @override
  Future<Either<Failure, Success<StoryEntity>>> getStory(String id) {
    return ResponseHandler.processResponse(() async {
      return Success(
          data: await _firestoreSource.getStoryModel(id) ??
              StoryModel(
                  id: '',
                  author: '',
                  avatar: '',
                  content: '',
                  duration: 0,
                  listenCount: 0,
                  modelId: [],
                  name: '',
                  overView: '',
                  reader: '',
                  releaseDate: Timestamp.now(),
                  sourceUrl: '',
                  status: true,
                  title: '',
                  topicId: []));
    });
  }

  @override
  Future<Either<Failure, Success<StoryEntity>>> updateListenCount(
      String id, int count) {
    return ResponseHandler.processResponse(() async {
      return Success(
          data: await _firestoreSource.updateListenCountStory(
                  id: id, listenCount: count) ??
              StoryModel(
                  id: '',
                  author: '',
                  avatar: '',
                  content: '',
                  duration: 0,
                  listenCount: 0,
                  modelId: [],
                  name: '',
                  overView: '',
                  reader: '',
                  releaseDate: Timestamp.now(),
                  sourceUrl: '',
                  status: true,
                  title: '',
                  topicId: []));
    });
  }

  @override
  Future<Either<Failure, Success<StoryEntity>>> updateStory(
      {required String id,
      required String author,
      required String avatar,
      required String content,
      required int duration,
      required int listenCount,
      required List<String> modelId,
      required String name,
      required String overView,
      required String reader,
      required Timestamp releaseDate,
      required String sourceUrl,
      required bool status,
      required String title,
      required List<String> topicId}) {
    return ResponseHandler.processResponse(() async {
      return Success(
          data: await _firestoreSource.updateStory(
                  id: id,
                  author: author,
                  avatar: avatar,
                  content: content,
                  duration: duration,
                  listenCount: listenCount,
                  modelId: modelId,
                  name: name,
                  overView: overView,
                  reader: reader,
                  releaseDate: releaseDate,
                  sourceUrl: sourceUrl,
                  status: status,
                  title: title,
                  topicId: topicId) ??
              StoryModel(
                  id: '',
                  author: '',
                  avatar: '',
                  content: '',
                  duration: 0,
                  listenCount: 0,
                  modelId: [],
                  name: '',
                  overView: '',
                  reader: '',
                  releaseDate: Timestamp.now(),
                  sourceUrl: '',
                  status: true,
                  title: '',
                  topicId: []));
    });
  }

  @override
  Future<Either<Failure, Success<List<StoryEntity>>>> getStoriesByReleaseDate(
      bool isDec) {
    return ResponseHandler.processResponse(() async {
      return Success(
          data: await _firestoreSource.getAllStoryModelsByReleaseDate(isDec) ??
              []);
    });
  }
}
