import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../../../domain/entities/animal_detail_entity.dart';
import '../../../domain/repositories/animal_detail_repository.dart';
import '../../helpers/controller_helper.dart';
import '../../repositories/animal_detail_repository_implement.dart';
import '../models/animal_detail_model.dart';

class AnimalDetailController extends ControllerHelper {
  final AnimalDetailRepository _animalDetailRepository =
      AnimalDetailRepositoryImplement();

  Rx<AnimalDetailEntity> currentAnimalDetail = Rx(AnimalDetailModel(
      id: '',
      modelId: '',
      description: '',
      classification: '',
      conservation: '',
      reproduction: '',
      culturalFigure: '',
      views: 0));

  Rx<List<AnimalDetailEntity>> listAnimalDetail = Rx([]);

  Future<AnimalDetailEntity> getAnimalDetail(BuildContext context,
      {required String id}) {
    return processRequest<AnimalDetailEntity>(
        request: () => _animalDetailRepository.getAnimalDetailModel(id),
        onSuccess: (success) => {
              _setCurrentAnimalDetail(context, success.data),
            },
        onFailure: (failure) =>
            Fluttertoast.showToast(msg: "Truy cập thông tin thất bại!"));
  }

  Future<List<AnimalDetailEntity>> getAllAnimalDetails(BuildContext context) {
    return processRequest<List<AnimalDetailEntity>>(
        request: () => _AnimalDetailRepository.getAllAnimalDetails(),
        onFailure: (failure) =>
            Fluttertoast.showToast(msg: "Truy cập thông tin thất bại!"),
        onSuccess: (success) => {
              _setListAnimalDetail(context, success.data),
            });
  }

  _setListAnimalDetail(
      BuildContext context, List<AnimalDetailEntity> lstEntity) {
    listAnimalDetail.value = lstEntity;
    update();
  }

  Future<AnimalDetailEntity> getAnimalCategoryModelByModelId(
      BuildContext context,
      {required String modelId}) {
    return processRequest<AnimalDetailEntity>(
        request: () =>
            _animalDetailRepository.getAnimalDetailModelByModelId(modelId),
        onSuccess: (success) => {
              _setCurrentAnimalDetail(context, success.data),
            },
        onFailure: (failure) =>
            Fluttertoast.showToast(msg: "Truy cập thông tin thất bại!"));
  }

  Future<AnimalDetailEntity> updateViewsAnimalModel(BuildContext context,
      {required String id, required int views}) {
    return processRequest<AnimalDetailEntity>(
        request: () => _animalDetailRepository.updateViewAnimalDetail(
            id: id, views: views),
        onSuccess: (success) => {
              _setCurrentAnimalDetail(context, success.data),
            },
        onFailure: (failure) =>
            Fluttertoast.showToast(msg: "Truy cập thông tin thất bại!"));
  }

  Future<void> _setCurrentAnimalDetail(
      BuildContext context, AnimalDetailEntity entity) async {
    currentAnimalDetail.value = entity;

    update();
  }

  static AnimalDetailController get findOrInitialize {
    try {
      return Get.find<AnimalDetailController>();
    } catch (e) {
      return Get.put(AnimalDetailController(), permanent: true);
    }
  }
}

class AnimalDetailBinding implements Bindings {
  @override
  void dependencies() {
    AnimalDetailController.findOrInitialize;
  }
}
