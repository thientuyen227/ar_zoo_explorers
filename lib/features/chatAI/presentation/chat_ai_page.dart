import 'package:ar_zoo_explorers/app/theme/colors.dart';
import 'package:ar_zoo_explorers/app/theme/icons.dart';
import 'package:ar_zoo_explorers/base/base_state.dart';
import 'package:ar_zoo_explorers/core/data/api/api_service.dart';
import 'package:ar_zoo_explorers/domain/entities/chatbox_entity.dart';
import 'package:ar_zoo_explorers/domain/entities/message_entity.dart';
import 'package:ar_zoo_explorers/features/base-model/message_type.dart';
import 'package:ar_zoo_explorers/features/chatAI/component/chai_ai_app_bar.dart';
import 'package:ar_zoo_explorers/features/chatAI/component/chat_ai_bottom_bar.dart';
import 'package:ar_zoo_explorers/features/chatAI/component/image_message.dart';
import 'package:ar_zoo_explorers/features/chatAI/component/text_message.dart';
import 'package:ar_zoo_explorers/features/chatAI/presentation/chat_ai_cubit.dart';
import 'package:ar_zoo_explorers/features/chatAI/presentation/chat_ai_state.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:language_detector/language_detector.dart';

@RoutePage()
class ChatAIPage extends StatefulWidget {
  const ChatAIPage({super.key});

  @override
  State createState() => _State();
}

class _State extends BaseState<ChatAIState, ChatAICubit, ChatAIPage> {
  List<Widget> lstMessages = [];
  ChatBoxEntity? chatBoxEntity;
  ApiService apiService = ApiService();

  @override
  Widget buildByState(BuildContext context, ChatAIState state) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: const ChatAIAppBar(),
      body: SafeArea(
          child: Center(
              child: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        child: Container(
          height: state.height,
          width: state.width,
          padding: const EdgeInsets.all(10),
          color: Colors.grey.shade200,
          child: SingleChildScrollView(child: boxChat()),
        ),
      ))),
      bottomNavigationBar: ChatAIABottomBar(
        onSendMassage: (MessageEntity message) {
          _sendMessages(message).then((value) {
            setState(() {});
            _sendTextToImage(message.content).then((value) {
              setState(() {
                _buildMessages();
              });
            });
          });
        },
      ),
      resizeToAvoidBottomInset: true,
    );
  }

  Widget boxChat() {
    return Column(children: lstMessages);
  }

  Widget aiAvatar() {
    return Container(
      height: state.height * 0.07,
      width: state.height * 0.07,
      padding: const EdgeInsets.all(2),
      decoration: BoxDecoration(
          border: Border.all(width: 2, color: AppColor.primaryColor),
          shape: BoxShape.circle,
          color: Colors.white),
      child: ClipOval(
          child: Image.asset(
        AppImages.imgArBaby,
        fit: BoxFit.cover,
      )),
    );
  }

  Widget userAvatar() {
    return Container(
      height: state.height * 0.07,
      width: state.height * 0.07,
      padding: const EdgeInsets.all(2),
      decoration: BoxDecoration(
          border: Border.all(width: 2, color: AppColor.primaryColor),
          shape: BoxShape.circle,
          color: Colors.white),
      child: ClipOval(
          child: Image.network(
        cubit.controller.currentUser.value.avatarUrl,
        fit: BoxFit.cover,
      )),
    );
  }

  Future<void> _sendMessages(MessageEntity value) async {
    if (value.contentType == MsgType.text.typeString) {
      lstMessages.add(Row(children: [
        const Spacer(),
        TextMessage(entity: value),
        userAvatar()
      ]));
    } else {
      lstMessages.add(Row(children: [
        const Spacer(),
        ImageMessage(
            entity: MessageEntity(
          content: chatBoxEntity!.generatedFiles![0].fileUrl,
        )),
        userAvatar()
      ]));
    }
  }

  Future<void> _buildMessages() async {
    lstMessages.add(Row(children: [
      aiAvatar(),
      Column(
        children: [
          TextMessage(
              entity: MessageEntity(content: chatBoxEntity!.prediction)),
          chatBoxEntity!.generatedFiles!.isNotEmpty
              ? ImageMessage(
                  entity: MessageEntity(
                  content: chatBoxEntity!.generatedFiles![0].fileUrl,
                ))
              : Container(),
        ],
      ),
      const Spacer()
    ]));
  }

  Future<void> _initCubit() async {
    await cubit.init(context).then((value) => setState(() {}));
  }

  Future<void> _sendTextToImage(String text) async {
    try {
      cubit.showLoading();
      String detectedLanguage =
          await LanguageDetector.getLanguageCode(content: text);
      chatBoxEntity =
          await apiService.getTextToImageResponse(text, detectedLanguage);
      cubit.hideLoading();
    } catch (e) {
      cubit.hideLoading();
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Error"),
          content: const Text(
              "Failed to send text to image. Please try again later."),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("OK"),
            ),
          ],
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    _initCubit();
  }
}
