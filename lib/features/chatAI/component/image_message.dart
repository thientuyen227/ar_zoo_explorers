import 'dart:async';

import 'package:ar_zoo_explorers/domain/entities/message_entity.dart';
import 'package:flutter/material.dart';

class ImageMessage extends StatefulWidget {
  MessageEntity entity;
  ImageMessage({Key? key, required this.entity}) : super(key: key);

  @override
  _ImageMessageState createState() => _ImageMessageState();
}

class _ImageMessageState extends State<ImageMessage> {
  double width = 0;
  double height = 0;

  Size imgSize = Size.zero;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: imgSize == Size.zero
          ? const CircularProgressIndicator()
          : _buildImageContainer(width, height),
    );
  }

  Widget _buildImageContainer(double screenWidth, double screenHeight) {
    double containerWidth;
    double containerHeight;

    if (imgSize.width > imgSize.height) {
      containerWidth = screenWidth * 0.5;
      containerHeight = containerWidth * (imgSize.height / imgSize.width);
    } else {
      containerHeight = screenHeight * 0.2;
      containerWidth = containerHeight * (imgSize.width / imgSize.height);
    }

    return Container(
        width: containerWidth,
        height: containerHeight,
        margin: const EdgeInsets.all(5),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: Image.network(
            widget.entity.content,
            fit: BoxFit.cover,
          ),
        ));
  }

  Future<void> _getImgSize() async {
    final Completer<ImageInfo> completer = Completer();
    final Image image = Image.network(widget.entity.content);

    image.image.resolve(const ImageConfiguration()).addListener(
      ImageStreamListener((ImageInfo info, bool _) {
        completer.complete(info);
      }),
    );

    final ImageInfo imageInfo = await completer.future;
    setState(() {
      imgSize = Size(
        imageInfo.image.width.toDouble(),
        imageInfo.image.height.toDouble(),
      );
    });
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
    _getImgSize();
  }
}
