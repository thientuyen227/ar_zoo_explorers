import 'dart:math';

import 'package:ar_zoo_explorers/app/config/routes.dart';
import 'package:ar_zoo_explorers/base/base_cubit.dart';
import 'package:ar_zoo_explorers/core/data/controller/animal_controller.dart';
import 'package:ar_zoo_explorers/core/data/controller/question_controller.dart';
import 'package:ar_zoo_explorers/core/data/controller/vocabulary_controller.dart';
import 'package:ar_zoo_explorers/domain/entities/question_entity.dart';
import 'package:ar_zoo_explorers/features/puzzledetail/presentation/puzzle_detail_state.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:injectable/injectable.dart';

@injectable
class PuzzleDetailCubit extends BaseCubit<PuzzleDetailState> {
  PuzzleDetailCubit() : super(PuzzleDetailState());
  final vocabularyController = VocabularyController.findOrInitialize;
  final questionController = QuestionController.findOrInitialize;
  final animalController = AnimalController.findOrInitialize;

  final languageCode = Get.locale?.languageCode;
  Future<void> init(
      {required BuildContext context, required String categoryId}) async {
    Size mediaSize = MediaQueryData.fromView(
            WidgetsBinding.instance.platformDispatcher.views.single)
        .size;

    List<QuestionEntity>? allQuestions =
        await questionController.getAllQuestions(context);
    List<QuestionEntity> questionentities =
        _filterQuestionsByCategory(allQuestions!, categoryId);

    List<List<String>?> answersList = questionentities.map((question) {
      List<String> answers = _prepareAnswersList(questionentities, question);
      return answers;
    }).toList();

    emit(state.copyWith(
        height: mediaSize.height,
        width: mediaSize.width,
        answersList: answersList,
        questionEntities: questionentities));
    updateAudioAndModel(context, 0);
  }

  List<QuestionEntity> _filterQuestionsByCategory(
      List<QuestionEntity> questions, String categoryId) {
    return questions
        .where((question) => question.categoryId == categoryId)
        .toList();
  }

  List<String> _prepareAnswersList(
      List<QuestionEntity> questionentities, QuestionEntity question) {
    List<String> otherAnswers =
        _getRandomAnswers(questionentities, question.id, 3);
    List<String> answers = [question.answerLocalize, ...otherAnswers];
    answers.shuffle();
    return answers;
  }

  List<String> _getRandomAnswers(
      List<QuestionEntity> questions, String currentQuestionId, int count) {
    List<String> otherAnswers = [];
    List<QuestionEntity> otherQuestions = questions
        .where((question) => question.id != currentQuestionId)
        .toList();
    while (otherAnswers.length < count && otherQuestions.isNotEmpty) {
      QuestionEntity randomQuestion =
          otherQuestions.removeAt(Random().nextInt(otherQuestions.length));
      otherAnswers.add(randomQuestion.answerLocalize);
    }
    return otherAnswers;
  }

  Future<String> getAudio(BuildContext context, String vocabularyId) async {
    await vocabularyController.getAllVocabularys(context);
    final filteredVocabulary =
        vocabularyController.listVocabulary.value.where((element) {
      return element.id == vocabularyId;
    }).toList();
    return filteredVocabulary.first.audios[languageCode] ?? '';
  }

  Future<String> getModel(BuildContext context, String vocabularyId) async {
    await vocabularyController.getAllVocabularys(context);
    final filteredVocabulary =
        vocabularyController.listVocabulary.value.where((element) {
      return element.id == vocabularyId;
    }).toList();
    return filteredVocabulary.first.modelId ?? '';
  }

  Future<void> updateAudioAndModel(
      BuildContext context, int questionIndex) async {
    if (state.questionEntities == null || state.questionEntities!.isEmpty) {
      return;
    }
    String vocabularyId = state.questionEntities![questionIndex].vocabularyId;
    String audio = await getAudio(context, vocabularyId);
    String modelId = await getModel(context, vocabularyId);
    emit(state.copyWith(audio: audio, modelId: modelId));
  }

  Future<void> navigatorToModel(BuildContext context, String modelId) async {
    await animalController.updateCurrentAnimal(context, modelId);
    context.router.pushNamed(Routes.modeldetail);
  }
}
