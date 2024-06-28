import 'dart:async';

import 'package:ar_zoo_explorers/app/languages/language_key.dart';
import 'package:ar_zoo_explorers/app/theme/colors.dart';
import 'package:ar_zoo_explorers/app/theme/icons.dart';
import 'package:ar_zoo_explorers/base/base_state.dart';
import 'package:ar_zoo_explorers/domain/entities/question_entity.dart';
import 'package:ar_zoo_explorers/features/puzzle/presentation/puzzle_cubit.dart';
import 'package:ar_zoo_explorers/features/puzzle/presentation/puzzle_state.dart';
import 'package:ar_zoo_explorers/utils/widget/congratulation_widget.dart';
import 'package:ar_zoo_explorers/utils/widget/custom_back_button.dart';
import 'package:ar_zoo_explorers/utils/widget/image_svg_url_custom.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

@RoutePage()
class PuzzlePage extends StatefulWidget {
  const PuzzlePage({super.key});

  @override
  State createState() => _State();
}

class _State extends BaseState<PuzzleState, PuzzleCubit, PuzzlePage> {
  AudioPlayer audioPlayer = AudioPlayer();
  int? selectedAnswerIndex;
  String? selectedAnswer;
  int questionIndex = 0;
  bool? isCorrectAnswer;
  bool? isWrongAnswer;
  int indexQues = 0;
  final languageCode = Get.locale?.languageCode;
  Timer? _timer;

  @override
  void initState() {
    cubit.init(context);
    super.initState();
  }

  @override
  void dispose() {
    _timer?.cancel();
    audioPlayer.dispose();
    super.dispose();
  }

  void pickAnswer({String? value, int? index}) {
    selectedAnswer = value;
    selectedAnswerIndex = index;
    setState(() {
      isCorrectAnswer =
          selectedAnswer == cubit.state.questionEntities![indexQues].answer;

      if (isCorrectAnswer!) {
        _timer = Timer(const Duration(seconds: 3), () {
          audioPlayer.stop();
          setState(() {
            isCorrectAnswer = null;
            indexQues++;
            if (indexQues >= cubit.state.questionEntities!.length) {
              indexQues = 0;
            }
          });
        });
      }
    });
  }

  @override
  Widget buildByState(BuildContext context, PuzzleState state) {
    return Scaffold(
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
      body: state.questionEntities != null && state.questionEntities!.isNotEmpty
          ? Stack(
              children: [
                Column(
                  children: [
                    const SizedBox(
                      height: 50,
                    ),
                    SizedBox(
                      height: state.height * 0.45,
                      width: state.width,
                      child: Stack(
                        children: [
                          Positioned(
                            left: state.width * 0.15,
                            top: state.height * 0.1,
                            child: Container(
                              height: state.height * 0.3,
                              width: state.width * 0.7,
                              decoration: BoxDecoration(
                                border: Border.all(),
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(10)),
                                color: AppColor.white,
                              ),
                            ),
                          ),
                          Positioned(
                            left: state.width * 0.17,
                            top: state.height * 0.11,
                            child: Container(
                              height: state.height * 0.3,
                              width: state.width * 0.7,
                              padding: const EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                border: Border.all(),
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(10)),
                                color: AppColor.tinintIce,
                              ),
                              child: renderVocabulary(),
                            ),
                          ),
                          Positioned(
                            top: state.height * 0.25,
                            left: -20,
                            child: ImageSvgUrlCustom(
                              imagePath: AppImages.imgPuzzleDesign,
                              height: state.height * 0.06,
                              width: state.width * 0.08,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 2.3,
                        crossAxisSpacing: 4.5,
                      ),
                      itemCount: 4,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: selectedAnswerIndex == null
                              ? () => pickAnswer(
                                  value:
                                      state.answersList[questionIndex]![index],
                                  index: index)
                              : null,
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              children: [
                                renderAnswer(
                                  option:
                                      state.answersList[questionIndex]![index],
                                  question: state
                                      .questionEntities![questionIndex]
                                      .questionLocalize,
                                  isSelected: selectedAnswerIndex == index,
                                  selectedAnswerIndex: selectedAnswer,
                                  correctAnswer: state
                                      .questionEntities![questionIndex].answer,
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    )
                  ],
                ),
                if (isCorrectAnswer != null && isCorrectAnswer == true) ...{
                  Positioned(
                      left: 20,
                      right: 20,
                      bottom: state.height * 0.17,
                      child: const CongratulationWidget())
                }
              ],
            )
          : Container(),
    );
  }

  Widget renderAnswer({
    required String option,
    required String question,
    required bool isSelected,
    required String correctAnswer,
    required String? selectedAnswerIndex,
  }) {
    isCorrectAnswer = option == correctAnswer;
    isWrongAnswer = !isCorrectAnswer! && isSelected;

    return selectedAnswerIndex != null
        ? Container(
            decoration: BoxDecoration(
                color: isCorrectAnswer!
                    ? AppColor.completed
                    : isWrongAnswer!
                        ? AppColor.isFalse
                        : AppColor.vibrantYellow,
                border: Border.all(),
                borderRadius: const BorderRadius.all(Radius.circular(10))),
            child: Padding(
              padding: const EdgeInsets.only(
                  right: 30, left: 30, top: 15, bottom: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    option,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
          )
        : Container(
            decoration: BoxDecoration(
                color: AppColor.vibrantYellow,
                border: Border.all(),
                borderRadius: const BorderRadius.all(Radius.circular(10))),
            child: Padding(
              padding: const EdgeInsets.only(
                  right: 30, left: 30, top: 15, bottom: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    option,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
          );
  }

  Widget renderVocabulary() {
    return Column(
      children: [
        Padding(
            padding: const EdgeInsets.only(top: 15.0),
            child: ImageSvgUrlCustom(
              imagePath: state.questionEntities![questionIndex].image!,
              width: state.width * 0.3,
              height: state.height * 0.15,
            )),
        Padding(
          padding: const EdgeInsets.only(right: 30.0, left: 30),
          child: Row(
            children: [
              IconButton(
                onPressed: () {},
                icon: Image.asset(
                  AppIcons.icSnail,
                  height: 45,
                  width: 45,
                ),
              ),
              const Spacer(),
              IconButton(
                  onPressed: () {},
                  icon: SvgPicture.asset(
                    AppIcons.icSound,
                    height: 45,
                    width: 45,
                  ))
            ],
          ),
        ),
      ],
    );
  }
}
