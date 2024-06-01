import 'dart:io';

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
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:language_detector/language_detector.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

@RoutePage()
class ChatAIPage extends StatefulWidget {
  const ChatAIPage({super.key});

  @override
  State createState() => _State();
}

class _State extends BaseState<ChatAIState, ChatAICubit, ChatAIPage> {
  final Dio _dio = Dio();

  List<Widget> lstMessages = [];
  ChatBoxEntity? chatBoxEntity;

  ApiService apiService = ApiService();

  bool isEnabled = true;
  bool isImage = false;

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
      bottomNavigationBar: Offstage(
          offstage: !isEnabled,
          child: ChatAIABottomBar(
            onSendMassage: (MessageEntity message) async {
              _sendMessages(message).then((value) {
                setState(() {
                  if (message.imagePath!.isEmpty) {
                    isImage = false;
                  } else {
                    isImage = true;
                  }
                });
                _sendTextToImage(message.content, File(message.imagePath ?? ''))
                    .then((value) {
                  setState(() {
                    _sendResponse();
                  });
                });
              });
            },
          )),
      // resizeToAvoidBottomInset: true,
    );
  }

  Widget boxChat() {
    return Column(children: lstMessages);
  }

  Widget aiAvatar() {
    return Container(
      height: state.height * 0.055,
      width: state.height * 0.055,
      padding: const EdgeInsets.all(3),
      margin: const EdgeInsets.all(5),
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
      height: state.height * 0.055,
      width: state.height * 0.055,
      padding: const EdgeInsets.all(3),
      margin: const EdgeInsets.all(5),
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

  Widget btnDownload() {
    return GestureDetector(
      onTap: () async {
        Navigator.of(context).pop(true);
        cubit.showLoading();
        await _downloadImage(cubit.controller.currentUser.value.fullname,
            chatBoxEntity!.generatedFiles![0].fileUrl);
        cubit.hideLoading();
      },
      child: Container(
        height: state.height * 0.07,
        width: state.width * 0.9,
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            border: Border.all(width: 2, color: Colors.black),
            color: Colors.grey.shade100),
        child: Row(children: [
          SizedBox(
            height: state.height * 0.03,
            width: state.height * 0.03,
            child: ClipRRect(
                child: Image.asset(
              AppIcons.icBlackDownload,
              fit: BoxFit.cover,
            )),
          ),
          const SizedBox(width: 10),
          const SizedBox(
              child: Text(
            "Download this image",
            style: TextStyle(fontSize: 18, color: Colors.black),
          ))
        ]),
      ),
    );
  }

  Future<void> _showDownloadSheet() async {
    await showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
              top: Radius.circular(state.height * 0.025))),
      barrierColor: Colors.grey.withOpacity(0.55),
      builder: (BuildContext context) {
        return Container(
          height: state.height * 0.15,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(state.height * 0.025),
            ),
          ),
          child: Center(
            child: btnDownload(),
          ),
        );
      },
    );
  }

  Future<void> _sendMessages(MessageEntity value) async {
    // _changeEnabledState();
    lstMessages.add(
      Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const Spacer(),
        Column(children: [
          value.content.isNotEmpty ? TextMessage(entity: value) : Container(),
          value.imagePath!.isNotEmpty
              ? ImageMessage(
                  entity: MessageEntity(
                  content: value.imagePath!,
                  contentType: MsgType.image_file.typeString,
                ))
              : Container(),
        ]),
        userAvatar()
      ]),
    );
  }

  Future<void> _sendResponse() async {
    lstMessages
        .add(Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
      aiAvatar(),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextMessage(
              entity: MessageEntity(content: chatBoxEntity!.prediction)),
          isImage == false && chatBoxEntity!.generatedFiles!.isNotEmpty
              ? GestureDetector(
                  onTap: () async {
                    await _showDownloadSheet();
                  },
                  child: ImageMessage(
                      entity: MessageEntity(
                    content: chatBoxEntity!.generatedFiles![0].fileUrl,
                    contentType: MsgType.image_network.typeString,
                  )))
              : Container(),
        ],
      ),
      const Spacer()
    ]));
  }

  Future<void> _downloadImage(String fileName, String urlPath) async {
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
        setState(() {});
        print('Download and save completed: $filePath');
      } else {
        print('Error downloading file: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> _sendTextToImage(String text, File? imageFile) async {
    try {
      cubit.showLoading();
      if (text == '') {
        text = 'what is this?';
      }
      String detectedLanguage =
          await LanguageDetector.getLanguageCode(content: text);

      chatBoxEntity = await apiService.getTextToImageResponse(
          text, detectedLanguage, imageFile!);
      cubit.hideLoading();
    } catch (e) {
      cubit.hideLoading();
      chatBoxEntity = null;
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

  Future<void> _changeEnabledState() async {
    setState(() {
      isEnabled = !isEnabled;
      print(isEnabled);
    });
  }

  Future<void> _initCubit() async {
    await cubit.init(context).then((value) => setState(() {}));
  }

  @override
  void initState() {
    super.initState();
    _initCubit();
  }
}
