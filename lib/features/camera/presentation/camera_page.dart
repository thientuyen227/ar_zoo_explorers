import 'package:ar_zoo_explorers/base/base_state.dart';
import 'package:ar_zoo_explorers/features/camera/presentation/camera_cubit.dart';
import 'package:ar_zoo_explorers/features/camera/presentation/camera_state.dart';
import 'package:auto_route/auto_route.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

List<CameraDescription>? cameras;

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
  bool isRecoring = false;
  bool flash = false;
  bool isCameraFront = false;

  @override
  void initState() {
    super.initState();
    // Khởi tạo camera controller
    _initCameraController();
  }

  void _initCameraController({bool isFront = false}) async {
    final cameras = await availableCameras();
    if (cameraController != null && cameraController!.value.isInitialized) {
      await cameraController?.dispose();
    }
    cameraController = CameraController(
        isFront ? cameras[1] : cameras.first, ResolutionPreset.medium);
    try {
      await cameraController!.initialize();
      if (mounted) {
        setState(() {});
      }
    } catch (e) {
      if (e is CameraException) {
        switch (e.code) {
          case 'CameraAccessDenied':
            // Xử lý lỗi quyền truy cập ở đây.
            break;
          default:
            // Xử lý các lỗi khác ở đây.
            break;
        }
      }
    }
  }

  @override
  Widget buildByState(BuildContext context, CameraState state) {
    if (cameraController == null || !cameraController!.value.isInitialized) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      body: Stack(
        children: [
          Stack(
            children: [
              CameraPreview(cameraController!),
              Positioned(
                top: 16,
                left: 16,
                child: IconButton(
                  icon: Icon(
                    flash ? Icons.flash_on : Icons.flash_off,
                    color: Colors.white,
                    size: 28,
                  ),
                  onPressed: () {
                    setState(() {
                      flash = !flash;
                    });
                    flash
                        ? cameraController?.setFlashMode(FlashMode.torch)
                        : cameraController?.setFlashMode(FlashMode.off);
                  },
                ),
              ),
            ],
          ),
          Align(
            alignment: AlignmentDirectional.bottomEnd,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: takePicture,
                  child: const Text('Chụp ảnh'),
                ),
                const SizedBox.shrink(),
                IconButton(
                  icon: const Icon(
                    Icons.flip_camera_ios,
                    color: Colors.white,
                    size: 28,
                  ),
                  onPressed: () {
                    if (cameraController != null &&
                        cameraController!.value.isInitialized) {
                      isCameraFront = !isCameraFront;
                      _initCameraController(isFront: isCameraFront);
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void takePicture() async {
    if (cameraController != null && cameraController!.value.isInitialized) {
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
    } else {
      print('Camera không khởi tạo.');
    }
  }

  @override
  void dispose() {
    cameraController?.dispose();
    super.dispose();
  }
}
