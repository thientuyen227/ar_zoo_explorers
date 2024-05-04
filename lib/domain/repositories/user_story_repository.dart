import 'package:ar_zoo_explorers/core/failures.dart';
import 'package:ar_zoo_explorers/core/success.dart';
import 'package:dartz/dartz.dart';

import '../entities/user_story_entity.dart';

abstract class UserStoryRepository {
  Future<Either<Failure, Success<UserStoryEntity>>> getUserStory(String id);

  Future<Either<Failure, Success<UserStoryEntity>>> createOrGetUserStory({
    required String storyId,
    required String userId,
    required int pausedTime,
    required bool isCompleted,
    required bool isFavorited,
    required bool status,
  });

  Future<Either<Failure, Success<UserStoryEntity>>> updateUserStory({
    required String id,
    required String storyId,
    required String userId,
    required int pausedTime,
    required bool isCompleted,
    required bool isFavorited,
    required bool status,
  });

  Future<Either<Failure, Success<UserStoryEntity>>> updateFavoriteOfUserStory({
    required String id,
    required bool isFavorited,
  });

  Future<Either<Failure, Success<UserStoryEntity>>> updateCompleteOfUserStory({
    required String id,
    required bool isCompleted,
  });

  Future<Either<Failure, Success<UserStoryEntity>>>
      updatePausedTimeOfUserStory({
    required String id,
    required int pausedTime,
  });

  Future<Either<Failure, Success<UserStoryEntity>>>
      getUserStoryByUserIdAndStoryId(String userId, String storyId);

  Future<Either<Failure, Success<List<UserStoryEntity>>>>
      getUserStoryByUserIdAndIsFavorited(String userId, bool isFavorited);

  Future<Either<Failure, Success<List<UserStoryEntity>>>> getUserStoryByUserId(
      String userId);
}
