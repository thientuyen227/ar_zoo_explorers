import 'dart:io';

import 'package:ar_zoo_explorers/app/languages/language_key.dart';
import 'package:ar_zoo_explorers/app/theme/colors.dart';
import 'package:ar_zoo_explorers/app/theme/icons.dart';
import 'package:ar_zoo_explorers/domain/entities/message_entity.dart';
import 'package:ar_zoo_explorers/features/base-model/message_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ChatAIABottomBar extends StatefulWidget {
  final ValueChanged<MessageEntity> onSendMassage;
  const ChatAIABottomBar({super.key, required this.onSendMassage});

  @override
  _ChatAIABottomBarState createState() => _ChatAIABottomBarState();
}

class _ChatAIABottomBarState extends State<ChatAIABottomBar> {
  double width = 0;
  double height = 0;

  final _formKey = GlobalKey<FormBuilderState>();

  TextEditingController editingController = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  bool isImage = false;
  XFile? image;
  MessageEntity? messageEntity;

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
                        isImage
                            ? selectedImage(File(image!.path))
                            : btnCamera(),
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
        if (editingController.text.trim() != '') {
          MessageEntity? newEntity;
          if (isImage) {
            newEntity = messageEntity!.copyWith(
                content: editingController.text,
                contentType: MsgType.text.typeString);
          } else {
            newEntity = MessageEntity(
                content: editingController.text,
                contentType: MsgType.text.typeString);
          }
          widget.onSendMassage(newEntity);
          editingController.clear();
          isImage = false;
          FocusScope.of(context).requestFocus(FocusNode());
        } else if (isImage) {
          widget.onSendMassage(messageEntity!);
          isImage = false;
          FocusScope.of(context).requestFocus(FocusNode());
        }
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
      onPressed: () async {
        await _showPhotoSheet();
      },
    );
  }

  Widget btnOpenCamera() {
    return GestureDetector(
      child: Container(
        height: height * 0.06,
        width: width * 0.4,
        decoration: BoxDecoration(
            color: Colors.grey, borderRadius: BorderRadius.circular(20)),
        padding: const EdgeInsets.all(5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipRRect(child: Image.asset(AppIcons.icCamera, fit: BoxFit.cover)),
            const SizedBox(width: 5),
            const SizedBox(
                child: Text("Camera",
                    style: TextStyle(fontSize: 18, color: Colors.white)))
          ],
        ),
      ),
      onTap: () async {
        await selectImageCamera();
      },
    );
  }

  Widget btnOpenGallery() {
    return GestureDetector(
      child: Container(
        height: height * 0.06,
        width: width * 0.4,
        decoration: BoxDecoration(
            color: AppColor.primaryColor,
            borderRadius: BorderRadius.circular(20)),
        padding: const EdgeInsets.all(5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipRRect(
                child: Image.asset(AppIcons.icWhiteGallery, fit: BoxFit.cover)),
            const SizedBox(width: 5),
            const SizedBox(
                child: Text("Gallery",
                    style: TextStyle(fontSize: 18, color: Colors.white)))
          ],
        ),
      ),
      onTap: () async {
        await selectImageGallery();
      },
    );
  }

  Widget selectedImage(File imgFile) {
    return GestureDetector(
      onTap: () async {
        await selectImageGallery();
      },
      child: Container(
        height: height * 0.07,
        width: height * 0.07,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
        padding: const EdgeInsets.all(5),
        child: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Image.file(imgFile, fit: BoxFit.cover)),
      ),
    );
  }

  Widget boxChat() {
    return TextFormField(
      controller: editingController,
      decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
          hintText: LanguageKeys.write_message.tr,
          // prefixIcon: Image.asset(AppIcons.icCalendar),
          contentPadding: const EdgeInsets.all(10)),
    );
  }

  Future<void> _showPhotoSheet() async {
    await showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.vertical(top: Radius.circular(height * 0.025))),
      barrierColor: Colors.grey.withOpacity(0.55),
      builder: (BuildContext context) {
        return Container(
          height: height * 0.15,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(height * 0.025),
            ),
          ),
          child: Center(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [btnOpenCamera(), btnOpenGallery()],
          )),
        );
      },
    );
  }

  Future<void> selectImageGallery() async {
    image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      messageEntity = MessageEntity(
          imagePath: image!.path, contentType: MsgType.image_file.typeString);
      setState(() {
        isImage = true;
      });
      Navigator.of(context).pop(true);
    } else {
      setState(() {
        isImage = false;
      });
      await Fluttertoast.showToast(
        msg: LanguageKeys.get_img_failed.tr,
      );
    }
  }

  Future<void> selectImageCamera() async {
    image = await _picker.pickImage(source: ImageSource.camera);
    if (image != null) {
      messageEntity = MessageEntity(
          imagePath: image!.path, contentType: MsgType.image_file.typeString);
      setState(() {
        isImage = true;
      });
      Navigator.of(context).pop(true);
    } else {
      setState(() {
        isImage = false;
      });
      await Fluttertoast.showToast(msg: LanguageKeys.get_img_failed.tr);
    }
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
