import 'dart:async';
import 'dart:math';

import 'package:ar_zoo_explorers/app/languages/language_key.dart';
import 'package:ar_zoo_explorers/app/theme/colors.dart';
import 'package:ar_zoo_explorers/base/base_state.dart';
import 'package:ar_zoo_explorers/core/data/controller/question_controller.dart';
import 'package:ar_zoo_explorers/domain/entities/question_entity.dart';
import 'package:ar_zoo_explorers/features/puzzleworddetail/presentation/puzzle_word_detail_cubit.dart';
import 'package:ar_zoo_explorers/features/puzzleworddetail/presentation/puzzle_word_detail_state.dart';
import 'package:ar_zoo_explorers/utils/widget/congratulation_widget.dart';
import 'package:ar_zoo_explorers/utils/widget/custom_back_button.dart';
import 'package:ar_zoo_explorers/utils/widget/image_svg_url_custom.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

@RoutePage()
class PuzzleWordDetailPage extends StatefulWidget {
  const PuzzleWordDetailPage({super.key});

  @override
  State createState() => _State();
}

class _State extends BaseState<PuzzleWordDetailState, PuzzleWordDetailCubit,
    PuzzleWordDetailPage> {
  final questionController = QuestionController.findOrInitialize;
  AudioPlayer audioPlayer = AudioPlayer();
  List<String>? arrayBtns;
  int indexQues = 0; // current index question
  int hintCount = 0;
  bool isFull = false;
  bool isDone = false;
  QuestionEntity? currentQues;

  @override
  void initState() {
    super.initState();
    cubit.init();
  }

  @override
  void dispose() {
    super.dispose();
    audioPlayer.dispose();
  }

  @override
  Widget buildByState(BuildContext context, PuzzleWordDetailState state) {
    if (state.questionEntities != null && state.questionEntities!.isNotEmpty) {
      currentQues = state.questionEntities![indexQues];
      if (arrayBtns == null) {
        int totalKeywords = 16;
        arrayBtns = cubit.generateKeywords(currentQues!.answer, totalKeywords);
        generateHint(answer: currentQues!.answer);
      }
    }

    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        Navigator.of(context).pop();
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
                      _renderKeyword(currentQues: currentQues!),
                    ],
                  ),
                  if (isDone)
                    const Positioned(
                        bottom: 100, child: CongratulationWidget()),
                ],
              )
            : Container(),
      ),
    );
  }

  generateHint({required String answer}) async {
    QuestionEntity currentQues = state.questionEntities![indexQues];
    final List<String> wl = [answer];
    currentQues.puzzles = List.generate(wl[0].split("").length, (index) {
      return WordFindChar(
          correctValue: currentQues.answer.split("")[index].toUpperCase());
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

      setState(() {});

      if (fieldCompleteCorrect(currentQues: currentQues)) {
        isDone = true;
        setState(() {
          Timer(const Duration(seconds: 3), () {
            audioPlayer.stop();
            setState(() {
              isDone = false;
              indexQues++;
              if (indexQues >= state.questionEntities!.length) {
                indexQues = 0;
              }
              resetStateForNextQuestion();
            });
          });
        });

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
    return answeredString == currentQues.answer.toUpperCase();
  }

  Widget _renderKeyword({required QuestionEntity currentQues}) {
    return Container(
      padding: const EdgeInsets.all(10),
      alignment: Alignment.center,
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          childAspectRatio: 1,
          crossAxisCount: 8,
          crossAxisSpacing: 4,
          mainAxisSpacing: 4,
        ),
        itemCount: arrayBtns!.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          bool statusBtn = currentQues.puzzles!
                  .indexWhere((puzzle) => puzzle.currentIndex == index) >=
              0;

          Color color = statusBtn ? Colors.white70 : const Color(0xff7EE7FD);

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
                      return Theme.of(context)
                          .colorScheme
                          .primary
                          .withOpacity(0.5);
                    }
                    return const Color(0xff7EE7FD);
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
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
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
                  if (puzzle.hintShow || isDone) return;

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
                  width: constraints.biggest.width / 7 - 6,
                  height: constraints.biggest.width / 7 - 6,
                  margin: const EdgeInsets.all(3),
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
          );
        },
      ),
    );
  }

  void resetStateForNextQuestion() {
    arrayBtns = null;
    hintCount = 0;
    isFull = false;
    isDone = false;
    currentQues = null;
  }
}
