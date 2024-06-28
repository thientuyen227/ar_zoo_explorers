import 'package:ar_zoo_explorers/core/data/controller/auth_controller.dart';
import 'package:ar_zoo_explorers/core/helpers/controller_helper.dart';
import 'package:ar_zoo_explorers/core/repositories/writing_practice_user_respository_implement.dart';
import 'package:ar_zoo_explorers/domain/entities/writing_practice_user_entity.dart';
import 'package:ar_zoo_explorers/domain/repositories/writing_practice_user_respository.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class WritingPracticeController extends ControllerHelper {
  // final WritingPracticeRepository _writingPracticeRepository =
  //     WritingPracticeRepositoryImplement();
  final WritingPracticeUserRepository _writingPracticeUserRepository =
      WritingPracticeUserRepositoryImplement();
  AuthController? authController;

  Rx<WritingPracticeUserEntity> currentWritingPracticeUser = Rx(
      WritingPracticeUserEntity(
          id: '', userId: '', practicedImagePaths: {}, writingPracticeId: ''));

  // Rx<List<WritingPracticeEntity>> listWritingPractice = Rx([]);

  // Rx<String> searchValue = Rx("");

  // Future<WritingPracticeEntity?> getWritingPractice(
  //     BuildContext context, String writingPracticeId) {
  //   return processRequest<WritingPracticeEntity?>(
  //       request: () =>
  //           _writingPracticeRepository.getWritingPractice(writingPracticeId),
  //       onSuccess: (success) =>
  //           {_setCurrentWritingPractice(context, success.data!)},
  //       onFailure: (failure) =>
  //           Fluttertoast.showToast(msg: "Access information failed!"));
  // }

  Future<WritingPracticeUserEntity?> getWritingPracticeByUser(
      BuildContext context, String userId, String writingPracticeId) {
    return processRequest<WritingPracticeUserEntity?>(
        request: () => _writingPracticeUserRepository.getWritingPracticeUser(
            context, userId, writingPracticeId),
        onSuccess: (success) => success.data,
        onFailure: (failure) =>
            Fluttertoast.showToast(msg: "Access information failed!"));
  }

  Future<WritingPracticeUserEntity?> createOrGetWritingPracticeByUser(
      BuildContext context,
      String userId,
      WritingPracticeUserEntity writingPracticeUserEntity) {
    return processRequest<WritingPracticeUserEntity?>(
        request: () =>
            _writingPracticeUserRepository.createOrGetWritingPractice(
                context, userId, writingPracticeUserEntity),
        onSuccess: (success) => {_setCurrentWritingPracticeUser(success.data!)},
        onFailure: (failure) =>
            Fluttertoast.showToast(msg: "Access information failed!"));
  }

  Future<WritingPracticeUserEntity?> updateWritingPracticeByUser(
      BuildContext context,
      WritingPracticeUserEntity writingPracticeUserEntity) async {
    return processRequest<WritingPracticeUserEntity?>(
        request: () => _writingPracticeUserRepository.updateWritingPracticeUser(
            context, writingPracticeUserEntity),
        onSuccess: (success) => {_setCurrentWritingPracticeUser(success.data!)},
        onFailure: (failure) =>
            Fluttertoast.showToast(msg: "Access information failed!"));
  }

  Future<String> uploadPractice(
      BuildContext context, Uint8List imageBytes, String imageName) async {
    return processRequest<String>(
        request: () => _writingPracticeUserRepository.uploadImageToFirebase(
            context, imageBytes, imageName),
        onSuccess: (success) => {success.data},
        onFailure: (failure) =>
            {Fluttertoast.showToast(msg: "Image upload unsuccessful!")});
  }

  _setCurrentWritingPracticeUser(WritingPracticeUserEntity entity) {
    currentWritingPracticeUser.value = entity;
    update();
  }

  // _setCurrentWritingPractice(
  //     BuildContext context, WritingPracticeEntity entity) {
  //   currentWritingPractice.value = entity;
  //   update();
  // }

  // Future<List<WritingPracticeEntity>?> getAllWritingPractices() {
  //   return processRequest<List<WritingPracticeEntity>?>(
  //       request: () => _writingPracticeRepository.getAllWritingPractice(),
  //       onFailure: (failure) =>
  //           Fluttertoast.showToast(msg: "Access information failed!"),
  //       onSuccess: (success) => {_setListWritingPractice(success.data!)});
  // }

  // _setListWritingPractice(List<WritingPracticeEntity> listEntity) {
  //   listWritingPractice.value = listEntity;
  //   update();
  // }

  // Future<void> setSearchValue(BuildContext context, String value) async {
  //   searchValue.value = value;
  // }

  // Future<void> resetCurrentValue(BuildContext context) async {
  //   currentWritingPractice.value = WritingPracticeEntity(
  //     id: '',
  //     nameChar: '',
  //     imagePaths: {},
  //   );
  //   searchValue.value = "";
  //   update;
  // }

  static WritingPracticeController get findOrInitialize {
    try {
      return Get.find<WritingPracticeController>();
    } catch (e) {
      return Get.put(WritingPracticeController(), permanent: true);
    }
  }
}

class WritingPracticeBinding implements Bindings {
  @override
  void dependencies() {
    WritingPracticeController.findOrInitialize;
  }
}
