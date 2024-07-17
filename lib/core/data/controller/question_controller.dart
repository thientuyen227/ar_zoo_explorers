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
      vocabularyId: '',
      answers: {},
      questions: {},
      image: '',
      options: [],
      puzzles: []));

  Rx<List<QuestionEntity>> listQuestion = Rx([]);

  Rx<String> searchValue = Rx("");

  Future<QuestionEntity?> getQuestion(BuildContext context, String questionId) {
    return processRequest<QuestionEntity?>(
        request: () => _questionRepository.getQuestion(context, questionId),
        onSuccess: (success) => {_setCurrentQuestion(context, success.data!)},
        onFailure: (failure) =>
            Fluttertoast.showToast(msg: "Access information failed!"));
  }

  _setCurrentQuestion(BuildContext context, QuestionEntity entity) {
    currentQuestion.value = entity;
    update();
  }

  Future<List<QuestionEntity>?> getAllQuestions(
    BuildContext context,
  ) {
    return processRequest<List<QuestionEntity>?>(
        request: () => _questionRepository.getAllQuestion(context),
        onFailure: (failure) =>
            Fluttertoast.showToast(msg: "Access information failed!"),
        onSuccess: (success) => {_setListQuestion(success.data!)});
  }

  _setListQuestion(List<QuestionEntity> listEntity) {
    listQuestion.value = listEntity;
    update();
  }

  Future<void> setSearchValue(BuildContext context, String value) async {
    searchValue.value = value;
  }

  Future<void> resetCurrentValue(BuildContext context) async {
    currentQuestion.value = QuestionEntity(
        id: '',
        categoryId: '',
        vocabularyId: '',
        questions: {},
        answers: {},
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
