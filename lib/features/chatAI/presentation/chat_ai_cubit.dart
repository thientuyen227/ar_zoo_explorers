import 'package:ar_zoo_explorers/base/base_cubit.dart';
import 'package:ar_zoo_explorers/core/data/controller/auth_controller.dart';
import 'package:ar_zoo_explorers/domain/entities/message_entity.dart';
import 'package:ar_zoo_explorers/features/base-model/message_type.dart';
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

  final Dio _dio = Dio();

  Future<void> init(BuildContext context) async {
    showLoading();
    Size mediaSize = MediaQueryData.fromView(
            WidgetsBinding.instance.platformDispatcher.views.single)
        .size;
    emit(state.copyWith(
      height: mediaSize.height,
      width: mediaSize.width,
      isEnabled: true,
      isImage: false,
    ));

    await state.setAttributes(
        height: mediaSize.height,
        width: mediaSize.width,
        userChat: null,
        messages: [
          MessageEntity(
            id: '',
            userId: '',
            content: 'Hello',
            contentType: MsgType.text.typeString,
            isAI: false,
          ),
          MessageEntity(
            id: '',
            userId: '',
            content: 'Hi, Im Ar-Baby. Can I Help you',
            contentType: MsgType.text.typeString,
            isAI: true,
          ),
          MessageEntity(
            id: '',
            userId: '',
            content: 'Can you help me to check this image',
            contentType: MsgType.text.typeString,
            isAI: false,
          ),
          MessageEntity(
            id: '',
            userId: '',
            content:
                'https://firebasestorage.googleapis.com/v0/b/ar-zoo-explorers.appspot.com/o/stories%2Fsutichhohoankiem%2Fsutichhohoankiem.png?alt=media&token=cdfa3057-a3c1-4709-8f66-f40a55aa91db',
            contentType: MsgType.image_network.typeString,
            isAI: false,
          ),
        ]);

    print("Cubit.Init() : Get data");
    hideLoading();
  }

  Future<void> changeIsImage(bool status) async {
    await state.setAttributes(isImage: status);
  }

  Future<void> changeEnabledBottomBar(bool status) async {
    await state.setAttributes(isEnabled: status);
  }

  Future<String> downloadImage(String fileName, String urlPath) async {
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
        return filePath;
      } else {
        print('Error downloading file: ${response.statusCode}');
        return response.statusCode.toString();
      }
    } catch (e) {
      print('Error: $e');
      return e.toString();
    }
  }
}
