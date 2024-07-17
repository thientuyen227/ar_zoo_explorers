import 'package:ar_zoo_explorers/base/base_cubit.dart';
import 'package:ar_zoo_explorers/core/data/controller/auth_controller.dart';
import 'package:ar_zoo_explorers/features/chatAI/presentation/chat_ai_state.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:injectable/injectable.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

@injectable
class ChatAICubit extends BaseCubit<ChatAIState> {
  ChatAICubit() : super(ChatAIState());

  AuthController controller = AuthController.findOrInitialize;

  final ValueNotifier<bool> isClosedLoading = ValueNotifier<bool>(false);

  final Dio _dio = Dio();

  Future<void> init() async {
    Size mediaSize = MediaQueryData.fromView(
            WidgetsBinding.instance.platformDispatcher.views.single)
        .size;
    showLoading();
    emit(state.copyWith(
        height: mediaSize.height,
        width: mediaSize.width,
        isImage: false,
        isEnabled: true));
    await Future.delayed(const Duration(milliseconds: 2200));
    emit(state.copyWith(isLoaded: true));
    hideLoading();
  }

  Future<void> changeIsImage(bool status) async {
    await state.setAttributes(isImage: status);
  }

  Future<void> changeEnabledBottomBar(bool status) async {
    await state.setAttributes(isEnabled: status);
  }

  Future<bool> downloadImage(String fileName, String urlPath) async {
    try {
      var status = await Permission.storage.status;
      if (!status.isGranted) {
        await Permission.storage.request();
      }
      final directory = await getApplicationDocumentsDirectory();
      final filePath = '${directory.path}/$fileName.jpg';

      final response = await _dio.download(
        urlPath,
        filePath,
        onReceiveProgress: (received, total) {
          if (total != -1) {
            print("${(received / total * 100).toStringAsFixed(0)}%");
          }
        },
      );

      if (response.statusCode == 200) {
        await ImageGallerySaver.saveFile(filePath);
        print('Download and save completed: $filePath');
        return true;
      } else {
        print('Error downloading file: ${response.statusCode}');
        return false;
      }
    } catch (e) {
      print('Error: $e');
      return false;
    }
  }
}
