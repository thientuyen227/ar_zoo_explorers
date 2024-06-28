import 'package:ar_zoo_explorers/core/helpers/controller_helper.dart';
import 'package:ar_zoo_explorers/core/repositories/learning_category_repository_implement.dart';
import 'package:ar_zoo_explorers/domain/entities/learning_category_entity.dart';
import 'package:ar_zoo_explorers/domain/repositories/learning_category_repository.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class LearningCategoryController extends ControllerHelper {
  final LearningCategoryRepository _learningCategoryRepository =
      LearningCategoryRepositoryImplement();

  Rx<LearningCategoryEntity> currentLearningCategory =
      Rx(LearningCategoryEntity(
    id: '',
    name: {},
    imagePath: '',
  ));

  Rx<List<LearningCategoryEntity>> listLearningCategory = Rx([]);

  Rx<String> searchValue = Rx("");

  Future<LearningCategoryEntity?> getLearningCategory(
      BuildContext context, String learningCategoryId) {
    return processRequest<LearningCategoryEntity?>(
        request: () => _learningCategoryRepository.getLearningCategory(
            context, learningCategoryId),
        onSuccess: (success) =>
            {_setCurrentLearningCategory(context, success.data!)},
        onFailure: (failure) =>
            Fluttertoast.showToast(msg: "Access information failed!"));
  }

  _setCurrentLearningCategory(
      BuildContext context, LearningCategoryEntity entity) {
    currentLearningCategory.value = entity;
    update();
  }

  Future<List<LearningCategoryEntity>?> getAllLearningCategorys(
    BuildContext context,
  ) {
    return processRequest<List<LearningCategoryEntity>?>(
        request: () =>
            _learningCategoryRepository.getAllLearningCategory(context),
        onFailure: (failure) =>
            Fluttertoast.showToast(msg: "Access information failed!"),
        onSuccess: (success) => {_setListLearningCategory(success.data!)});
  }

  _setListLearningCategory(List<LearningCategoryEntity> listEntity) {
    listLearningCategory.value = listEntity;
    listLearningCategory.value
        .sort((a, b) => a.name['en']!.compareTo(b.name['en']!));
    update();
  }

  Future<void> updateCurrentLearningCategory(
      BuildContext context, String id) async {
    await processRequest<LearningCategoryEntity?>(
        request: () =>
            _learningCategoryRepository.getLearningCategory(context, id),
        onSuccess: (success) =>
            {_setCurrentLearningCategory(context, success.data!)},
        onFailure: (failure) =>
            Fluttertoast.showToast(msg: "Access information failed!"));
  }

  Future<void> setSearchValue(BuildContext context, String value) async {
    searchValue.value = value;
  }

  Future<void> resetCurrentValue(BuildContext context) async {
    currentLearningCategory.value = LearningCategoryEntity(
      id: '',
      name: {},
      imagePath: '',
    );
    searchValue.value = "";
    update;
  }

  static LearningCategoryController get findOrInitialize {
    try {
      return Get.find<LearningCategoryController>();
    } catch (e) {
      return Get.put(LearningCategoryController(), permanent: true);
    }
  }
}

class LearningCategoryBinding implements Bindings {
  @override
  void dependencies() {
    LearningCategoryController.findOrInitialize;
  }
}
