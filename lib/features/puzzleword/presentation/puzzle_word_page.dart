import 'package:ar_zoo_explorers/app/config/app_router.gr.dart';
import 'package:ar_zoo_explorers/app/languages/language_key.dart';
import 'package:ar_zoo_explorers/app/theme/colors.dart';
import 'package:ar_zoo_explorers/base/base_state.dart';
import 'package:ar_zoo_explorers/domain/entities/learning_category_entity.dart';
import 'package:ar_zoo_explorers/features/puzzleword/presentation/puzzle_word_cubit.dart';
import 'package:ar_zoo_explorers/features/puzzleword/presentation/puzzle_word_state.dart';
import 'package:ar_zoo_explorers/utils/widget/custom_back_button.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

@RoutePage()
class PuzzleWordPage extends StatefulWidget {
  const PuzzleWordPage({super.key});

  @override
  State createState() => _State();
}

class _State
    extends BaseState<PuzzleWordState, PuzzleWordCubit, PuzzleWordPage> {
  int? selectedAnswerIndex;
  int questionIndex = 0;
  void pickAnswer(int value) {
    selectedAnswerIndex = value;

    setState(() {});
  }

  @override
  void initState() {
    cubit.init(context);
    super.initState();
  }

  @override
  Widget buildByState(BuildContext context, PuzzleWordState state) {
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
            state.height != 0
                ? Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: state.width * 1.8 / state.height,
                          crossAxisSpacing: 20),
                      itemCount: state.learningcategories!.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            context.router.push(PuzzleWordDetailRoute(
                                categoryId:
                                    state.learningcategories![index].id));
                          },
                          child: _renderTopic(
                              title:
                                  state.learningcategories![index].nameLocalize,
                              image: state.learningcategories![index].imagePath,
                              level: "level1"),
                        );
                      },
                    ),
                  )
                : Container()
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
              Lottie.asset(image, height: 95, width: 95),
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
