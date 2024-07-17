import 'dart:async';
import 'dart:math';

import 'package:ar_zoo_explorers/app/languages/language_key.dart';
import 'package:ar_zoo_explorers/app/theme/colors.dart';
import 'package:ar_zoo_explorers/app/theme/icons.dart';
import 'package:ar_zoo_explorers/base/base_state.dart';
import 'package:ar_zoo_explorers/core/data/controller/auth_controller.dart';
import 'package:ar_zoo_explorers/core/data/controller/question_controller.dart';
import 'package:ar_zoo_explorers/core/data/controller/scoreboard_controller.dart';
import 'package:ar_zoo_explorers/domain/entities/question_entity.dart';
import 'package:ar_zoo_explorers/domain/entities/scoreboard_entity.dart';
import 'package:ar_zoo_explorers/features/puzzleword/presentation/puzzle_word_cubit.dart';
import 'package:ar_zoo_explorers/features/puzzleword/presentation/puzzle_word_state.dart';
import 'package:ar_zoo_explorers/utils/widget/congratulation_widget.dart';
import 'package:ar_zoo_explorers/utils/widget/custom_back_button.dart';
import 'package:ar_zoo_explorers/utils/widget/failures_widget.dart';
import 'package:ar_zoo_explorers/utils/widget/image_svg_url_custom.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:remove_diacritic/remove_diacritic.dart';

@RoutePage()
class PuzzleWordPage extends StatefulWidget {
  const PuzzleWordPage({super.key, required this.vocabularyId});
  final String vocabularyId;

  @override
  State createState() => _State();
}

