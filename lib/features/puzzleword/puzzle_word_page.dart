import 'package:ar_zoo_explorers/app/config/routes.dart';
import 'package:ar_zoo_explorers/app/languages/language_key.dart';
import 'package:ar_zoo_explorers/app/theme/colors.dart';
import 'package:ar_zoo_explorers/base/base_state.dart';
import 'package:ar_zoo_explorers/features/puzzleword/puzzle_word_cubit.dart';
import 'package:ar_zoo_explorers/features/puzzleword/puzzle_word_state.dart';
import 'package:ar_zoo_explorers/utils/widget/custom_back_button.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

@RoutePage()
class PuzzleWordPage extends StatefulWidget {
  const PuzzleWordPage({super.key});

  @override
  State createState() => _State();
}

class _State
    extends BaseState<PuzzleWordState, PuzzleWordCubit, PuzzleWordPage> {
  // final controller = AuthController.findOrInitialize;

  // final _formKey = GlobalKey<FormBuilderState>();
  List<String> answers = ["Bear", "Lion", "Giraffe", "Elephant"];
  // String? selectedAnswer;
  // String answerTrue = "Lion";
  // bool? isSelected;
  // bool? isCorrect;
  int? selectedAnswerIndex;
  int questionIndex = 0;
  void pickAnswer(int value) {
    selectedAnswerIndex = value;

    setState(() {});
  }

  @override
  Widget buildByState(BuildContext context, PuzzleWordState state) {
    // final question = questions[questionIndex];
    var items = cubit.topics;
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Level 1",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Text(
              LanguageKeys.choose_topic.tr,
              style: const TextStyle(fontSize: 14),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.8,
                    crossAxisSpacing: 20),
                itemCount: items.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      context.router.pushNamed(Routes.puzzleworddetail);
                    },
                    child: _renderTopic(
                        title: items[index].title!,
                        image: items[index].image!,
                        level: items[index].level!),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _renderTopic(
      {required String title, required String image, required String level}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 13.0),
      child: Container(
        height: 300,
        decoration: BoxDecoration(
          border: Border.all(),
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          color: AppColor.tinintIce,
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                image,
                height: 95,
                width: 95,
              ),
              Text(
                title,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Container(
                padding: const EdgeInsets.only(top: 10, bottom: 10),
                width: 100,
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      childAspectRatio: 10,
                      crossAxisSpacing: 3),
                  itemCount: 3,
                  itemBuilder: (context, index) {
                    return Container(
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          color: AppColor.white),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(level),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
