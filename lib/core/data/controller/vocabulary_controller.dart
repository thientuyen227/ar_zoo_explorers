import 'package:ar_zoo_explorers/core/helpers/controller_helper.dart';
import 'package:ar_zoo_explorers/core/repositories/vocabulary_responsitory_implement.dart';
import 'package:ar_zoo_explorers/domain/entities/vocabulary_entity.dart';
import 'package:ar_zoo_explorers/domain/repositories/vocabulary_responsitory.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class VocabularyController extends ControllerHelper {
  final VocabularyRepository _vocabularyRepository =
      VocabularyRepositoryImplement();

  Rx<VocabularyEntity> currentVocabulary = Rx(VocabularyEntity(
    id: '',
    example: {},
    meaning: {},
    categoryId: '',
    modelId: '',
    phoneticTranscription: '',
    status: '',
    thumbnail: '',
    audioExamples: {},
    audioMeanings: {},
    words: {},
    audios: {},
  ));

  Rx<List<VocabularyEntity>> listVocabulary = Rx([]);

  Rx<String> searchValue = Rx("");

  Future<VocabularyEntity?> getVocabulary(
      BuildContext context, String vocabularyId) {
    return processRequest<VocabularyEntity?>(
        request: () =>
            _vocabularyRepository.getVocabulary(context, vocabularyId),
        onSuccess: (success) => {_setCurrentVocabulary(context, success.data!)},
        onFailure: (failure) =>
            Fluttertoast.showToast(msg: "Access information failed!"));
  }

  _setCurrentVocabulary(BuildContext context, VocabularyEntity entity) {
    currentVocabulary.value = entity;
    update();
  }

  Future<List<VocabularyEntity>?> getAllVocabularys(
    BuildContext context,
  ) {
    return processRequest<List<VocabularyEntity>?>(
        request: () => _vocabularyRepository.getAllVocabulary(context),
        onFailure: (failure) =>
            Fluttertoast.showToast(msg: "Access information failed!"),
        onSuccess: (success) => {_setListVocabulary(success.data!)});
  }

  _setListVocabulary(List<VocabularyEntity> listEntity) {
    listVocabulary.value = listEntity;
    listVocabulary.value
        .sort((a, b) => a.wordLocalize.compareTo(b.wordLocalize));
    listVocabulary.refresh();
    update();
  }

  Future<void> updateCurrentVocabulary(BuildContext context, String id) async {
    await processRequest<VocabularyEntity?>(
        request: () => _vocabularyRepository.getVocabulary(context, id),
        onSuccess: (success) => {_setCurrentVocabulary(context, success.data!)},
        onFailure: (failure) =>
            Fluttertoast.showToast(msg: "Access information failed!"));
  }

  Future<void> setSearchValue(BuildContext context, String value) async {
    searchValue.value = value;
  }

  Future<void> resetCurrentValue(BuildContext context) async {
    currentVocabulary.value = VocabularyEntity(
      id: '',
      modelId: '',
      example: {},
      meaning: {},
      categoryId: '',
      phoneticTranscription: '',
      status: '',
      thumbnail: '',
      audioExamples: {},
      audioMeanings: {},
      words: {},
      audios: {},
    );
    searchValue.value = "";
    update;
  }

  static VocabularyController get findOrInitialize {
    try {
      return Get.find<VocabularyController>();
    } catch (e) {
      return Get.put(VocabularyController(), permanent: true);
    }
  }
}

class VocabularyBinding implements Bindings {
  @override
  void dependencies() {
    VocabularyController.findOrInitialize;
  }
}
