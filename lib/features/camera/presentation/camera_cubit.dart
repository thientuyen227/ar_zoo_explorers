import 'dart:io';

import 'package:ar_zoo_explorers/base/base_cubit.dart';
import 'package:ar_zoo_explorers/features/camera/presentation/camera_state.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:injectable/injectable.dart';

@injectable
class CameraCubit extends BaseCubit<CameraState> {
  // final CameraController cameraController;
  CameraCubit() : super(CameraState());

  Future<File> saveImage(String imagePath) async {
    final result = await ImageGallerySaver.saveFile(imagePath);
    if (result != null && result.containsKey("filePath")) {
      final filePath = result["filePath"];
      final savedFile = File(filePath);
      return savedFile;
    } else {
      return result[
          'errorMessage']; // Trả về null nếu có lỗi xảy ra hoặc không thành công
    }
  }
}
