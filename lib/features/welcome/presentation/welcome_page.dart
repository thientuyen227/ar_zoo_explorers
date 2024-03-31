import 'package:ar_zoo_explorers/app/theme/icons.dart';
import 'package:ar_zoo_explorers/core/data/controller/auth_controller.dart';
import 'package:ar_zoo_explorers/features/welcome/presentation/welcome_cubit.dart';
import 'package:ar_zoo_explorers/features/welcome/presentation/welcome_state.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../app/config/routes.dart';
import '../../../base/base_state.dart';

@RoutePage()
class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State createState() => _State();
}

class _State extends BaseState<WelcomeState, WelcomeCubit, WelcomePage> {
  double opacity = 0.0;
  final controller = AuthController.findOrInitialize;

  @override
  Widget buildByState(BuildContext context, WelcomeState state) {
    return Scaffold(
        body: Stack(children: [
      Image.asset(AppImages.imgAppLogoBG,
          width: double.infinity, height: double.infinity, fit: BoxFit.cover),
      Center(
          child: AnimatedOpacity(
              opacity: opacity,
              duration: const Duration(seconds: 1),
              child: Image.asset(AppImages.imgAppLogo, width: 280))),
      // Positioned(top: 0, right: 0, child: startButton(context))
    ]));
  }

  Widget startButton(BuildContext context) {
    return ElevatedButton(
        onPressed: () {
          context.router.pop();
          context.router.pushNamed(Routes.languageselection);
        },
        style: ButtonStyle(
            fixedSize: MaterialStateProperty.all(Size(cubit.WIDTH * 0.6, 50)),
            backgroundColor: MaterialStateProperty.all(Colors.white),
            elevation: MaterialStateProperty.all(5),
            shape: MaterialStateProperty.all(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20)))),
        child: Text("Start",
            style: TextStyle(fontSize: 20, color: Colors.blue[600])));
  }

  void setDimension() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        cubit.WIDTH = MediaQuery.of(context).size.width;
        cubit.HEIGHT = MediaQuery.of(context).size.height;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    setDimension();
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        opacity = 1.0;
      });
    });
    Future.delayed(const Duration(seconds: 3), () {
      context.router.pop();
      context.router.pushNamed(Routes.languageselection);
    });
    //controller.getCurrentUser(context);
    controller.checkAuthStateInWelcome(context);
  }
}
