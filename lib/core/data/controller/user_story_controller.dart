import 'package:ar_zoo_explorers/core/data/models/user_story_model.dart';
import 'package:ar_zoo_explorers/core/helpers/controller_helper.dart';
import 'package:ar_zoo_explorers/core/repositories/user_story_repository_implement.dart';
import 'package:ar_zoo_explorers/domain/entities/user_story_entity.dart';
import 'package:ar_zoo_explorers/domain/repositories/user_story_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class UserStoryController extends ControllerHelper {
  final UserStoryRepository _userStoryRepository =
      UserStoryRepositoryImplement();

  Rx<UserStoryEntity> currentUserStory = Rx(UserStoryModel(
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

  Rx<List<UserStoryEntity>> listUserStory = Rx([]);

  Rx<List<UserStoryEntity>> listFavoriteUserStory = Rx([]);

  Future<UserStoryEntity> createOrGetUserStory(BuildContext context,
      {required String userId, required String storyId}) {
    return processRequest<UserStoryEntity>(
        request: () => _userStoryRepository.createOrGetUserStory(
            storyId: storyId,
            userId: userId,
            pausedTime: 0,
            isCompleted: false,
            isFavorited: false,
            createdAt: Timestamp.now(),
            updatedAt: Timestamp.now(),
            status: true),
        onSuccess: (success) async => {
              await _setCurrentUserStory(context, success.data),
            },
        onFailure: (failure) =>
            Fluttertoast.showToast(msg: "Truy cập thông tin thất bại!"));
  }

  Future<UserStoryEntity> updateUserStory(BuildContext context,
      {required String id,
      required String storyId,
      required String userId,
      required int pausedTime,
      required bool isCompleted,
      required bool isFavorited,
      required Timestamp createdAt,
      required Timestamp updatedAt,
      required bool status}) {
    return processRequest<UserStoryEntity>(
        request: () => _userStoryRepository.updateUserStory(
            id: id,
            storyId: storyId,
            userId: userId,
            pausedTime: pausedTime,
            isCompleted: isCompleted,
            isFavorited: isFavorited,
            createdAt: createdAt,
            updatedAt: updatedAt,
            status: status),
        onSuccess: (success) async => {
              await _setCurrentUserStory(context, success.data),
            },
        onFailure: (failure) =>
            Fluttertoast.showToast(msg: "Truy cập thông tin thất bại!"));
  }

  Future<UserStoryEntity> updateFavorite(BuildContext context,
      {required String id, required bool isFavorited}) {
    return processRequest<UserStoryEntity>(
        request: () => _userStoryRepository.updateFavoriteOfUserStory(
            id: id, isFavorited: isFavorited),
        onSuccess: (success) async => {
              await _updateFavorite(context, success.data.isFavorited),
            },
        onFailure: (failure) =>
            Fluttertoast.showToast(msg: "Truy cập thông tin thất bại!"));
  }

  Future<UserStoryEntity> updateComplete(BuildContext context,
      {required String id, required bool isCompleted}) {
    return processRequest<UserStoryEntity>(
        request: () => _userStoryRepository.updateCompleteOfUserStory(
            id: id, isCompleted: isCompleted, updatedAt: Timestamp.now()),
        onSuccess: (success) async => {
              await _updateComplete(
                  context, success.data.isCompleted, success.data.updatedAt),
            },
        onFailure: (failure) =>
            Fluttertoast.showToast(msg: "Truy cập thông tin thất bại!"));
  }

  Future<UserStoryEntity> updatePausedTime(BuildContext context,
      {required String id, required int pausedTime}) {
    return processRequest<UserStoryEntity>(
        request: () => _userStoryRepository.updatePausedTimeOfUserStory(
            id: id, pausedTime: pausedTime, updatedAt: Timestamp.now()),
        onSuccess: (success) async => {
              await _updatePausedTime(
                  context, success.data.pausedTime, success.data.updatedAt),
            },
        onFailure: (failure) =>
            Fluttertoast.showToast(msg: "Truy cập thông tin thất bại!"));
  }

  _setCurrentUserStory(BuildContext context, UserStoryEntity entity) async {
    currentUserStory.value = entity;
    update();
  }

  _updateFavorite(BuildContext context, bool isFavorited) async {
    if (currentUserStory.value.isFavorited != isFavorited) {
      currentUserStory.value.isFavorited = isFavorited;
    }
    update();
  }

  _updateComplete(
      BuildContext context, bool isCompleted, Timestamp updatedAt) async {
    if (currentUserStory.value.isCompleted != isCompleted) {
      currentUserStory.value.isCompleted = isCompleted;
      currentUserStory.value.updatedAt = updatedAt;
    }
    update();
  }

  _updatePausedTime(
      BuildContext context, int pausedTime, Timestamp updatedAt) async {
    if (currentUserStory.value.pausedTime != pausedTime) {
      currentUserStory.value.pausedTime = pausedTime;
      currentUserStory.value.updatedAt = updatedAt;
    }
    update();
  }

  Future<List<UserStoryEntity>> getUserStoryByUser(BuildContext context,
      {required String userId}) {
    return processRequest<List<UserStoryEntity>>(
        request: () => _userStoryRepository.getUserStoryByUserId(userId),
        onSuccess: (success) async => {
              await _setListUserStory(context, success.data),
            },
        onFailure: (failure) =>
            Fluttertoast.showToast(msg: "Truy cập thông tin thất bại!"));
  }

  Future<List<UserStoryEntity>> getFavoriteUserStory(BuildContext context,
      {required String userId, required bool isFavorited}) async {
    return await processRequest<List<UserStoryEntity>>(
        request: () async => await _userStoryRepository
            .getUserStoryByUserIdAndIsFavorited(userId, isFavorited),
        onSuccess: (success) async => {
              await _setListFavortieUserStory(context, success.data),
            },
        onFailure: (failure) =>
            Fluttertoast.showToast(msg: "Truy cập thông tin thất bại!"));
  }

  _setListUserStory(
      BuildContext context, List<UserStoryEntity> lstEntity) async {
    listUserStory.value = lstEntity;
    update();
  }

  _setListFavortieUserStory(
      BuildContext context, List<UserStoryEntity> lstEntity) async {
    listFavoriteUserStory.value = lstEntity;
    update();
  }

  static UserStoryController get findOrInitialize {
    try {
      return Get.find<UserStoryController>();
    } catch (e) {
      return Get.put(UserStoryController(), permanent: true);
    }
  }
}

class UserStoryBinding implements Bindings {
  @override
  void dependencies() {
    UserStoryController.findOrInitialize;
  }
}
