import 'package:ar_zoo_explorers/core/failures.dart';
import 'package:ar_zoo_explorers/core/success.dart';
import 'package:ar_zoo_explorers/domain/entities/story_entity.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';

abstract class StoryRepository {
  Future<Either<Failure, Success<StoryEntity>>> getStory(String id);

  Future<Either<Failure, Success<List<StoryEntity>>>> getAllStories();

  Future<Either<Failure, Success<List<StoryEntity>>>> getStoriesByReleaseDate(
      bool isDec);

  Future<Either<Failure, Success<List<StoryEntity>>>> getStoriesByModelId(
      String modelId);

  Future<Either<Failure, Success<List<StoryEntity>>>> getStoriesByTopicId(
      String topicId);

  Future<Either<Failure, Success<StoryEntity>>> createStory({
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
    required List<String> topicId,
  });

  Future<Either<Failure, Success<StoryEntity>>> updateStory({
    required String id,
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
    required List<String> topicId,
  });

  Future<Either<Failure, Success<StoryEntity>>> updateListenCount(
      String id, int count);
}
