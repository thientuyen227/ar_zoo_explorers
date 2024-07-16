import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../../../domain/entities/model_category_entity.dart';
import '../../../domain/repositories/model_category_repository.dart';
import '../../helpers/controller_helper.dart';
import '../../repositories/model_category_repository_implement.dart';
import '../models/animal_category_model.dart';

class ModelCategoryController extends ControllerHelper {
  final ModelCategoryRepository _modelCategoryRepository =
      ModelCategoryRepositoryImplement();
  Rx<ModelCategoryEntity> currentModelCategory = Rx(ModelCategoryModel(
    id: '',
    name: '',
    title: {'vi': '', 'en': ''},
    imageUrl: '',
    status: true,
  ));

  Rx<List<ModelCategoryEntity>> listModelCategory = Rx([]);

  Future<ModelCategoryEntity> getModelCategory(BuildContext context,
      {required String id}) {
    return processRequest<ModelCategoryEntity>(
        request: () => _modelCategoryRepository.getModelCategory(id),
        onSuccess: (success) => {
              _setCurrentModelCategory(context, success.data),
            },
        onFailure: (failure) =>
            Fluttertoast.showToast(msg: "Truy cập thông tin thất bại!"));
  }

  Future<List<ModelCategoryEntity>> getAllModelCategories(
      BuildContext context) {
    return processRequest<List<ModelCategoryEntity>>(
        request: () => _modelCategoryRepository.getAllModelCategories(),
        onFailure: (failure) =>
            Fluttertoast.showToast(msg: "Truy cập thông tin thất bại!"),
        onSuccess: (success) => {
              _setListModelCategory(context, success.data),
            });
  }

  _setListModelCategory(
      BuildContext context, List<ModelCategoryEntity> lstEntity) {
    listModelCategory.value = lstEntity;
    update();
  }

  Future<void> updateCurrentModelCategory(
      BuildContext context, String id) async {
    await processRequest<ModelCategoryEntity>(
        request: () async =>
            await _modelCategoryRepository.getModelCategory(id),
        onSuccess: (success) =>
            {_setCurrentModelCategory(context, success.data)},
        onFailure: (failure) =>
            Fluttertoast.showToast(msg: "Truy cập thông tin thất bại!"));
  }

  Future<void> _setCurrentModelCategory(
      BuildContext context, ModelCategoryEntity entity) async {
    currentModelCategory.value = entity;

    update();
  }

  Future<void> resetCurrentModelCategory(BuildContext context) async {
    currentModelCategory.value = ModelCategoryModel(
      id: '',
      name: '',
      title: {
        'vi': '',
        'en': '',
      },
      imageUrl: '',
      status: true,
    );
    update;
  }

  static ModelCategoryController get findOrInitialize {
    try {
      return Get.find<ModelCategoryController>();
    } catch (e) {
      return Get.put(ModelCategoryController(), permanent: true);
    }
  }
}

class ModelCategoryBinding implements Bindings {
  @override
  void dependencies() {
    ModelCategoryController.findOrInitialize;
  }
}
