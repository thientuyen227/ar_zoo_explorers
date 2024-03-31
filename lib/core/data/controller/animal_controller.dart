import 'package:ar_zoo_explorers/core/data/models/animal_model.dart';
import 'package:ar_zoo_explorers/core/helpers/controller_helper.dart';
import 'package:ar_zoo_explorers/core/repositories/animal_repository_implement.dart';
import 'package:ar_zoo_explorers/domain/repositories/animal_repository.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../../../domain/entities/animal_entity.dart';

class AnimalController extends ControllerHelper {
  final AnimalRepository _animalRepository = AnimalRepositoryImplement();

  Rx<AnimalEntity> currentAnimal = Rx(AnimalModel(
      id: '',
      title: '',
      icon: '',
      type: '',
      name: '',
      categoryId: '',
      status: true));

  Rx<List<AnimalEntity>> listAnimal = Rx([]);

  Rx<String> searchValue = Rx("");

  Future<AnimalEntity> getAnimal(BuildContext context, {required String id}) {
    return processRequest<AnimalEntity>(
        request: () => _animalRepository.getAnimal(id),
        onSuccess: (success) => {_setCurrentAnimal(context, success.data)},
        onFailure: (failure) =>
            Fluttertoast.showToast(msg: "Truy cập thông tin thất bại!"));
  }

  _setCurrentAnimal(BuildContext context, AnimalEntity entity) {
    currentAnimal.value = entity;
    update();
  }

  Future<List<AnimalEntity>> getAllAnimals(BuildContext context) {
    return processRequest<List<AnimalEntity>>(
        request: () => _animalRepository.getAllAnimals(),
        onFailure: (failure) =>
            Fluttertoast.showToast(msg: "Truy cập thông tin thất bại!"),
        onSuccess: (success) => {_setListAnimal(context, success.data)});
  }

  _setListAnimal(BuildContext context, List<AnimalEntity> lstEntity) {
    listAnimal.value = lstEntity;
    update();
  }

  Future<void> updateCurrentAnimal(BuildContext context, String id) async {
    await processRequest<AnimalEntity>(
        request: () => _animalRepository.getAnimal(id),
        onSuccess: (success) => {_setCurrentAnimal(context, success.data)},
        onFailure: (failure) =>
            Fluttertoast.showToast(msg: "Truy cập thông tin thất bại!"));
  }

  Future<void> setSearchValue(BuildContext context, String value) async {
    searchValue.value = value;
  }

  Future<void> resetCurrentValue(BuildContext context) async {
    currentAnimal.value = AnimalModel(
        id: '',
        title: '',
        icon: '',
        type: '',
        name: '',
        categoryId: '',
        status: true);
    searchValue.value = "";
    update;
  }

  static AnimalController get findOrInitialize {
    try {
      return Get.find<AnimalController>();
    } catch (e) {
      return Get.put(AnimalController(), permanent: true);
    }
  }
}

class AnimalBinding implements Bindings {
  @override
  void dependencies() {
    AnimalController.findOrInitialize;
  }
}
