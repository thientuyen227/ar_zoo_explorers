import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../../../domain/entities/user_animal_entity.dart';
import '../../../domain/repositories/user_animal_repository.dart';
import '../../helpers/controller_helper.dart';
import '../../repositories/user_animal_repository_implement.dart';
import '../models/user_animal_model.dart';

class UserAnimalController extends ControllerHelper {
  final UserAnimalRepository _userAnimalRepository =
      UserAnimalRepositoryImplement();

  Rx<UserAnimalEntity> currentAnimalCategory = Rx(UserAnimalModel(
    id: '',
    userId: '',
    modelId: '',
    isLoved: false,
  ));

  Future<UserAnimalEntity> getUserAnimal(BuildContext context,
      {required String id}) {
    return processRequest<UserAnimalEntity>(
        request: () => _userAnimalRepository.getUserAnimal(id),
        onSuccess: (success) => {
              _setCurrentUserAnimal(context, success.data),
            },
        onFailure: (failure) =>
            Fluttertoast.showToast(msg: "Truy cập thông tin thất bại!"));
  }

  Future<UserAnimalEntity> getUserAnimalByUserIdAndModelId(BuildContext context,
      {required String userId, required String modelId}) {
    return processRequest<UserAnimalEntity>(
        request: () => _userAnimalRepository.getUserAnimalByUserIdAndModelId(
            userId, modelId),
        onSuccess: (success) => {
              _setCurrentUserAnimal(context, success.data),
            },
        onFailure: (failure) =>
            Fluttertoast.showToast(msg: "Truy cập thông tin thất bại!"));
  }

  Future<UserAnimalEntity> createUserAnimal(BuildContext context,
      {required String userId,
      required String modelId,
      required bool isLoved}) {
    return processRequest<UserAnimalEntity>(
        request: () => _userAnimalRepository.createUserAnimal(
            userId: userId, modelId: modelId, isLoved: isLoved),
        onSuccess: (success) => {
              _setCurrentUserAnimal(context, success.data),
            },
        onFailure: (failure) =>
            Fluttertoast.showToast(msg: "Truy cập thông tin thất bại!"));
  }

  Future<bool> getUserAnimalIsLoved(String userId, String modelId) {
    return processRequest<bool>(
        request: () =>
            _userAnimalRepository.getUserAnimalIsLoved(userId, modelId),
        onSuccess: (success) => {success.data},
        onFailure: (failure) =>
            Fluttertoast.showToast(msg: "Truy cập thông tin thất bại!"));
  }

  Future<UserAnimalEntity> updateUserAnimal(BuildContext context,
      {required String id,
      required String userId,
      required String modelId,
      required bool isLoved}) {
    return processRequest<UserAnimalEntity>(
        request: () => _userAnimalRepository.updateUserAnimal(
            id: id, userId: userId, modelId: modelId, isLoved: isLoved),
        onSuccess: (success) => {_setCurrentUserAnimal(context, success.data)},
        onFailure: (failure) =>
            Fluttertoast.showToast(msg: "Truy cập thông tin thất bại!"));
  }

  Future<void> _setCurrentUserAnimal(
      BuildContext context, UserAnimalEntity entity) async {
    currentAnimalCategory.value = entity;

    update();
  }

  static UserAnimalController get findOrInitialize {
    try {
      return Get.find<UserAnimalController>();
    } catch (e) {
      return Get.put(UserAnimalController(), permanent: true);
    }
  }
}

class UserAnimalBinding implements Bindings {
  @override
  void dependencies() {
    UserAnimalController.findOrInitialize;
  }
}
