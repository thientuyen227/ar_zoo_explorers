import 'package:ar_zoo_explorers/app/theme/colors.dart';
import 'package:ar_zoo_explorers/app/theme/dimens.dart';
import 'package:ar_zoo_explorers/app/theme/icons.dart';
import 'package:ar_zoo_explorers/base/base_state.dart';
import 'package:ar_zoo_explorers/features/home/presentation/home_state.dart';
import 'package:ar_zoo_explorers/utils/widget/button_widget.dart';
import 'package:ar_zoo_explorers/utils/widget/image_widget.dart';
import 'package:ar_zoo_explorers/utils/widget/spacer_widget.dart';
import 'package:auto_route/auto_route.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

import '../../../app/config/routes.dart';
import 'home_cubit.dart';

@RoutePage()
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State createState() => _State();
}

class _State extends BaseState<HomeState, HomeCubit, HomePage> {
  // Khởi tạo controller
  late CameraController _cameraController;

  @override
  void initState() {
    super.initState();
    // Khởi tạo camera controller
    _initCameraController();
  }

  void _initCameraController() async {
    final cameras = await availableCameras();
    final firstCamera = cameras.first;
    _cameraController = CameraController(firstCamera, ResolutionPreset.medium);
    await _cameraController.initialize();
    if (!mounted) {
      return;
    }
    setState(() {});
  }

// Mở camera và chụp ảnh
  @override
  void dispose() {
    _cameraController.dispose();
    super.dispose();
  }

  @override
  Widget buildByState(BuildContext context, HomeState state) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AppIconButton(
                  onPressed: () {
                    cubit.openCamera();
                  },
                  icon: Icon(
                    Icons.camera_alt,
                    color: AppColorScheme.light().textColor,
                  ),
                  borderRadius: AppDimens.radius200,
                  padding: const EdgeInsets.all(AppDimens.spacing5),
                  width: AppDimens.size30.width,
                  height: AppDimens.size30.height,
                  backgroundColor: AppColorScheme.dark().cardColor,
                ),
              ],
            ),
          ),
        ],
        title: const Text("Home Page",
            style: TextStyle(fontSize: 20, color: Colors.amber)),
        leading: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AppIconButton(
              onPressed: () {
                context.router.pushNamed(Routes.settings);
              },
              icon: const Icon(
                Icons.settings,
                color: Colors.white,
              ),
              borderRadius: AppDimens.radius200,
              padding: const EdgeInsets.all(AppDimens.spacing5),
              width: AppDimens.size30.width,
              height: AppDimens.size30.height,
              backgroundColor: AppColorScheme.dark().cardColor,
            )
          ],
        ),
      ),
      body: const Column(
        children: [
          VSpacing(
            spacing: AppDimens.spacing20,
          ),
          Center(
            child: FractionallySizedBox(
                widthFactor: 0.8,
                child: AppImageWidget(assetString: AppImages.imgHome)),
          ),
        ],
      ),
    );
  }
}
