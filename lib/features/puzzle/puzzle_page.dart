import 'package:ar_zoo_explorers/app/languages/language_key.dart';
import 'package:ar_zoo_explorers/app/theme/colors.dart';
import 'package:ar_zoo_explorers/app/theme/icons.dart';
import 'package:ar_zoo_explorers/base/base_state.dart';
import 'package:ar_zoo_explorers/features/puzzle/model/questions.dart';
import 'package:ar_zoo_explorers/features/puzzle/puzzle_cubit.dart';
import 'package:ar_zoo_explorers/features/puzzle/puzzle_state.dart';
import 'package:ar_zoo_explorers/utils/widget/custom_back_button.dart';
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
  // final controller = AuthController.findOrInitialize;

  // final _formKey = GlobalKey<FormBuilderState>();
  List<String> answers = ["Bear", "Lion", "Giraffe", "Elephant"];
  int? selectedAnswerIndex;
  int questionIndex = 0;
  void pickAnswer(int value) {
    selectedAnswerIndex = value;

    setState(() {});
  }

  @override
  Widget buildByState(BuildContext context, PuzzleState state) {
    final question = questions[questionIndex];
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
      body: Column(
        children: [
          const SizedBox(
            height: 80,
          ),
          SizedBox(
            height: 300,
            width: double.infinity,
            child: Stack(
              children: [
                Positioned(
                  left: 35,
                  top: 35,
                  child: Container(
                    height: 226,
                    width: 336,
                    decoration: BoxDecoration(
                      border: Border.all(),
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      color: AppColor.white,
                    ),
                  ),
                ),
                Positioned(
                    left: 45,
                    top: 45,
                    child: Container(
                      height: 226,
                      width: 336,
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        border: Border.all(),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                        color: AppColor.tinintIce,
                      ),
                      child: renderVocabulary(),
                    )),
                Positioned(
                    top: 120,
                    child: Image.asset(
                      AppImages.imgPuzzleDesign,
                      height: 80,
                      width: 80,
                    )),
              ],
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 2.35,
              crossAxisSpacing: 5,
            ),
            itemCount: answers.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: selectedAnswerIndex == null
                    ? () => pickAnswer(index)
                    : null,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      renderAnswer(
                        currentIndex: index,
                        question: question.options[index],
                        isSelected: selectedAnswerIndex == index,
                        selectedAnswerIndex: selectedAnswerIndex,
                        correctAnswerIndex: question.correctAnswerIndex,
                      )
                    ],
                  ),
                ),
              );
            },
          )
        ],
      ),
    );
  }

  Widget renderAnswer({
    required String question,
    required bool isSelected,
    required int? correctAnswerIndex,
    required int? selectedAnswerIndex,
    required int currentIndex,
  }) {
    bool isCorrectAnswer = currentIndex == correctAnswerIndex;
    bool isWrongAnswer = !isCorrectAnswer && isSelected;

    return selectedAnswerIndex != null
        ? Container(
            decoration: BoxDecoration(
                color: isCorrectAnswer
                    ? AppColor.completed
                    : isWrongAnswer
                        ? AppColor.isFalse
                        : AppColor.vibrantYellow,
                border: Border.all(),
                borderRadius: const BorderRadius.all(Radius.circular(10))),
            child: Padding(
              padding: const EdgeInsets.only(
                  right: 50, left: 50, top: 15, bottom: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    question,
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
                  right: 50, left: 50, top: 15, bottom: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    question,
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
          padding: const EdgeInsets.all(15.0),
          child: SvgPicture.asset(
            AppImages.imgLionBaby,
            height: 80,
            width: 80,
          ),
        ),
        const Text(
          "/ˈlaɪən/",
          style: TextStyle(fontSize: 18),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 30.0, left: 30),
          child: Row(
            children: [
              GestureDetector(
                onTap: () {},
                child: Image.asset(
                  AppIcons.icSnail,
                  height: 45,
                  width: 45,
                ),
              ),
              const Spacer(),
              SvgPicture.asset(
                AppIcons.icSound,
                height: 45,
                width: 45,
              )
            ],
          ),
        ),
      ],
    );
  }
}
