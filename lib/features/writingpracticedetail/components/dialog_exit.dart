import 'dart:ui' as ui;

import 'package:ar_zoo_explorers/app/languages/language_key.dart';
import 'package:ar_zoo_explorers/app/theme/colors.dart';
import 'package:ar_zoo_explorers/app/theme/icons.dart';
import 'package:ar_zoo_explorers/core/data/controller/auth_controller.dart';
import 'package:ar_zoo_explorers/core/data/controller/chars_controller.dart';
import 'package:ar_zoo_explorers/core/data/controller/writing_practice_controller.dart';
import 'package:ar_zoo_explorers/domain/entities/writing_practice_user_entity.dart';
import 'package:ar_zoo_explorers/features/writingpracticedetail/presentation/writing_practice_detail_cubit.dart';
import 'package:ar_zoo_explorers/features/writingpracticedetail/presentation/writing_practice_detail_state.dart';
import 'package:ar_zoo_explorers/utils/widget/image_svg_url_custom.dart';
import 'package:auto_route/auto_route.dart';
import 'package:finger_painter/finger_painter.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';

class DialogExit extends StatefulWidget {
  final GlobalKey<State<StatefulWidget>> globalKey;
  const DialogExit({
    super.key,
    required this.state,
    required this.painterController,
    required this.globalKey,
  });

  final WritingPracticeDetailState state;
  final PainterController painterController;

  @override
  _DialogExitState createState() => _DialogExitState();
}

class _DialogExitState extends State<DialogExit> {
  final languageCode = Get.locale?.languageCode;
  AuthController authController = AuthController.findOrInitialize;
  WritingPracticeController writingPracticeController =
      WritingPracticeController.findOrInitialize;
  CharsController charsController = CharsController.findOrInitialize;
  WritingPracticeDetailCubit cubit = WritingPracticeDetailCubit();
  WritingPracticeUserEntity writingPracticeUser = WritingPracticeUserEntity(
      id: '', userId: '', writingPracticeId: '', practicedImagePaths: {});
  bool isSaving = false;

  Future<Uint8List?> captureImageFromPainter(
      PainterController controller) async {
    RenderRepaintBoundary boundary = widget.globalKey.currentContext!
        .findRenderObject() as RenderRepaintBoundary;
    ui.Image image = await boundary.toImage(pixelRatio: 3.0);
    ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    return byteData?.buffer.asUint8List();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Container(
        height: widget.state.width * 0.4,
        width: widget.state.height * 0.9,
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
      decoration: BoxDecoration(
        border: Border.all(width: 2, color: Colors.white),
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Center(
            child: ImageSvgUrlCustom(
              imagePath: AppImages.imgDialogSave,
              height: (widget.state.width - widget.state.height) / 2.8,
              width: (widget.state.width - widget.state.height) / 2.8,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              LanguageKeys.savingImage.tr,
              style: const TextStyle(fontSize: 30, fontFamily: 'Coiny-Regular'),
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
                      backgroundColor: MaterialStatePropertyAll(Colors.red)),
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: ImageSvgUrlCustom(
                      imagePath: AppIcons.icClose,
                      height: 35,
                      width: 35,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 98,
                ),
                ElevatedButton(
                  onPressed: () async {
                    setState(() {
                      isSaving = true;
                    });
                    var currentChars = charsController.currentChars.value;
                    Uint8List? imageBytes =
                        await captureImageFromPainter(widget.painterController);

                    if (imageBytes != null) {
                      currentChars.imagePaths[languageCode] =
                          await writingPracticeController.uploadPractice(
                              context,
                              imageBytes,
                              '${authController.currentUser.value.id}_${currentChars.char}');
                    } else {
                      print('Failed to capture image');
                    }

                    writingPracticeUser = writingPracticeUser.copyWith(
                      practicedImagePaths: currentChars.imagePaths,
                      userId: authController.currentUser.value.id,
                      writingPracticeId: currentChars.id,
                    );
                    var writingPracticeUserEntity =
                        await writingPracticeController
                            .createOrGetWritingPracticeByUser(
                                context, writingPracticeUser);
                    await writingPracticeController.updateWritingPracticeByUser(
                        context, writingPracticeUserEntity!);
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
