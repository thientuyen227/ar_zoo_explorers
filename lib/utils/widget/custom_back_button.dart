import 'package:ar_zoo_explorers/app/config/app_router.gr.dart';
import 'package:ar_zoo_explorers/app/theme/colors.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

class CustomBackButton extends StatelessWidget {
  const CustomBackButton({
    super.key,
    this.onPressed,
  });

  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed:
          onPressed ?? () => context.router.popAndPush(const HomeRoute()),
      icon: const Icon(
        Icons.keyboard_arrow_left,
        size: 30,
        color: AppColor.white,
      ),
    );
  }
}
