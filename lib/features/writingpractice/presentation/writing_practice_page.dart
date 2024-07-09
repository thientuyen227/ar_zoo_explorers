import 'package:ar_zoo_explorers/app/config/routes.dart';
import 'package:ar_zoo_explorers/app/languages/language_key.dart';
import 'package:ar_zoo_explorers/app/theme/colors.dart';
import 'package:ar_zoo_explorers/app/theme/icons.dart';
import 'package:ar_zoo_explorers/base/base_state.dart';
import 'package:ar_zoo_explorers/core/data/controller/chars_controller.dart';
import 'package:ar_zoo_explorers/features/writingpractice/presentation/writing_practice_cubit.dart';
import 'package:ar_zoo_explorers/features/writingpractice/presentation/writing_practice_state.dart';
import 'package:ar_zoo_explorers/utils/widget/image_svg_url_custom.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

@RoutePage()
class WritingPracticePage extends StatefulWidget {
  const WritingPracticePage({super.key});

  @override
  State createState() => _State();
}

class _State extends BaseState<WritingPracticeState, WritingPracticeCubit,
    WritingPracticePage> {
  final bool _isOrientationLocked = true;
  final languageCode = Get.locale?.languageCode;
  CharsController charsController = CharsController.findOrInitialize;
  bool isChose = true;
  String type = "letter";
  @override
  void initState() {
    cubit.init(context: context);
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
  }

  @override
  void dispose() {
    super.dispose();
    if (_isOrientationLocked) {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]);
    }
  }

  @override
  Widget buildByState(BuildContext context, WritingPracticeState state) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(AppImages.backgroundPhonics),
                fit: BoxFit.cover,
              ),
            ),
          ),
          state.height != 0
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0, left: 4),
                          child: GestureDetector(
                              onTap: () => context.router.pop(),
                              child: const ImageSvgUrlCustom(
                                  imagePath: AppIcons.icBackPng)),
                        ),
                        const Spacer(),
                        Container(
                          padding: const EdgeInsets.all(2),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            children: [
                              _buildToggleButton(
                                title: LanguageKeys.letter.tr,
                                isSelected: isChose,
                                onTap: () {
                                  setState(() {
                                    isChose = true;
                                    type = 'letter';
                                  });
                                  cubit.updateCurrentEntities(type);
                                },
                              ),
                              const SizedBox(width: 3),
                              const Text("|"),
                              const SizedBox(width: 3),
                              _buildToggleButton(
                                title: LanguageKeys.number.tr,
                                isSelected: !isChose,
                                onTap: () {
                                  setState(() {
                                    isChose = false;
                                    type = 'number';
                                  });
                                  cubit.updateCurrentEntities(type);
                                },
                              ),
                            ],
                          ),
                        ),
                        const Spacer(),
                        const SizedBox(
                          width: 40,
                        )
                      ],
                    ),
                    Expanded(
                      child: SizedBox(
                        width: state.height,
                        child: GridView.builder(
                          padding: const EdgeInsets.only(
                              left: 10, bottom: 30, right: 5),
                          scrollDirection: Axis.horizontal,
                          itemCount: state.currentEntities.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                charsController
                                    .currentChars(state.currentEntities[index]);
                                context.router
                                    .pushNamed(Routes.writingpracticedetail)
                                    .then((value) {
                                  if (value == true) {
                                    cubit.showLoading();
                                    setState(() {
                                      charsController.getAllChars(context);
                                    });
                                    cubit.hideLoading();
                                  }
                                });
                              },
                              child: state.currentEntities[index]
                                          .imagePaths[languageCode] !=
                                      ''
                                  ? Container(
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              width: 5,
                                              color: AppColor.lightBlue)),
                                      child: ImageSvgUrlCustom(
                                          imagePath: state
                                              .currentEntities[index]
                                              .imagePaths[languageCode]!))
                                  : Container(),
                            );
                          },
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  childAspectRatio:
                                      state.width * 1.46 / state.height,
                                  mainAxisSpacing: 5,
                                  crossAxisSpacing: 5),
                        ),
                      ),
                    )
                  ],
                )
              : Stack(
                  children: [
                    ModalBarrier(
                      color: Colors.black.withOpacity(0.5),
                      dismissible: false,
                    ),
                    Center(
                      child: Lottie.asset(AppLotties.loading,
                          height: 150, width: 150),
                    ),
                  ],
                ),
        ],
      ),
    );
  }

  Widget _buildToggleButton({
    required String title,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 65,
        alignment: Alignment.center,
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: isSelected ? AppColor.lightBlue : Colors.white,
          borderRadius: title == LanguageKeys.letter.tr
              ? const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  bottomLeft: Radius.circular(20),
                )
              : const BorderRadius.only(
                  topRight: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
        ),
        child: Text(
          title,
          style: TextStyle(
            color: !isSelected ? AppColor.lightBlue : Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
