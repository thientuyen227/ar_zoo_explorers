import 'package:ar_zoo_explorers/app/config/routes.dart';
import 'package:ar_zoo_explorers/app/theme/icons.dart';
import 'package:ar_zoo_explorers/features/welcome/presentation/welcome_cubit.dart';
import 'package:ar_zoo_explorers/features/welcome/presentation/welcome_state.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../base/base_state.dart';

@RoutePage()
class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State createState() => _State();
}

class _State extends BaseState<WelcomeState, WelcomeCubit, WelcomePage> {
  double opacity = 0.0;

  @override
  Widget buildByState(BuildContext context, WelcomeState state) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(AppImages.imgAppLogoBG,
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.cover),
          Center(
            child: AnimatedOpacity(
              opacity: opacity,
              duration: const Duration(seconds: 1),
              child: Image.asset(AppImages.imgAppLogo, width: 280),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    // Tăng độ mờ của logo từ 0.0 đến 1.0 trong vòng 30 giây
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        opacity = 1.0;
      });
    });
    // Chuyển trang sau 30 giây
    Future.delayed(const Duration(seconds: 3), () {
      NextPage();
    });
  }

  void NextPage() {
    context.router.pushNamed(Routes.login);
  }
}
