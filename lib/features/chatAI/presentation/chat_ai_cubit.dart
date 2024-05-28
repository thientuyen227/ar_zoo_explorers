import 'package:ar_zoo_explorers/base/base_cubit.dart';
import 'package:ar_zoo_explorers/core/data/controller/auth_controller.dart';
import 'package:ar_zoo_explorers/domain/entities/message_entity.dart';
import 'package:ar_zoo_explorers/features/base-model/message_type.dart';
import 'package:ar_zoo_explorers/features/chatAI/presentation/chat_ai_state.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@injectable
class ChatAICubit extends BaseCubit<ChatAIState> {
  ChatAICubit() : super(ChatAIState());
  AuthController controller = AuthController.findOrInitialize;
  Future<void> init(BuildContext context) async {
    showLoading();
    Size mediaSize = MediaQueryData.fromView(
            WidgetsBinding.instance.platformDispatcher.views.single)
        .size;
    // emit(state.copyWith(
    //   height: mediaSize.height,
    //   width: mediaSize.width,
    // ));

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
            contentType: MsgType.image.typeString,
            isAI: false,
          ),
        ]);

    print("Cubit.Init() : Get data");
    hideLoading();
  }
}
