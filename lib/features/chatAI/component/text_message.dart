import 'dart:async';

import 'package:ar_zoo_explorers/app/theme/colors.dart';
import 'package:ar_zoo_explorers/domain/entities/message_entity.dart';
import 'package:flutter/material.dart';

class TextMessage extends StatefulWidget {
  MessageEntity entity;

  TextMessage({Key? key, required this.entity}) : super(key: key);

  @override
  _TextMessageState createState() => _TextMessageState();
}

class _TextMessageState extends State<TextMessage> {
  double width = 0;
  double height = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
        constraints: BoxConstraints(maxWidth: width * 0.5),
        // width: width * 0.5,
        margin: const EdgeInsets.all(5),
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: AppColor.primaryColor),
        child: Text(
          widget.entity.content,
          style: const TextStyle(color: AppColor.white, fontSize: 17),
          softWrap: true,
        ));
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
