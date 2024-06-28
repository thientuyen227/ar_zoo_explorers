import 'dart:math';

import 'package:ar_zoo_explorers/base/base_cubit.dart';
import 'package:ar_zoo_explorers/core/data/controller/question_controller.dart';
import 'package:ar_zoo_explorers/domain/entities/question_entity.dart';
import 'package:ar_zoo_explorers/features/puzzle/presentation/puzzle_state.dart';
import 'package:flutter/widgets.dart';
import 'package:injectable/injectable.dart';

@injectable
class PuzzleCubit extends BaseCubit<PuzzleState> {
  PuzzleCubit() : super(PuzzleState());
  Future<void> init(
    BuildContext context,
  ) async {
    final questionController = QuestionController.findOrInitialize;
    Size mediaSize = MediaQueryData.fromView(
            WidgetsBinding.instance.platformDispatcher.views.single)
        .size;
    List<QuestionEntity>? questions =
        await questionController.getAllQuestions(context);
    List<List<String>?> answersList = questions!.map((question) {
      String currentAnswer = question.answer;
      List<String> otherAnswers = _getRandomAnswers(questions, question.id, 3);
      List<String> answers = [currentAnswer, ...otherAnswers];
      answers.shuffle();

      return answers;
    }).toList();
    emit(state.copyWith(
        height: mediaSize.height,
        width: mediaSize.width,
        answersList: answersList,
        questionEntities: questions));
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
