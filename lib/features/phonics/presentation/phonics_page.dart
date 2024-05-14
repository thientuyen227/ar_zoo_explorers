import 'package:ar_zoo_explorers/app/config/routes.dart';
import 'package:ar_zoo_explorers/app/theme/colors.dart';
import 'package:ar_zoo_explorers/app/theme/icons.dart';
import 'package:ar_zoo_explorers/base/base_state.dart';
import 'package:ar_zoo_explorers/features/phonics/presentation/phonics_cubit.dart';
import 'package:ar_zoo_explorers/features/phonics/presentation/phonics_state.dart';
import 'package:ar_zoo_explorers/utils/widget/image_svg_url_custom.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';

@RoutePage()
class PhonicsPage extends StatefulWidget {
  const PhonicsPage({super.key});

  @override
  State createState() => _State();
}

class _State extends BaseState<PhonicsState, PhonicsCubit, PhonicsPage> {
  final bool _isOrientationLocked = true;
  double? width;
  double? height;
  void setDimension() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      width = MediaQuery.of(context).size.width;
      height = MediaQuery.of(context).size.height;
    });
  }

  @override
  void initState() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);

    setDimension();
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
          child: SingleChildScrollView(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                renderMotionAndTitle("Chữ in hoa", AppLotties.animationanimal),
                renderMotionAndTitle("Chữ thường", AppLotties.animationanimal),
                renderMotionAndTitle("Số đếm", AppLotties.animationanimal)
              ],
            ),
          ),
        )
      ],
    ));
  }

  Widget renderMotionAndTitle(String title, String motion) {
    return InkWell(
      onTap: () {
        context.router.pushNamed(Routes.phonicsdetail);
      },
      child: SizedBox(
        height: height! * 0.9,
        width: width! * 0.6,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Lottie.asset(motion),
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
                  title,
                  style: const TextStyle(
                      color: AppColor.lightBlue,
                      fontSize: 26,
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
