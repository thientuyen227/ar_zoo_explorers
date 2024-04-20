import 'package:ar_zoo_explorers/utils/extension/responsive_extension.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

double height(double? height) => height?.height ?? 0;
double width(double? width) => width?.width ?? 0;

double heightScreen = MediaQuery.of(Get.context!).size.height;
double widthScreen = MediaQuery.of(Get.context!).size.width;

EdgeInsets padding({
  double? top,
  double? bottom,
  double? left,
  double? right,
  double? horizontal,
  double? vertical,
  double? all,
}) =>
    EdgeInsets.only(
      top: (top ?? vertical ?? all ?? 0).height,
      bottom: (bottom ?? vertical ?? all ?? 0).height,
      left: (left ?? horizontal ?? all ?? 0).width,
      right: (right ?? horizontal ?? all ?? 0).width,
    );
EdgeInsets margin({
  double? top,
  double? bottom,
  double? left,
  double? right,
  double? horizontal,
  double? vertical,
  double? all,
}) =>
    EdgeInsets.only(
      top: (top ?? vertical ?? all ?? 0).height,
      bottom: (bottom ?? vertical ?? all ?? 0).height,
      left: (left ?? horizontal ?? all ?? 0).width,
      right: (right ?? horizontal ?? all ?? 0).width,
    );
