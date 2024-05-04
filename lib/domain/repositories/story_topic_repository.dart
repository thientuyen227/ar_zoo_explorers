import 'package:ar_zoo_explorers/core/failures.dart';
import 'package:ar_zoo_explorers/core/success.dart';
import 'package:ar_zoo_explorers/domain/entities/story_topic_entity.dart';
import 'package:dartz/dartz.dart';

abstract class StoryTopicRepository {
  Future<Either<Failure, Success<StoryTopicEntity>>> getStoryTopic(String id);

  Future<Either<Failure, Success<List<StoryTopicEntity>>>> getAllStoryTopics();
}
