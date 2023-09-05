import 'dart:io';

import 'package:ar_zoo_explorers/app/theme/dimens.dart';
import 'package:ar_zoo_explorers/app/theme/icons.dart';
import 'package:ar_zoo_explorers/base/base_state.dart';
import 'package:ar_zoo_explorers/features/home/presentation/home_cubit.dart';
import 'package:ar_zoo_explorers/features/home/presentation/home_state.dart';
import 'package:ar_zoo_explorers/utils/extension/context_ext.dart';
import 'package:ar_zoo_explorers/utils/widget/app_bar_widget.dart';
import 'package:ar_zoo_explorers/utils/widget/button_widget.dart';
import 'package:ar_zoo_explorers/utils/widget/image_widget.dart';
import 'package:ar_zoo_explorers/utils/widget/spacer_widget.dart';
import 'package:auto_route/auto_route.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

import '../../../app/config/routes.dart';

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

  Future<File> saveImage(String imagePath) async {
    final directory = await getApplicationDocumentsDirectory();
    final imagesDirectory = Directory('${directory.path}/image');
    if (!directory.existsSync()) {
      directory.createSync(recursive: true);
    }

    final fileName = DateTime.now().millisecondsSinceEpoch.toString();
    final savedPath = '${directory.path}/$fileName.jpg';

    final imageFile = File(imagePath);
    final savedFile = await imageFile.copy(savedPath);

    return savedFile;
  }

// Mở camera và chụp ảnh
  void _openCamera() async {
    final image = await ImagePicker().pickImage(source: ImageSource.camera);
    // Xử lý ảnh sau khi chụp
    if (image != null) {
      // Lưu ảnh vào thiết bị
      final savedImage = await saveImage(image.path);
      print('Đã lưu ảnh: ${savedImage.path}');
      // Xử lý ảnh đã lưu
    }
  }

  @override
  void dispose() {
    _cameraController.dispose();
    super.dispose();
  }

  @override
  Widget buildByState(BuildContext context, HomeState state) {
    return Scaffold(
      appBar: AppAppBar(
        centerTitle: false,
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
              backgroundColor: context.myTheme.colorScheme.cardColor,
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          const VSpacing(
            spacing: AppDimens.spacing20,
          ),
          const Center(
            child: FractionallySizedBox(
                widthFactor: 0.8,
                child: AppImageWidget(assetString: AppImages.imgHome)),
          ),
          ElevatedButton(
            onPressed: () {
              _openCamera();
            },
            child: const Text('Open Camera'),
          ),
        ],
      ),
    );
  }
}
