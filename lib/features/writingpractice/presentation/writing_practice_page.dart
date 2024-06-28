import 'package:ar_zoo_explorers/app/config/routes.dart';
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
  String type = "char";
  @override
  void initState() {
    cubit.init(type: type, context: context);
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
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0, left: 4),
                      child: GestureDetector(
                          onTap: () => context.router.pop(),
                          child: const ImageSvgUrlCustom(
                              imagePath: AppIcons.icBackPng)),
                    ),
                    Expanded(
                      child: SizedBox(
                        width: state.height,
                        child: GridView.builder(
                          padding: const EdgeInsets.only(
                              left: 10, bottom: 30, right: 5),
                          scrollDirection: Axis.horizontal,
                          itemCount: state.charsEntities.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                charsController
                                    .currentChars(state.charsEntities[index]);
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
                              child: state.charsEntities[index]
                                          .imagePaths[languageCode] !=
                                      ''
                                  ? Container(
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              width: 5,
                                              color: AppColor.lightBlue)),
                                      child: ImageSvgUrlCustom(
                                          imagePath: state.charsEntities[index]
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
}
