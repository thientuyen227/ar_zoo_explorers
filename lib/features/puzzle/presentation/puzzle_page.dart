import 'package:ar_zoo_explorers/app/config/app_router.gr.dart';
import 'package:ar_zoo_explorers/app/languages/language_key.dart';
import 'package:ar_zoo_explorers/app/theme/colors.dart';
import 'package:ar_zoo_explorers/base/base_state.dart';
import 'package:ar_zoo_explorers/core/data/controller/auth_controller.dart';
import 'package:ar_zoo_explorers/core/data/controller/user_question_controller.dart';
import 'package:ar_zoo_explorers/domain/entities/learning_category_entity.dart';
import 'package:ar_zoo_explorers/domain/entities/user_question_entity.dart';
import 'package:ar_zoo_explorers/features/puzzle/components/dialog_continue.dart';
import 'package:ar_zoo_explorers/features/puzzle/presentation/puzzle_cubit.dart';
import 'package:ar_zoo_explorers/features/puzzle/presentation/puzzle_state.dart';
import 'package:ar_zoo_explorers/utils/widget/custom_back_button.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

@RoutePage()
class PuzzlePage extends StatefulWidget {
  const PuzzlePage({super.key});

  @override
  State createState() => _State();
}

class _State extends BaseState<PuzzleState, PuzzleCubit, PuzzlePage> {
  int indexQuestion = 0;
  final languageCode = Get.locale?.languageCode;
  AuthController authController = AuthController.findOrInitialize;
  UserQuestionController userQuestionController =
      UserQuestionController.findOrInitialize;

  UserQuestionEntity? userQuestionEntity =
      UserQuestionEntity(id: '', userId: '', learningId: '', indexQuestion: {});

  @override
  void initState() {
    super.initState();
    cubit.showLoading();
    cubit.init(context);
    cubit.hideLoading();
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              LanguageKeys.choose_topic.tr,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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
                          onTap: () async {
                            userQuestionEntity = await userQuestionController
                                .getUserQuestionByUser(
                                    context,
                                    authController.currentUser.value.id,
                                    state.learningcategories![index].id);

                            if (userQuestionEntity != null) {
                              indexQuestion = userQuestionEntity!
                                  .indexQuestion[languageCode]!;
                              showDialog(
                                  barrierDismissible: false,
                                  context: context,
                                  builder: (context) {
                                    return SizedBox(
                                        height: 110,
                                        width: 80,
                                        child: DialogContinue(
                                          state: state,
                                        ));
                                  }).then((value) async {
                                if (value == true) {
                                  context.router.push(PuzzleDetailRoute(
                                      categoryId:
                                          state.learningcategories![index].id,
                                      continueQuestion: indexQuestion));
                                } else {
                                  context.router.push(PuzzleDetailRoute(
                                      categoryId:
                                          state.learningcategories![index].id,
                                      continueQuestion: 0));
                                }
                              });
                            } else {
                              context.router.push(PuzzleDetailRoute(
                                  categoryId:
                                      state.learningcategories![index].id,
                                  continueQuestion: 0));
                            }
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
              // Padding(
              //   padding: const EdgeInsets.only(left: 20.0),
              //   child: Row(
              //     crossAxisAlignment: CrossAxisAlignment.start,
              //     children: [
              //       Text(level),
              //     ],
              //   ),
              // )
            ],
          ),
        ),
      ),
    );
  }
}
