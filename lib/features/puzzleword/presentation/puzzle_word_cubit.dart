import 'dart:math';

import 'package:ar_zoo_explorers/base/base_cubit.dart';
import 'package:ar_zoo_explorers/core/data/controller/question_controller.dart';
import 'package:ar_zoo_explorers/domain/entities/question_entity.dart';
import 'package:ar_zoo_explorers/features/puzzleword/presentation/puzzle_word_state.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:injectable/injectable.dart';
import 'package:remove_diacritic/remove_diacritic.dart';

@injectable
class PuzzleWordCubit extends BaseCubit<PuzzleWordState> {
  PuzzleWordCubit() : super(PuzzleWordState());

  Future<void> init(
      {required BuildContext context, required String vocabularyId}) async {
    final questionController = QuestionController.findOrInitialize;
    Size mediaSize = MediaQueryData.fromView(
            WidgetsBinding.instance.platformDispatcher.views.single)
        .size;
    showLoading();
    List<QuestionEntity>? questionEntities =
        await questionController.getAllQuestions(context);
    emit(state.copyWith(
        height: mediaSize.height,
        width: mediaSize.width,
        questionEntities: questionEntities?.where((element) {
          return element.vocabularyId == vocabularyId;
        }).toList()));
    hideLoading();
  }

  String audioUrl =
      "https://firebasestorage.googleapis.com/v0/b/ar-zoo-explorers.appspot.com/o/effects%2Fsounds%2Fcongratulation.mp3?alt=media&token=b594bde8-46e7-408d-b158-90a172a968c0";
  Duration duration = const Duration(seconds: 20, minutes: 1);
  Duration position = const Duration(seconds: 5, minutes: 0);
  bool isPlaying = false;

  PlayerState audioState = PlayerState.stopped;
  double volumeValue = 0.5;
  bool isLoop = false;
  final languageCode = Get.locale?.languageCode;

  List<String> generateKeywords(String answer, int totalKeywords) {
    List<String> keywords = removeDiacritics(answer).toUpperCase().split('');
    List<String> alphabetChars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'.split('');
    int missingKeywordsCount = totalKeywords - keywords.length;
    if (missingKeywordsCount > 0) {
      Random random = Random();
      for (int i = 0; i < missingKeywordsCount; i++) {
        int randomIndex = random.nextInt(alphabetChars.length);
        keywords.add(alphabetChars[randomIndex]);
      }
    }
    keywords.shuffle();

    return keywords;
  }
}
