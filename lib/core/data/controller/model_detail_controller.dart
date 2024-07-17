import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../../../domain/entities/model_detail_entity.dart';
import '../../../domain/repositories/model_detail_repository.dart';
import '../../helpers/controller_helper.dart';
import '../../repositories/model_detail_repository_implement.dart';
import '../models/model_detail_model.dart';

class ModelDetailController extends ControllerHelper {
  final ModelDetailRepository _modelDetailRepository =
      ModelDetailRepositoryImplement();

  Rx<ModelDetailEntity> currentModelDetail = Rx(ModelDetailModel(
    id: '',
    modelId: '',
    description: {'en': '', 'vi': ''},
    classification: {'en': '', 'vi': ''},
    conservation: {'en': '', 'vi': ''},
    reproduction: {'en': '', 'vi': ''},
    culturalFigure: {'en': '', 'vi': ''},
    preservation: {'en': '', 'vi': ''},
    culturalSignificance: {'en': '', 'vi': ''},
    maintenance: {'en': '', 'vi': ''},
    manufacturing: {'en': '', 'vi': ''},
    educationalValue: {'en': '', 'vi': ''},
    views: 0,
  ));

  Rx<List<ModelDetailEntity>> listModelDetail = Rx([]);

  Future<ModelDetailEntity> getModelDetail(BuildContext context,
      {required String id}) {
    return processRequest<ModelDetailEntity>(
        request: () => _modelDetailRepository.getModelDetail(id),
        onSuccess: (success) => {
              _setCurrentModelDetail(context, success.data),
            },
        onFailure: (failure) =>
            Fluttertoast.showToast(msg: "Truy cập thông tin thất bại!"));
  }

  Future<List<ModelDetailEntity>> getAllModelDetails(BuildContext context) {
    return processRequest<List<ModelDetailEntity>>(
        request: () => _modelDetailRepository.getAllModelDetails(),
        onFailure: (failure) =>
            Fluttertoast.showToast(msg: "Truy cập thông tin thất bại!"),
        onSuccess: (success) => {
              _setListModelDetail(context, success.data),
            });
  }

  _setListModelDetail(BuildContext context, List<ModelDetailEntity> lstEntity) {
    listModelDetail.value = lstEntity;
    update();
  }

  Future<ModelDetailEntity> getModelDetailByModelId(BuildContext context,
      {required String modelId}) {
    return processRequest<ModelDetailEntity>(
        request: () => _modelDetailRepository.getModelDetailByModelId(modelId),
        onSuccess: (success) => {
              _setCurrentModelDetail(context, success.data),
            },
        onFailure: (failure) =>
            Fluttertoast.showToast(msg: "Truy cập thông tin thất bại!"));
  }

  Future<ModelDetailEntity> updateViewsModelModel(BuildContext context,
      {required String id, required int views}) {
    return processRequest<ModelDetailEntity>(
        request: () =>
            _modelDetailRepository.updateViewModelDetail(id: id, views: views),
        onSuccess: (success) => {
              _setCurrentModelDetail(context, success.data),
            },
        onFailure: (failure) =>
            Fluttertoast.showToast(msg: "Truy cập thông tin thất bại!"));
  }

  Future<void> _setCurrentModelDetail(
      BuildContext context, ModelDetailEntity entity) async {
    currentModelDetail.value = entity;

    update();
  }

  Future<ModelDetailEntity> getDetail() async {
    return currentModelDetail.value;
  }

  static ModelDetailController get findOrInitialize {
    try {
      return Get.find<ModelDetailController>();
    } catch (e) {
      return Get.put(ModelDetailController(), permanent: true);
    }
  }
}

class ModelDetailBinding implements Bindings {
  @override
  void dependencies() {
    ModelDetailController.findOrInitialize;
  }
}
