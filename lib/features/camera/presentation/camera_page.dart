import 'package:ar_zoo_explorers/base/base_state.dart';
import 'package:ar_zoo_explorers/features/camera/presentation/camera_cubit.dart';
import 'package:ar_zoo_explorers/features/camera/presentation/camera_state.dart';
import 'package:auto_route/auto_route.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

@RoutePage()
class CameraPage extends StatefulWidget {
  const CameraPage({
    Key? key,
  }) : super(key: key);

  @override
  State createState() => _State();
}

class _State extends BaseState<CameraState, CameraCubit, CameraPage> {
  CameraController? cameraController;

  @override
  void initState() {
    super.initState();
    // Khởi tạo camera controller
    _initCameraController();
  }

  void _initCameraController() async {
    final cameras = await availableCameras();
    final firstCamera = cameras.first;
    cameraController = CameraController(firstCamera, ResolutionPreset.medium);
    cameraController!.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    }).catchError((Object e) {
      if (e is CameraException) {
        switch (e.code) {
          case 'CameraAccessDenied':
            // Handle access errors here.
            break;
          default:
            // Handle other errors here.
            break;
        }
      }
    });
  }

  @override
  Widget buildByState(BuildContext context, CameraState state) {
    if (cameraController?.value.isInitialized != true) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Camera Page'),
        ),
        body: const Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Camera Page'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: CameraPreview(cameraController!),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              // Xử lý khi người dùng nhấn nút chụp ảnh
              takePicture();
            },
            child: const Text('Chụp ảnh'),
          ),
        ],
      ),
    );
  }

  void takePicture() async {
    try {
      final XFile picture = await cameraController!.takePicture();
      if (picture != null) {
        await cubit.saveImage(picture.path);
      } else {
        print('null');
      }
    } catch (e) {
      print('Lỗi khi chụp ảnh: $e');
    }
  }

  @override
  void dispose() {
    cameraController?.dispose();
    super.dispose();
  }
}
