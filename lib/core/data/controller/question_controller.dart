import 'package:ar_zoo_explorers/core/helpers/controller_helper.dart';
import 'package:ar_zoo_explorers/core/repositories/question_repository_implement.dart';
import 'package:ar_zoo_explorers/domain/entities/question_entity.dart';
import 'package:ar_zoo_explorers/domain/repositories/question_repository.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class QuestionController extends ControllerHelper {
  final QuestionRepository _questionRepository = QuestionRepositoryImplement();

  Rx<QuestionEntity> currentQuestion = Rx(QuestionEntity(
      id: '',
      answer: '',
      categoryId: '',
      question: {},
      image: '',
      options: [],
      puzzles: []));

  Rx<List<QuestionEntity>> listQuestion = Rx([]);

  Rx<String> searchValue = Rx("");

  Future<QuestionEntity?> getQuestion(BuildContext context, String QuestionId) {
    return processRequest<QuestionEntity?>(
        request: () => _questionRepository.getQuestion(QuestionId),
        onSuccess: (success) => {_setCurrentQuestion(context, success.data!)},
        onFailure: (failure) =>
            Fluttertoast.showToast(msg: "Access information failed!"));
  }

  _setCurrentQuestion(BuildContext context, QuestionEntity entity) {
    currentQuestion.value = entity;
    update();
  }

  Future<List<QuestionEntity>?> getAllQuestions() {
    return processRequest<List<QuestionEntity>?>(
        request: () => _questionRepository.getAllQuestion(),
        onFailure: (failure) =>
            Fluttertoast.showToast(msg: "Access information failed!"),
        onSuccess: (success) => {_setListQuestion(success.data!)});
  }

  _setListQuestion(List<QuestionEntity> listEntity) {
    listQuestion.value = listEntity;
    update();
  }

  Future<void> updateCurrentQuestion(BuildContext context, String id) async {
    await processRequest<QuestionEntity?>(
        request: () => _questionRepository.getQuestion(id),
        onSuccess: (success) => {_setCurrentQuestion(context, success.data!)},
        onFailure: (failure) =>
            Fluttertoast.showToast(msg: "Access information failed!"));
  }

  Future<QuestionEntity?> updateQuestion(
      BuildContext context, QuestionEntity questionEntity) async {
    return await processRequest(
      request: () => _questionRepository.updateQuestion(questionEntity),
      onFailure: (failure) =>
          Fluttertoast.showToast(msg: "category editing failed"),
      onSuccess: (success) => {
        _setCurrentQuestion(context, success.data!),
        Fluttertoast.showToast(msg: "category editing successful"),
      },
    );
  }

  Future<void> setSearchValue(BuildContext context, String value) async {
    searchValue.value = value;
  }

  Future<void> resetCurrentValue(BuildContext context) async {
    currentQuestion.value = QuestionEntity(
        id: '',
        answer: '',
        categoryId: '',
        question: {},
        image: '',
        options: [],
        puzzles: []);
    searchValue.value = "";
    update;
  }

  static QuestionController get findOrInitialize {
    try {
      return Get.find<QuestionController>();
    } catch (e) {
      return Get.put(QuestionController(), permanent: true);
    }
  }
}

class QuestionBinding implements Bindings {
  @override
  void dependencies() {
    QuestionController.findOrInitialize;
  }
}
