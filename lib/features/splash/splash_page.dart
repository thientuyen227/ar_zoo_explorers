import 'package:ar_zoo_explorers/app/config/routes.dart';
import 'package:ar_zoo_explorers/app/theme/dimens.dart';
import 'package:ar_zoo_explorers/app/theme/icons.dart';
import 'package:ar_zoo_explorers/utils/widget/image_widget.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  bool _isNavigated = false;
  @override
  Widget build(BuildContext context) {
    if (!_isNavigated) {
      Future.delayed(const Duration(seconds: 60), () {
        if (mounted) {
          // Kiểm tra xem widget vẫn còn được hiển thị (chưa bị dispose)
          context.router.pushNamed(Routes.home); // Điều hướng đến trang chính
          _isNavigated = true; // Đã chuyển hướng
        }
      });
    }

    return const Scaffold(
      body: Center(
        child: FractionallySizedBox(
            widthFactor: 0.4,
            child: AppImageWidget(
              assetString: AppImages.imgHome,
              borderRadius:
                  BorderRadius.all(Radius.circular(AppDimens.radius32)),
            )),
      ),
    );
  }
}
