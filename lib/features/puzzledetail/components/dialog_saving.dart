import 'package:ar_zoo_explorers/app/languages/language_key.dart';
import 'package:ar_zoo_explorers/app/theme/colors.dart';
import 'package:ar_zoo_explorers/app/theme/icons.dart';
import 'package:ar_zoo_explorers/core/data/controller/auth_controller.dart';
import 'package:ar_zoo_explorers/core/data/controller/user_question_controller.dart';
import 'package:ar_zoo_explorers/domain/entities/user_question_entity.dart';
import 'package:ar_zoo_explorers/features/puzzledetail/presentation/puzzle_detail_cubit.dart';
import 'package:ar_zoo_explorers/features/puzzledetail/presentation/puzzle_detail_state.dart';
import 'package:ar_zoo_explorers/utils/widget/image_svg_url_custom.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DialogSaving extends StatefulWidget {
  const DialogSaving(
      {super.key,
      required this.state,
      required this.indexQuestion,
      required this.learningId});
  final PuzzleDetailState state;
  final int indexQuestion;
  final String learningId;

  @override
  State<DialogSaving> createState() => _DialogSavingState();
}

class _DialogSavingState extends State<DialogSaving> {
  final languageCode = Get.locale?.languageCode;
  AuthController authController = AuthController.findOrInitialize;
  UserQuestionController userQuestionController =
      UserQuestionController.findOrInitialize;

  PuzzleDetailCubit cubit = PuzzleDetailCubit();
  UserQuestionEntity userQuestionEntity =
      UserQuestionEntity(id: '', userId: '', learningId: '', indexQuestion: {});
  bool isSaving = false;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Container(
        height: widget.state.height * 0.4,
        width: widget.state.width * 0.9,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          border: Border.all(width: 8, color: AppColor.vibrantYellow),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.5),
              spreadRadius: 8,
              blurRadius: 5,
              offset: const Offset(0, 4),
            ),
          ],
          image: const DecorationImage(
            image: AssetImage(AppImages.backgroundDialog),
            fit: BoxFit.cover,
          ),
        ),
        child: renderTitleAndSpell(context),
      ),
    );
  }

  Widget renderTitleAndSpell(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.all(8),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Center(
            child: ImageSvgUrlCustom(
              imagePath: AppImages.imgDialogSave,
              height: 150,
              width: 150,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              LanguageKeys.savingQuestion.tr,
              style: const TextStyle(fontSize: 20, fontFamily: 'Coiny-Regular'),
            ),
          ),
          if (!isSaving) ...{
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    context.router.pop(false);
                  },
                  style: const ButtonStyle(
                      alignment: Alignment.center,
                      backgroundColor: MaterialStatePropertyAll(Colors.red)),
                  child: const ImageSvgUrlCustom(
                    imagePath: AppIcons.icClose,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(
                  width: 100,
                ),
                ElevatedButton(
                  onPressed: () async {
                    setState(() {
                      isSaving = true;
                    });
                    var currentUserQuestion =
                        userQuestionController.currentUserQuestionUser.value;

                    currentUserQuestion.indexQuestion[languageCode!] =
                        widget.indexQuestion;
                    userQuestionEntity = userQuestionEntity.copyWith(
                      userId: authController.currentUser.value.id,
                      learningId: widget.learningId,
                      indexQuestion: currentUserQuestion.indexQuestion,
                    );
                    var userQuestionEntityUpdate = await userQuestionController
                        .createOrGetUserQuestionByUserByUser(
                            context, userQuestionEntity);
                    await userQuestionController.updateUserQuestionByUser(
                        context, userQuestionEntityUpdate!);
                    setState(() {
                      isSaving = false;
                    });

                    context.router.pop(true);
                  },
                  style: const ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(Colors.green)),
                  child: const ImageSvgUrlCustom(
                    imagePath: AppIcons.icTick,
                    color: Colors.white,
                  ),
                ),
              ],
            )
          } else ...{
            const SizedBox(height: 16),
            const CircularProgressIndicator(),
          }
        ],
      ),
    );
  }
}
