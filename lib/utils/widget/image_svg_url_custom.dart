import 'package:ar_zoo_explorers/app/theme/icons.dart';
import 'package:ar_zoo_explorers/utils/extension/list_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ImageSvgUrlCustom extends StatelessWidget {
  final String imagePath;
  final double size;
  final double? width;
  final double? height;
  final Color? color;
  final Widget? widget;
  final bool? sizeBaseOnWidth;
  const ImageSvgUrlCustom(
      {super.key,
      required this.imagePath,
      this.size = 24,
      this.width,
      this.height,
      this.color,
      this.sizeBaseOnWidth = true,
      this.widget});

  @override
  Widget build(BuildContext context) {
    var localHeight = height ?? 50;
    var localwidth = width ?? 50;
    if (imagePath.isNotEmpty) {
      if (imagePath.endsWith(".svg")) {
        return imagePath.isValidUrl()
            ? SvgPicture.network(
                imagePath,
                width: localwidth,
                height: localHeight,
                color: color,
              )
            : SvgPicture.asset(imagePath,
                width: localwidth, height: localHeight, color: color);
      } else {
        return imagePath.isValidUrl()
            ? Image.network(imagePath,
                width: localwidth, height: localHeight, color: color)
            : Image.asset(
                imagePath,
                width: localwidth,
                color: color,
                height: localHeight,
                errorBuilder: (context, error, stackTrace) {
                  return defaultWidget(height: localHeight, width: localHeight);
                },
              );
      }
    } else {
      print(imagePath);
      return defaultWidget(height: localHeight, width: localwidth);
    }
  }

  Widget defaultWidget({double? height, double? width}) {
    return widget ??
        SvgPicture.asset(
          AppIcons.icWarning,
          width: 24,
          height: 24,
        );
  }
}
