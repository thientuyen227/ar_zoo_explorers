import 'package:ar_zoo_explorers/app/languages/language_key.dart';
import 'package:ar_zoo_explorers/app/theme/colors.dart';
import 'package:ar_zoo_explorers/app/theme/icons.dart';
import 'package:ar_zoo_explorers/core/data/controller/auth_controller.dart';
import 'package:ar_zoo_explorers/core/data/controller/user_question_controller.dart';
import 'package:ar_zoo_explorers/domain/entities/user_question_entity.dart';
import 'package:ar_zoo_explorers/features/puzzle/presentation/puzzle_state.dart';
import 'package:ar_zoo_explorers/utils/widget/image_svg_url_custom.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DialogContinue extends StatefulWidget {
  const DialogContinue({super.key, required this.state});
  final PuzzleState state;
  @override
  State<DialogContinue> createState() => _DialogContinueState();
}

class _DialogContinueState extends State<DialogContinue> {
  final languageCode = Get.locale?.languageCode;
  AuthController authController = AuthController.findOrInitialize;
  UserQuestionController userQuestionController =
      UserQuestionController.findOrInitialize;

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
        ],
      ),
    );
  }
}
