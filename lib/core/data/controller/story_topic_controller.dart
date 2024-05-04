import 'package:ar_zoo_explorers/core/data/models/story_topic_model.dart';
import 'package:ar_zoo_explorers/core/helpers/controller_helper.dart';
import 'package:ar_zoo_explorers/core/repositories/story_topic_repository_implement.dart';
import 'package:ar_zoo_explorers/domain/entities/story_topic_entity.dart';
import 'package:ar_zoo_explorers/domain/repositories/story_topic_repository.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class StoryTopicController extends ControllerHelper {
  final StoryTopicRepository _storyTopicRepository =
      StoryTopicRepositoryImplement();
  Rx<StoryTopicEntity> currentStoryTopic = Rx(StoryTopicModel(
    id: '',
    name: '',
    title: '',
    imageUrl: '',
    status: true,
  ));

  Rx<List<StoryTopicEntity>> listStoryTopic = Rx([]);

  Future<StoryTopicEntity> getStoryTopic(BuildContext context,
      {required String id}) {
    return processRequest<StoryTopicEntity>(
        request: () => _storyTopicRepository.getStoryTopic(id),
        onSuccess: (success) => {
              _setCurrentStoryTopic(context, success.data),
            },
        onFailure: (failure) =>
            Fluttertoast.showToast(msg: "Truy cập thông tin thất bại!"));
  }

  Future<List<StoryTopicEntity>> getAllStoryTopics(BuildContext context) {
    return processRequest<List<StoryTopicEntity>>(
        request: () => _storyTopicRepository.getAllStoryTopics(),
        onFailure: (failure) =>
            Fluttertoast.showToast(msg: "Truy cập thông tin thất bại!"),
        onSuccess: (success) => {
              _setListStoryTopic(context, success.data),
            });
  }

  _setListStoryTopic(BuildContext context, List<StoryTopicEntity> lstEntity) {
    listStoryTopic.value = lstEntity;
    update();
  }

  Future<void> updateCurrentStoryTopic(BuildContext context, String id) async {
    await processRequest<StoryTopicEntity>(
        request: () async => await _storyTopicRepository.getStoryTopic(id),
        onSuccess: (success) => {_setCurrentStoryTopic(context, success.data)},
        onFailure: (failure) =>
            Fluttertoast.showToast(msg: "Truy cập thông tin thất bại!"));
  }

  Future<void> _setCurrentStoryTopic(
      BuildContext context, StoryTopicEntity entity) async {
    currentStoryTopic.value = entity;

    update();
  }

  Future<void> resetCurrentStoryTopic(BuildContext context) async {
    currentStoryTopic.value = StoryTopicModel(
      id: '',
      name: '',
      title: '',
      imageUrl: '',
      status: true,
    );
    update;
  }

  static StoryTopicController get findOrInitialize {
    try {
      return Get.find<StoryTopicController>();
    } catch (e) {
      return Get.put(StoryTopicController(), permanent: true);
    }
  }
}

class StoryTopicBinding implements Bindings {
  @override
  void dependencies() {
    StoryTopicController.findOrInitialize;
  }
}
