import 'dart:async';

import 'package:ar_zoo_explorers/app/theme/colors.dart';
import 'package:ar_zoo_explorers/domain/entities/message_entity.dart';
import 'package:flutter/material.dart';

class TextMessage extends StatefulWidget {
  MessageEntity entity;

  TextMessage({super.key, required this.entity});

  @override
  _TextMessageState createState() => _TextMessageState();
}

class _TextMessageState extends State<TextMessage> {
  double width = 0;
  double height = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
        constraints:
            BoxConstraints(maxWidth: width * 0.5, minHeight: height * 0.055),
        // width: width * 0.5,
        margin: const EdgeInsets.all(5),
        padding: EdgeInsets.fromLTRB(height * 0.01, 5, height * 0.01, 5),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: const Color.fromARGB(255, 233, 155, 9).withOpacity(0.95)),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text(
            widget.entity.content,
            style: const TextStyle(color: AppColor.white, fontSize: 17),
            softWrap: true,
          )
        ]));
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
