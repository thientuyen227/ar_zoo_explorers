import 'package:ar_zoo_explorers/app/theme/colors.dart';
import 'package:ar_zoo_explorers/app/theme/icons.dart';
import 'package:ar_zoo_explorers/base/base_state.dart';
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

@RoutePage()
class ChatAIPage extends StatefulWidget {
  const ChatAIPage({super.key});

  @override
  State createState() => _State();
}

class _State extends BaseState<ChatAIState, ChatAICubit, ChatAIPage> {
  List<Widget> lstMessages = [];

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
        onSendMassage: (MessageEntity value) async {
          await _sendMessages(value);
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
        ImageMessage(entity: value),
        userAvatar()
      ]));
    }
  }

  Future<void> _buildMessages() async {
    for (var item in state.messages) {
      if (item.isAI) {
        if (item.contentType == MsgType.text.typeString) {
          lstMessages.add(Row(children: [
            aiAvatar(),
            TextMessage(entity: item),
            const Spacer()
          ]));
        } else {
          lstMessages.add(Row(children: [
            aiAvatar(),
            ImageMessage(entity: item),
            const Spacer()
          ]));
        }
      } else {
        if (item.contentType == MsgType.text.typeString) {
          lstMessages.add(Row(children: [
            const Spacer(),
            TextMessage(entity: item),
            userAvatar()
          ]));
        } else {
          lstMessages.add(Row(children: [
            const Spacer(),
            ImageMessage(entity: item),
            userAvatar()
          ]));
        }
      }
    }
  }

  Future<void> _initCubit() async {
    await cubit.init(context).then((value) => setState(() {
          _buildMessages();
        }));
  }

  Widget gradientBackground(double height, double width, double borderRadius,
      Color topColor, Color bottomColor) {
    return Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(borderRadius),
                bottomRight: Radius.circular(borderRadius)),
            gradient: LinearGradient(
                colors: [topColor, bottomColor],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter)
            // image: const DecorationImage(
            //     image: AssetImage(AppImages.imgAppLogoBG), fit: BoxFit.cover),
            ));
  }

  @override
  void initState() {
    super.initState();
    _initCubit();
  }
}
