import 'package:ar_zoo_explorers/app/languages/language_key.dart';
import 'package:ar_zoo_explorers/app/theme/colors.dart';
import 'package:ar_zoo_explorers/app/theme/icons.dart';
import 'package:ar_zoo_explorers/domain/entities/message_entity.dart';
import 'package:ar_zoo_explorers/features/base-model/message_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';

class ChatAIABottomBar extends StatefulWidget {
  final ValueChanged<MessageEntity> onSendMassage;
  const ChatAIABottomBar({Key? key, required this.onSendMassage})
      : super(key: key);

  @override
  _ChatAIABottomBarState createState() => _ChatAIABottomBarState();
}

class _ChatAIABottomBarState extends State<ChatAIABottomBar> {
  double width = 0;
  double height = 0;

  final _formKey = GlobalKey<FormBuilderState>();

  TextEditingController? editingController;

  @override
  Widget build(BuildContext context) {
    return FormBuilder(
        key: _formKey,
        child: SingleChildScrollView(
            reverse: true, // Scroll up when keyboard appears
            child: Padding(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context)
                        .viewInsets
                        .bottom), // Adjust padding when keyboard is displayed
                child: GestureDetector(
                    onTap: () =>
                        FocusScope.of(context).requestFocus(FocusNode()),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      width: width,
                      // height: height * 0.1,
                      color: Colors.transparent,
                      child: Row(children: [
                        btnCamera(),
                        Expanded(child: boxChat()),
                        btnSend()
                      ]),
                    )))));
  }

  Widget btnSend() {
    return IconButton(
      icon: Container(
          height: height * 0.055,
          width: height * 0.055,
          decoration: const BoxDecoration(
              color: AppColor.primaryColor, shape: BoxShape.circle),
          padding: const EdgeInsets.all(0),
          child: Icon(
            Icons.send,
            size: height * 0.035,
            color: Colors.white,
          )),
      onPressed: () async {
        widget.onSendMassage(MessageEntity(
            content: editingController!.text,
            contentType: MsgType.text.typeString));
        editingController!.clear();
        FocusScope.of(context).requestFocus(FocusNode());
      },
    );
  }

  Widget btnCamera() {
    return IconButton(
      icon: Container(
        height: height * 0.055,
        width: height * 0.055,
        decoration:
            const BoxDecoration(color: Colors.grey, shape: BoxShape.circle),
        padding: const EdgeInsets.all(5),
        // child: Icon(Icons.send, size: height * 0.035, color: Colors.white),
        child: ClipOval(
            child: Image.asset(
          AppIcons.icCamera,
          fit: BoxFit.cover,
        )),
      ),
      onPressed: () async {},
    );
  }

  Widget boxChat() {
    return FormBuilderTextField(
        name: 'chat',
        controller: editingController,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
            filled: true,
            fillColor: Colors.grey.shade50,
            hintText: LanguageKeys.write_message.tr,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 10, horizontal: 25)),
        style: const TextStyle(fontSize: 16),
        initialValue: "",
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: FormBuilderValidators.compose([]));
  }

  Future<void> _setDimension() async {
    Size mediaSize = MediaQueryData.fromView(
            WidgetsBinding.instance.platformDispatcher.views.single)
        .size;

    setState(() {
      width = mediaSize.width;
      height = mediaSize.height;
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _setDimension();
  }
}
