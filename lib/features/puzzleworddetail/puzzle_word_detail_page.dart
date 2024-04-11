import 'package:ar_zoo_explorers/app/languages/language_key.dart';
import 'package:ar_zoo_explorers/app/theme/colors.dart';
import 'package:ar_zoo_explorers/app/theme/icons.dart';
import 'package:ar_zoo_explorers/base/base_state.dart';
import 'package:ar_zoo_explorers/features/puzzleworddetail/puzzle_word_detail_cubit.dart';
import 'package:ar_zoo_explorers/features/puzzleworddetail/puzzle_word_detail_state.dart';
import 'package:ar_zoo_explorers/utils/widget/custom_back_button.dart';
import 'package:ar_zoo_explorers/utils/widget/text_field_widget.dart';
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
  @override
  Widget buildByState(BuildContext context, PuzzleWordDetailState state) {
    // final question = questions[questionIndex];
    // var items = cubit.topics;
    var answer = "FOXXXXXXXXxxxxxxxxx";
    var question = "Which animal is this?";
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
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Column(
                children: [
                  const SizedBox(
                    height: 50,
                  ),
                  _renderQuestion(question: question),
                  Container(
                    decoration: BoxDecoration(
                        border: Border.all(),
                        borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(5),
                            bottomRight: Radius.circular(5))),
                    height: 336,
                    width: 287,
                    child: Padding(
                      padding: const EdgeInsets.all(21.0),
                      child: Image.asset(
                        AppImages.imgFox,
                        height: 244,
                        width: 244,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  SizedBox(
                    width: 500,
                    child: Wrap(
                      alignment: WrapAlignment.center,
                      children: List.generate(answer.length, (index) {
                        return Padding(
                          padding:
                              const EdgeInsets.only(right: 16.0, bottom: 8),
                          child: _renderAnswer(),
                        );
                      }),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  )
                ],
              ),
            ),
          ],
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

  Widget _renderAnswer() {
    return Container(
      alignment: Alignment.center,
      height: 54,
      width: 54,
      decoration: const BoxDecoration(
          color: AppColor.yellow,
          borderRadius: BorderRadius.all(Radius.circular(10))),
      child: const Center(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: AppTextFormField(
            textAlign: TextAlign.center,
            maxLength: 1,
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
