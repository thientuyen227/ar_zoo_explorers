import 'package:ar_zoo_explorers/app/config/app_router.gr.dart';
import 'package:ar_zoo_explorers/app/languages/language_key.dart';
import 'package:ar_zoo_explorers/app/theme/colors.dart';
import 'package:ar_zoo_explorers/app/theme/icons.dart';
import 'package:ar_zoo_explorers/base/base_state.dart';
import 'package:ar_zoo_explorers/features/phonics/presentation/phonics_cubit.dart';
import 'package:ar_zoo_explorers/features/phonics/presentation/phonics_state.dart';
import 'package:ar_zoo_explorers/utils/widget/image_svg_url_custom.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

@RoutePage()
class PhonicsPage extends StatefulWidget {
  const PhonicsPage({super.key});

  @override
  State createState() => _State();
}

class _State extends BaseState<PhonicsState, PhonicsCubit, PhonicsPage> {
  final bool _isOrientationLocked = true;
  @override
  void initState() {
    cubit.showLoading();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    cubit.init();
    cubit.hideLoading();
    super.initState();
  }

  @override
  void dispose() {
    if (_isOrientationLocked) {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight,
      ]);
    }
    super.dispose();
  }

  @override
  Widget buildByState(BuildContext context, PhonicsState state) {
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
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: GestureDetector(
              onTap: () {
                context.router.pop().then((value) => setState(() {}));
              },
              child: const ImageSvgUrlCustom(imagePath: AppIcons.icBackPng)),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 60),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              renderMotionAndTitle(
                  LanguageKeys.uppercaseLetters, AppLotties.earth),
              renderMotionAndTitle(
                  LanguageKeys.lowercaseLetters, AppLotties.plane),
              renderMotionAndTitle(
                  LanguageKeys.cardinalNumbers, AppLotties.snow)
            ],
          ),
        )
      ],
    ));
  }

  Widget renderMotionAndTitle(String title, String motion) {
    return InkWell(
      onTap: () {
        String type = '';
        switch (title) {
          case LanguageKeys.uppercaseLetters:
            type = 'upper';
            break;
          case LanguageKeys.lowercaseLetters:
            type = 'lower';
            break;
          case LanguageKeys.cardinalNumbers:
            type = 'number';
            break;
          default:
            return;
        }
        context.router.push(
          PhonicsDetailRoute(type: type),
        );
      },
      child: SizedBox(
        height: state.height * 0.9,
        width: state.width * 0.6,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Lottie.asset(motion, height: 180, width: 180),
              const SizedBox(
                height: 25,
              ),
              Container(
                padding: const EdgeInsets.only(bottom: 6, right: 6, left: 6),
                decoration: BoxDecoration(
                    boxShadow: const <BoxShadow>[
                      BoxShadow(
                        offset: Offset(3.0, 4.0),
                        blurRadius: 0.0,
                        spreadRadius: 1.0,
                        color: AppColor.lightBlue,
                      ),
                    ],
                    borderRadius: BorderRadius.circular(10),
                    color: AppColor.white),
                child: Text(
                  textAlign: TextAlign.center,
                  title.tr,
                  style: const TextStyle(
                      color: AppColor.lightBlue,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Coiny-Regular'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
