import 'dart:math';

import 'package:ar_zoo_explorers/base/base_cubit.dart';
import 'package:ar_zoo_explorers/core/data/controller/question_controller.dart';
import 'package:ar_zoo_explorers/domain/entities/question_entity.dart';
import 'package:ar_zoo_explorers/features/puzzledetail/presentation/puzzle_detail_state.dart';
import 'package:flutter/widgets.dart';
import 'package:injectable/injectable.dart';

@injectable
class PuzzleDetailCubit extends BaseCubit<PuzzleDetailState> {
  PuzzleDetailCubit() : super(PuzzleDetailState());

  Future<void> init(
      {required BuildContext context, required String categoryId}) async {
    final questionController = QuestionController.findOrInitialize;
    Size mediaSize = MediaQueryData.fromView(
            WidgetsBinding.instance.platformDispatcher.views.single)
        .size;

    List<QuestionEntity>? allQuestions =
        await questionController.getAllQuestions(context);
    List<QuestionEntity> categoryQuestions =
        _filterQuestionsByCategory(allQuestions!, categoryId);

    List<List<String>?> answersList = categoryQuestions.map((question) {
      List<String> answers = _prepareAnswersList(categoryQuestions, question);
      return answers;
    }).toList();

    emit(state.copyWith(
        height: mediaSize.height,
        width: mediaSize.width,
        answersList: answersList,
        questionEntities: categoryQuestions));
  }

  List<QuestionEntity> _filterQuestionsByCategory(
      List<QuestionEntity> questions, String categoryId) {
    return questions
        .where((question) => question.categoryId == categoryId)
        .toList();
  }

  List<String> _prepareAnswersList(
      List<QuestionEntity> categoryQuestions, QuestionEntity question) {
    List<String> otherAnswers =
        _getRandomAnswers(categoryQuestions, question.id, 3);
    List<String> answers = [question.answer, ...otherAnswers];
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
      otherAnswers.add(randomQuestion.answer);
    }
    return otherAnswers;
  }
}
