import 'package:ar_zoo_explorers/core/data/controller/auth_controller.dart';
import 'package:ar_zoo_explorers/core/helpers/controller_helper.dart';
import 'package:ar_zoo_explorers/core/repositories/user_question_repository_implement.dart';
import 'package:ar_zoo_explorers/domain/entities/user_question_entity.dart';
import 'package:ar_zoo_explorers/domain/repositories/user_question_repository.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class UserQuestionController extends ControllerHelper {
  final UserQuestionReposity _userQuestionRepository =
      UserQuestionRepositoryImplement();
  AuthController? authController;

  Rx<UserQuestionEntity> currentUserQuestionUser = Rx(UserQuestionEntity(
      id: '', userId: '', learningId: '', indexQuestion: {}));

  Future<UserQuestionEntity?> getUserQuestionByUser(
      BuildContext context, String userId, String learningId) {
    return processRequest<UserQuestionEntity?>(
        request: () => _userQuestionRepository.getQuestionByUser(
            context, userId, learningId),
        onSuccess: (success) => success.data,
        onFailure: (failure) =>
            Fluttertoast.showToast(msg: "Access information failed!"));
  }

  Future<UserQuestionEntity?> createOrGetUserQuestionByUserByUser(
      BuildContext context, UserQuestionEntity userQuestionEntity) {
    return processRequest<UserQuestionEntity?>(
        request: () => _userQuestionRepository.createOrGetQuestionByUser(
            context, userQuestionEntity),
        onSuccess: (success) => {_setCurrentUserQuestionUser(success.data!)},
        onFailure: (failure) =>
            Fluttertoast.showToast(msg: "Access information failed!"));
  }

  Future<UserQuestionEntity?> updateUserQuestionByUser(
      BuildContext context, UserQuestionEntity userQuestionEntity) async {
    return processRequest<UserQuestionEntity?>(
        request: () => _userQuestionRepository.updateQuestionByUser(
            context, userQuestionEntity),
        onSuccess: (success) => {_setCurrentUserQuestionUser(success.data!)},
        onFailure: (failure) =>
            Fluttertoast.showToast(msg: "Access information failed!"));
  }

  _setCurrentUserQuestionUser(UserQuestionEntity entity) {
    currentUserQuestionUser.value = entity;
    update();
  }

  static UserQuestionController get findOrInitialize {
    try {
      return Get.find<UserQuestionController>();
    } catch (e) {
      return Get.put(UserQuestionController(), permanent: true);
    }
  }
}

class UserQuestionBinding implements Bindings {
  @override
  void dependencies() {
    UserQuestionController.findOrInitialize;
  }
}
