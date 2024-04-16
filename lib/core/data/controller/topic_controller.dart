import 'package:ar_zoo_explorers/core/data/models/topic_model.dart';
import 'package:ar_zoo_explorers/core/helpers/controller_helper.dart';
import 'package:ar_zoo_explorers/core/repositories/topic_repository_implement.dart';
import 'package:ar_zoo_explorers/domain/entities/topic_entity.dart';
import 'package:ar_zoo_explorers/domain/repositories/topic_repository.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class TopicController extends ControllerHelper {
  final TopicRepository _topicRepository = TopicRepositoryImplement();
  Rx<TopicEntity> currentTopic = Rx(TopicModel(
    id: '',
    name: '',
    title: '',
    imageUrl: '',
    status: true,
  ));

  Rx<List<TopicEntity>> listTopic = Rx([]);

  Future<TopicEntity> getTopic(BuildContext context, {required String id}) {
    return processRequest<TopicEntity>(
        request: () => _topicRepository.getTopic(id),
        onSuccess: (success) => {
              _setCurrentTopic(context, success.data),
            },
        onFailure: (failure) =>
            Fluttertoast.showToast(msg: "Truy cập thông tin thất bại!"));
  }

  Future<List<TopicEntity>> getAllTopics(BuildContext context) {
    return processRequest<List<TopicEntity>>(
        request: () => _topicRepository.getAllTopics(),
        onFailure: (failure) =>
            Fluttertoast.showToast(msg: "Truy cập thông tin thất bại!"),
        onSuccess: (success) => {
              _setListTopic(context, success.data),
            });
  }

  _setListTopic(BuildContext context, List<TopicEntity> lstEntity) {
    listTopic.value = lstEntity;
    update();
  }

  Future<void> updateCurrentTopic(BuildContext context, String id) async {
    await processRequest<TopicEntity>(
        request: () async => await _topicRepository.getTopic(id),
        onSuccess: (success) => {_setCurrentTopic(context, success.data)},
        onFailure: (failure) =>
            Fluttertoast.showToast(msg: "Truy cập thông tin thất bại!"));
  }

  Future<void> _setCurrentTopic(
      BuildContext context, TopicEntity entity) async {
    currentTopic.value = entity;

    update();
  }

  Future<void> resetCurrentTopic(BuildContext context) async {
    currentTopic.value = TopicModel(
      id: '',
      name: '',
      title: '',
      imageUrl: '',
      status: true,
    );
    update;
  }

  static TopicController get findOrInitialize {
    try {
      return Get.find<TopicController>();
    } catch (e) {
      return Get.put(TopicController(), permanent: true);
    }
  }
}

class TopicBinding implements Bindings {
  @override
  void dependencies() {
    TopicController.findOrInitialize;
  }
}
