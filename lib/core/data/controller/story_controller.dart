import 'package:ar_zoo_explorers/core/data/models/story_model.dart';
import 'package:ar_zoo_explorers/core/helpers/controller_helper.dart';
import 'package:ar_zoo_explorers/core/repositories/story_repository_implement.dart';
import 'package:ar_zoo_explorers/domain/entities/story_entity.dart';
import 'package:ar_zoo_explorers/domain/repositories/story_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class StoryController extends ControllerHelper {
  final StoryRepository _storyRepository = StoryRepositoryImplement();
  Rx<StoryEntity> currentStory = Rx(StoryModel(
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

  Rx<List<StoryEntity>> listStory = Rx([]);

  Future<StoryEntity> getStory(BuildContext context, {required String id}) {
    return processRequest<StoryEntity>(
        request: () => _storyRepository.getStory(id),
        onSuccess: (success) => {
              _setCurrentStory(context, success.data),
            },
        onFailure: (failure) =>
            Fluttertoast.showToast(msg: "Truy cập thông tin thất bại!"));
  }

  Future<List<StoryEntity>> getAllStories(BuildContext context) {
    return processRequest<List<StoryEntity>>(
        request: () => _storyRepository.getAllStories(),
        onFailure: (failure) =>
            Fluttertoast.showToast(msg: "Truy cập thông tin thất bại!"),
        onSuccess: (success) => {
              _setListStory(context, success.data),
            });
  }

  Future<List<StoryEntity>> getStoriesByModelId(
      BuildContext context, String modelId) {
    return processRequest<List<StoryEntity>>(
        request: () => _storyRepository.getStoriesByModelId(modelId),
        onFailure: (failure) =>
            Fluttertoast.showToast(msg: "Truy cập thông tin thất bại!"),
        onSuccess: (success) => {
              _setListStory(context, success.data),
            });
  }

  Future<List<StoryEntity>> getStoriesByTopicId(
      BuildContext context, String topicId) {
    return processRequest<List<StoryEntity>>(
        request: () => _storyRepository.getStoriesByTopicId(topicId),
        onFailure: (failure) =>
            Fluttertoast.showToast(msg: "Truy cập thông tin thất bại!"),
        onSuccess: (success) => {
              _setListStory(context, success.data),
            });
  }

  Future<List<StoryEntity>> getStoriesByReleaseDate(
      BuildContext context, bool isDec) {
    return processRequest<List<StoryEntity>>(
        request: () => _storyRepository.getStoriesByReleaseDate(isDec),
        onFailure: (failure) =>
            Fluttertoast.showToast(msg: "Truy cập thông tin thất bại!"),
        onSuccess: (success) => {
              _setListStory(context, success.data),
            });
  }

  _setListStory(BuildContext context, List<StoryEntity> lstEntity) {
    listStory.value = lstEntity;
    update();
  }

  Future<void> updateCurrentStory(BuildContext context,
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
      required List<String> topicId}) async {
    await processRequest<StoryEntity>(
        request: () async => await _storyRepository.updateStory(
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
            topicId: topicId),
        onSuccess: (success) => {_setCurrentStory(context, success.data)},
        onFailure: (failure) =>
            Fluttertoast.showToast(msg: "Truy cập thông tin thất bại!"));
  }

  Future<void> updateListenCount(BuildContext context, String id) async {
    await processRequest<StoryEntity>(
        request: () async => await _storyRepository.updateListenCount(
            id, currentStory.value.listenCount),
        onSuccess: (success) => {_setCurrentStory(context, success.data)},
        onFailure: (failure) =>
            Fluttertoast.showToast(msg: "Truy cập thông tin thất bại!"));
  }

  Future<void> _setCurrentStory(
      BuildContext context, StoryEntity entity) async {
    currentStory.value = entity;

    update();
  }

  Future<void> resetCurrentStory(BuildContext context) async {
    currentStory.value = StoryModel(
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
        topicId: []);
    update;
  }

  static StoryController get findOrInitialize {
    try {
      return Get.find<StoryController>();
    } catch (e) {
      return Get.put(StoryController(), permanent: true);
    }
  }
}

class StoryBinding implements Bindings {
  @override
  void dependencies() {
    StoryController.findOrInitialize;
  }
}
