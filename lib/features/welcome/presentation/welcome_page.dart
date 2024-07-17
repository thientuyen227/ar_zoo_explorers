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

class _State extends BaseState<WelcomeState, WelcomeCubit, WelcomePage>
    with SingleTickerProviderStateMixin {
  double opacity = 0.0;
  final controller = AuthController.findOrInitialize;

  late AnimationController _controller;
  late Animation<Offset> _animation;

  @override
  Widget buildByState(BuildContext context, WelcomeState state) {
    return Scaffold(
        body: Stack(children: [
      Image.asset(AppImages.imgBGWelcome,
          width: double.infinity, height: double.infinity, fit: BoxFit.cover),
      Center(
          child: AnimatedOpacity(
        opacity: opacity,
        duration: const Duration(seconds: 1),
        child: SlideTransition(
          position: _animation,
          child: Image.asset(AppImages.imgAppLogo, width: 280),
        ),
      )),

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

    _controller = AnimationController(
      duration: const Duration(seconds: 1, milliseconds: 500),
      vsync: this,
    )..repeat(reverse: true); // Lặp lại animation

    _animation = Tween<Offset>(
      begin: const Offset(0, 0), // Vị trí ban đầu
      end: const Offset(0, 1), // Vị trí cuối
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.bounceInOut, // Hiệu ứng nảy bóng
      ),
    );

    Future.delayed(const Duration(seconds: 5, milliseconds: 500), () {
      _controller.stop();
      _controller.reverse();
      controller.checkAuthStateInWelcome(context);
      context.router.pop();
      context.router.pushNamed(Routes.languageselection);
    });
  }
}
