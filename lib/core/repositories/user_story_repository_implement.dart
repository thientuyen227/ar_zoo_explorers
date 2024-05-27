import 'dart:async';

import 'package:ar_zoo_explorers/core/data/models/user_story_model.dart';
import 'package:ar_zoo_explorers/core/data/sources/firebase/firebase_firestore_source.dart';
import 'package:ar_zoo_explorers/core/failures.dart';
import 'package:ar_zoo_explorers/core/helpers/exception_handler.dart';
import 'package:ar_zoo_explorers/core/success.dart';
import 'package:ar_zoo_explorers/domain/entities/user_story_entity.dart';
import 'package:ar_zoo_explorers/domain/repositories/user_story_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';

class UserStoryRepositoryImplement implements UserStoryRepository {
  final FirebaseFirestoreSource _firestoreSource = FirebaseFirestoreSource();

  @override
  Future<Either<Failure, Success<UserStoryEntity>>> createOrGetUserStory(
      {required String storyId,
      required String userId,
      required int pausedTime,
      required bool isCompleted,
      required bool isFavorited,
      required Timestamp createdAt,
      required Timestamp updatedAt,
      required bool status}) {
    return ResponseHandler.processResponse(() async {
      return Success(
          data: await _firestoreSource.createOrGetUserStory(UserStoryModel(
                id: '',
                storyId: storyId,
                userId: userId,
                pausedTime: pausedTime,
                isCompleted: isCompleted,
                isFavorited: isFavorited,
                createdAt: createdAt,
                updatedAt: updatedAt,
                status: status,
              )) ??
              UserStoryModel(
                  id: '',
                  storyId: '',
                  userId: '',
                  pausedTime: 0,
                  isCompleted: false,
                  isFavorited: false,
                  createdAt: Timestamp.now(),
                  updatedAt: Timestamp.now(),
                  status: true));
    });
  }

  @override
  Future<Either<Failure, Success<UserStoryEntity>>> getUserStory(String id) {
    return ResponseHandler.processResponse(() async {
      return Success(
          data: await _firestoreSource.getUserStory(id) ??
              UserStoryModel(
                id: '',
                storyId: '',
                userId: '',
                pausedTime: 0,
                isCompleted: false,
                isFavorited: false,
                createdAt: Timestamp.now(),
                updatedAt: Timestamp.now(),
                status: true,
              ));
    });
  }

  @override
  Future<Either<Failure, Success<List<UserStoryEntity>>>> getUserStoryByUserId(
      String userId) {
    return ResponseHandler.processResponse(() async {
      return Success(
          data: await _firestoreSource.getUserStoryByUserId(userId) ?? []);
    });
  }

  @override
  Future<Either<Failure, Success<List<UserStoryEntity>>>>
      getUserStoryByUserIdAndIsFavorited(String userId, bool isFavorited) {
    return ResponseHandler.processResponse(() async {
      return Success(
          data: await _firestoreSource.getUserStoryByUserIdAndIsFavorited(
                  userId, isFavorited) ??
              []);
    });
  }

  @override
  Future<Either<Failure, Success<UserStoryEntity>>>
      getUserStoryByUserIdAndStoryId(String userId, String storyId) {
    return ResponseHandler.processResponse(() async {
      return Success(
          data: await _firestoreSource.getUserStoryByUserIdAndStoryId(
                  userId, storyId) ??
              UserStoryModel(
                  id: '',
                  storyId: '',
                  userId: '',
                  pausedTime: 0,
                  isCompleted: false,
                  isFavorited: false,
                  createdAt: Timestamp.now(),
                  updatedAt: Timestamp.now(),
                  status: true));
    });
  }

  @override
  Future<Either<Failure, Success<UserStoryEntity>>> updateFavoriteOfUserStory(
      {required String id, required bool isFavorited}) {
    return ResponseHandler.processResponse(() async {
      return Success(
          data: await _firestoreSource.updateUserStoryWithIsFavorited(
                  id: id, isFavorited: isFavorited) ??
              UserStoryModel(
                  id: '',
                  storyId: '',
                  userId: '',
                  pausedTime: 0,
                  isCompleted: false,
                  isFavorited: false,
                  createdAt: Timestamp.now(),
                  updatedAt: Timestamp.now(),
                  status: true));
    });
  }

  @override
  Future<Either<Failure, Success<UserStoryEntity>>> updateUserStory(
      {required String id,
      required String storyId,
      required String userId,
      required int pausedTime,
      required bool isCompleted,
      required bool isFavorited,
      required Timestamp createdAt,
      required Timestamp updatedAt,
      required bool status}) {
    return ResponseHandler.processResponse(() async {
      return Success(
          data: await _firestoreSource.updateUserStory(
                  id: id,
                  storyId: storyId,
                  userId: userId,
                  pausedTime: pausedTime,
                  isCompleted: isCompleted,
                  isFavorited: isFavorited,
                  createdAt: createdAt,
                  updatedAt: updatedAt,
                  status: status) ??
              UserStoryModel(
                  id: '',
                  storyId: '',
                  userId: '',
                  pausedTime: 0,
                  isCompleted: false,
                  isFavorited: false,
                  createdAt: Timestamp.now(),
                  updatedAt: Timestamp.now(),
                  status: true));
    });
  }

  @override
  Future<Either<Failure, Success<UserStoryEntity>>> updateCompleteOfUserStory(
      {required String id,
      required bool isCompleted,
      required Timestamp updatedAt}) {
    return ResponseHandler.processResponse(() async {
      return Success(
          data: await _firestoreSource.updateUserStoryWithIsCompleted(
                  id: id, isCompleted: isCompleted, updatedAt: updatedAt) ??
              UserStoryModel(
                  id: '',
                  storyId: '',
                  userId: '',
                  pausedTime: 0,
                  isCompleted: false,
                  isFavorited: false,
                  createdAt: Timestamp.now(),
                  updatedAt: Timestamp.now(),
                  status: true));
    });
  }

  @override
  Future<Either<Failure, Success<UserStoryEntity>>> updatePausedTimeOfUserStory(
      {required String id,
      required int pausedTime,
      required Timestamp updatedAt}) {
    return ResponseHandler.processResponse(() async {
      return Success(
          data: await _firestoreSource.updateUserStoryWithPausedTime(
                  id: id, pausedTime: pausedTime, updatedAt: updatedAt) ??
              UserStoryModel(
                  id: '',
                  storyId: '',
                  userId: '',
                  pausedTime: 0,
                  isCompleted: false,
                  isFavorited: false,
                  createdAt: Timestamp.now(),
                  updatedAt: Timestamp.now(),
                  status: true));
    });
  }
}
