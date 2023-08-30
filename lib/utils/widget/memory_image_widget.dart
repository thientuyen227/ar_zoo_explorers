import 'dart:typed_data';
import 'package:flutter/material.dart';

import '../../app/theme/dimens.dart';

class MemoryImageDisplay extends StatefulWidget {
  final Uint8List imageBytes;
  final BoxFit? fit;

  const MemoryImageDisplay({
    Key? key,
    required this.imageBytes,
    this.fit,
  }) : super(key: key);

  @override
  State<MemoryImageDisplay> createState() => _NetworkImageDisplayState();
}

class _NetworkImageDisplayState extends State<MemoryImageDisplay> {
  @override
  void didChangeDependencies() {
    precacheImage(MemoryImage(widget.imageBytes), context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return buildOctoImage();
  }

  Widget buildOctoImage() {
    return Image.memory(
      widget.imageBytes,
      errorBuilder: (context, url, error) => const Icon(Icons.warning, size: AppDimens.icon18),
      fit: widget.fit ?? BoxFit.cover,
      width: double.infinity,
      height: double.infinity,
    );
  }
}
