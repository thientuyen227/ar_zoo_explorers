import 'package:ar_zoo_explorers/core/helpers/controller_helper.dart';
import 'package:ar_zoo_explorers/core/repositories/chars_repository_implement.dart';
import 'package:ar_zoo_explorers/domain/entities/chars_entity.dart';
import 'package:ar_zoo_explorers/domain/repositories/chars_repository.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class CharsController extends ControllerHelper {
  final CharsRepository _charsRepository = CharsRepositoryImplement();

  Rx<CharsEntity> currentChars = Rx(CharsEntity(
    id: '',
    char: '',
    type: '',
    audios: {},
  ));

  Rx<List<CharsEntity>> listChars = Rx([]);

  Rx<String> searchValue = Rx("");

  Future<CharsEntity?> getChars(BuildContext context, String CharsId) {
    return processRequest<CharsEntity?>(
        request: () => _charsRepository.getChars(CharsId),
        onSuccess: (success) => {_setCurrentChars(context, success.data!)},
        onFailure: (failure) =>
            Fluttertoast.showToast(msg: "Access information failed!"));
  }

  _setCurrentChars(BuildContext context, CharsEntity entity) {
    currentChars.value = entity;
    update();
  }

  Future<List<CharsEntity>?> getAllChars(BuildContext context) {
    return processRequest<List<CharsEntity>?>(
        request: () => _charsRepository.getAllChars(),
        onFailure: (failure) =>
            Fluttertoast.showToast(msg: "Access information failed!"),
        onSuccess: (success) => {_setListChars(context, success.data!)});
  }

  _setListChars(BuildContext context, List<CharsEntity> listEntity) {
    listChars.value = listEntity;
    update();
  }

  Future<void> updateCurrentChars(BuildContext context, String id) async {
    await processRequest<CharsEntity?>(
        request: () => _charsRepository.getChars(id),
        onSuccess: (success) => {_setCurrentChars(context, success.data!)},
        onFailure: (failure) =>
            Fluttertoast.showToast(msg: "Access information failed!"));
  }

  static CharsController get findOrInitialize {
    try {
      return Get.find<CharsController>();
    } catch (e) {
      return Get.put(CharsController(), permanent: true);
    }
  }
}

class CharsBinding implements Bindings {
  @override
  void dependencies() {
    CharsController.findOrInitialize;
  }
}
