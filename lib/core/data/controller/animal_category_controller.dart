import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../../../domain/entities/animal_category_entity.dart';
import '../../../domain/repositories/animal_category_repository.dart';
import '../../helpers/controller_helper.dart';
import '../../repositories/animal_category_repository_implement.dart';
import '../models/animal_category_model.dart';

class AnimalCategoryController extends ControllerHelper {
  final AnimalCategoryRepository _animalCategoryRepository =
      AnimalCategoryRepositoryImplement();
  Rx<AnimalCategoryEntity> currentAnimalCategory = Rx(AnimalCategoryModel(
    id: '',
    name: '',
    title: '',
    imageUrl: '',
    status: true,
  ));

  Rx<List<AnimalCategoryEntity>> listAnimalCategory = Rx([]);

  Future<AnimalCategoryEntity> getAnimalCategoryModel(BuildContext context,
      {required String id}) {
    return processRequest<AnimalCategoryEntity>(
        request: () => _animalCategoryRepository.getAnimalCategoryModel(id),
        onSuccess: (success) => {
              _setCurrentAnimalCategory(context, success.data),
              Fluttertoast.showToast(msg: "Truy cập thông tin thành công!")
            },
        onFailure: (failure) =>
            Fluttertoast.showToast(msg: "Truy cập thông tin thất bại!"));
  }

  _setCurrentAnimalCategory(BuildContext context, AnimalCategoryEntity entity) {
    currentAnimalCategory.value = entity;
    update();
  }

  Future<List<AnimalCategoryEntity>> getAllAnimalCategories(
      BuildContext context) {
    return processRequest<List<AnimalCategoryEntity>>(
        request: () => _animalCategoryRepository.getAllAnimalCategories(),
        onFailure: (failure) =>
            Fluttertoast.showToast(msg: "Truy cập thông tin thất bại!"),
        onSuccess: (success) => {
              _setListAnimalCategory(context, success.data),
              Fluttertoast.showToast(msg: "Truy cập thông tin thành công!")
            });
  }

  _setListAnimalCategory(
      BuildContext context, List<AnimalCategoryEntity> lstEntity) {
    listAnimalCategory.value = lstEntity;
    update();
  }

  static AnimalCategoryController get findOrInitialize {
    try {
      return Get.find<AnimalCategoryController>();
    } catch (e) {
      return Get.put(AnimalCategoryController(), permanent: true);
    }
  }
}

class AnimalCategoryBinding implements Bindings {
  @override
  void dependencies() {
    AnimalCategoryController.findOrInitialize;
  }
}