class _State
    extends BaseState<PuzzleWordState, PuzzleWordCubit, PuzzleWordPage> {
  final questionController = QuestionController.findOrInitialize;
  AuthController authController = AuthController.findOrInitialize;
  final scoreboardController = ScoreboardController.findOrInitialize;
  String? modelId;
  AudioPlayer audioPlayer = AudioPlayer();
  List<String>? arrayBtns;
  int indexQues = 0;
  int hintCount = 0;
  bool isFull = false;
  bool isDone = false;
  bool isChose = false;
  QuestionEntity? currentQues;
  ScoreboardEntity scoreboardEntity = ScoreboardEntity(
    id: '',
    userId: '',
    learningId: '',
    vocabularyId: '',
    isAudio: false,
    isQuestion: false,
  );

  @override
  void initState() {
    cubit.showLoading();
    cubit.init(context: context, vocabularyId: widget.vocabularyId);
    cubit.hideLoading();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    audioPlayer.dispose();
  }

  @override
  Widget buildByState(BuildContext context, PuzzleWordState state) {
    if (state.questionEntities != null && state.questionEntities!.isNotEmpty) {
      currentQues = state.questionEntities![indexQues];
      if (arrayBtns == null) {
        int totalKeywords = 16;
        if (removeDiacritics(currentQues!.answerLocalize)
                .replaceAll(' ', '')
                .split("")
                .length >
            16) {
          totalKeywords = 24;
        }
        arrayBtns =
            cubit.generateKeywords(currentQues!.answerLocalize, totalKeywords);
        generateHint(answer: currentQues!.answerLocalize);
      }
    }

    return PopScope(
      canPop: true,
      onPopInvoked: (didPop) {
        context.router.pop();
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(LanguageKeys.puzzle.tr,
              style: const TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.bold)),
          backgroundColor: const Color.fromARGB(255, 109, 189, 255),
          elevation: 1,
          leading: const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [CustomBackButton()]),
        ),
        body: currentQues != null &&
                state.questionEntities != null &&
                state.questionEntities!.isNotEmpty
            ? Stack(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Center(
                                child: Column(
                                  children: [
                                    const SizedBox(
                                      height: 30,
                                    ),
                                    _renderQuestion(
                                        question: state
                                            .questionEntities![indexQues]
                                            .questionLocalize),
                                    _renderImage(
                                        image: state
                                            .questionEntities![indexQues]
                                            .image!),
                                    const SizedBox(
                                      height: 30,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: SizedBox(
                                        width: 500,
                                        child: Wrap(
                                            spacing: 10,
                                            alignment: WrapAlignment.center,
                                            children: [
                                              _renderAnswer(
                                                  currentQues: currentQues!),
                                            ]),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 30,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      isFull && isDone == false
                          ? Column(
                              children: [
                                const FailuresWidget(),
                                IconButton(
                                  icon: const ImageSvgUrlCustom(
                                    imagePath: AppIcons.icReload,
                                    size: 20,
                                  ),
                                  iconSize: 40,
                                  onPressed: () {
                                    resetQuestionState();
                                  },
                                ),
                              ],
                            )
                          : Container(),
                      _renderKeyword(currentQues: currentQues!),
                    ],
                  ),
                  if (isDone) ...[
                    const Positioned(
                        bottom: 100, child: CongratulationWidget()),
                    _renderCorrectAnswer()
                  ],
                ],
              )
            : Container(),
      ),
    );
  }

  Widget _renderCorrectAnswer() {
    return Positioned(
      bottom: 150,
      left: 0,
      right: 0,
      child: Container(
        color: Colors.white,
        padding: const EdgeInsets.all(20),
        child: Text(
          currentQues?.answerLocalize ?? '',
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.green,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  generateHint({required String answer}) async {
    QuestionEntity currentQues = state.questionEntities![indexQues];
    final List<String> wl = [answer];
    currentQues.puzzles = List.generate(
        removeDiacritics(wl[0]).replaceAll(' ', '').split("").length, (index) {
      return WordFindChar(
          correctValue: removeDiacritics(currentQues.answerLocalize)
              .replaceAll(' ', '')
              .split("")[index]
              .toUpperCase());
    });

    List<WordFindChar> puzzleNoHints = currentQues.puzzles!
        .where((puzzle) => !puzzle.hintShow && puzzle.currentIndex == null)
        .toList();

    if (puzzleNoHints.isNotEmpty) {
      hintCount++;
      int indexHint = Random().nextInt(puzzleNoHints.length);
      int countTemp = 0;

      currentQues.puzzles = currentQues.puzzles!.map((puzzle) {
        if (!puzzle.hintShow && puzzle.currentIndex == null) countTemp++;

        if (indexHint == countTemp - 1) {
          puzzle.hintShow = true;
          puzzle.currentValue = puzzle.correctValue?.toUpperCase();
          puzzle.currentIndex = arrayBtns!
              .indexWhere((btn) => btn == puzzle.correctValue?.toUpperCase());
        }

        return puzzle;
      }).toList();

      setState(() {});
    }
  }

  Future<void> setBtnClick(int index) async {
    QuestionEntity currentQues = state.questionEntities![indexQues];

    int currentIndexEmpty = currentQues.puzzles!
        .indexWhere((puzzle) => puzzle.currentValue == null);

    if (currentIndexEmpty >= 0 && arrayBtns!.isNotEmpty) {
      currentQues.puzzles![currentIndexEmpty].currentIndex = index;
      currentQues.puzzles![currentIndexEmpty].currentValue = arrayBtns![index];
      currentQues.puzzles![currentIndexEmpty].isChose = true;

      setState(() {});

      if (fieldCompleteCorrect(currentQues: currentQues)) {
        isDone = true;
        setState(() {
          Timer(const Duration(seconds: 3), () {
            audioPlayer.stop();
            setState(() {
              Navigator.of(context).pop(true);
            });
          });
        });
        scoreboardEntity = scoreboardEntity.copyWith(
            userId: authController.currentUser.value.id,
            learningId: currentQues.categoryId,
            isQuestion: true,
            vocabularyId: currentQues.vocabularyId);
        var scoreboardUserEntity = await scoreboardController
            .createOrGetScoreboardByUserByUser(context, scoreboardEntity);
        await scoreboardController.updateScoreboardByUser(
            context, scoreboardUserEntity!);

        await Future.delayed(const Duration(seconds: 1));
      }
    }
  }

  bool fieldCompleteCorrect({required QuestionEntity currentQues}) {
    bool complete = currentQues.puzzles!
        .where((puzzle) => puzzle.currentValue == null)
        .isEmpty;

    if (!complete) {
      isFull = false;
      return complete;
    }
    isFull = true;
    String answeredString =
        currentQues.puzzles!.map((puzzle) => puzzle.currentValue).join("");
    if (answeredString ==
        removeDiacritics(currentQues.answerLocalize)
            .toUpperCase()
            .replaceAll(' ', '')) {
      return true;
    } else {
      return false;
    }
  }

  Widget _renderKeyword({required QuestionEntity currentQues}) {
    return Container(
      padding: const EdgeInsets.all(10),
      alignment: Alignment.center,
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          childAspectRatio: state.height / (state.width * 2.2),
          crossAxisCount: 8,
          crossAxisSpacing: 4,
          mainAxisSpacing: 4,
        ),
        itemCount: arrayBtns!.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          int puzzleIndex = currentQues.puzzles!
              .indexWhere((puzzle) => puzzle.currentIndex == index);
          bool statusBtn = puzzleIndex >= 0;

          if (statusBtn) {
            currentQues.puzzles![puzzleIndex].isChose = true;
          }
          Color color = statusBtn ? Colors.black : const Color(0xff7EE7FD);
          return Container(
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(10),
            ),
            alignment: Alignment.center,
            child: TextButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.resolveWith<Color>(
                  (Set<MaterialState> states) {
                    if (states.contains(MaterialState.pressed)) {
                      return Colors.red;
                    }
                    return currentQues.puzzles!.any((puzzle) =>
                            puzzle.currentIndex == index && puzzle.isChose!)
                        ? Colors.grey
                        : const Color(0xff7EE7FD);
                  },
                ),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
              onPressed: () {
                if (!statusBtn) {
                  setBtnClick(index);
                }
              },
              child: Text(
                arrayBtns![index],
                style: const TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _renderImage({required String image}) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(),
          borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(5), bottomRight: Radius.circular(5))),
      height: 336,
      width: 287,
      child: Padding(
        padding: const EdgeInsets.all(21.0),
        child: ImageSvgUrlCustom(
          imagePath: image,
          height: 244,
          width: 244,
        ),
      ),
    );
  }

  Widget _renderQuestion({required String question}) {
    return Container(
      padding: const EdgeInsets.only(top: 14, bottom: 14, left: 43, right: 43),
      decoration: BoxDecoration(
          color: AppColor.tinintIce,
          border: Border.all(),
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20))),
      width: 287,
      child: Center(
        child: Text(
          question,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget _renderAnswer({required QuestionEntity currentQues}) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 10),
      alignment: Alignment.center,
      child: Wrap(
        alignment: WrapAlignment.center,
        spacing: 2.5,
        runSpacing: 3,
        children: currentQues.puzzles!.map((puzzle) {
          Color color;

          if (isDone) {
            color = AppColor.green;
          } else if (puzzle.hintShow) {
            color = AppColor.vibrantYellow;
          } else if (isFull) {
            color = Colors.red;
          } else {
            color = const Color(0xff7EE7FD);
          }

          return InkWell(
            onTap: () {
              if (isDone) return;

              isFull = false;
              puzzle.clearValue();
              setState(() {});
            },
            child: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(10),
              ),
              width: 50,
              height: 50,
              child: Text(
                (puzzle.currentValue ?? '').toUpperCase(),
                style: const TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  void resetQuestionState() {
    setState(() {
      int totalKeywords = 16;
      if (removeDiacritics(currentQues!.answerLocalize)
              .replaceAll(' ', '')
              .split("")
              .length >
          16) {
        totalKeywords = 24;
      }
      arrayBtns =
          cubit.generateKeywords(currentQues!.answerLocalize, totalKeywords);

      isFull = false;
      isDone = false;
      for (var puzzle in currentQues!.puzzles!) {
        puzzle.clearValue();
        puzzle.hintShow = false;
      }
      generateHint(answer: currentQues!.answerLocalize);
    });
  }
}
