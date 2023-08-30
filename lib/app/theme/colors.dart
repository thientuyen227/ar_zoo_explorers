import 'package:flutter/material.dart';

class AppColorScheme {
  final Color primary;
  final Color btnColor;
  final Color textColor;
  final Color textBtnColor;
  final Color cardColor;
  final Color playBtnColor;
  final Color navigationBtnColor;
  final Color dialogColor;
  final Color userBubbleColor;
  final Color botBubbleColor;

  AppColorScheme(
      {required this.primary,
      required this.btnColor,
      required this.textColor,
      required this.textBtnColor,
      required this.cardColor,
      required this.playBtnColor,
      required this.navigationBtnColor,
      required this.dialogColor,
      required this.userBubbleColor,
      required this.botBubbleColor});

  factory AppColorScheme.light() => AppColorScheme(
      primary: const Color(0xFF292F3F),
      btnColor: AppColor.buttonBlue,
      textColor: Colors.white,
      textBtnColor: Colors.white,
      cardColor: Colors.black.withOpacity(0.25),
      playBtnColor: const Color(0xFFF6F6F6),
      navigationBtnColor: const Color(0xFFEDEDF1),
      dialogColor: const Color(0xFF121927),
      userBubbleColor: const Color(0xFF373E4E),
      botBubbleColor: const Color(0xFF272A35));

  factory AppColorScheme.dark() => AppColorScheme(
      primary: const Color(0xFF292F3F),
      btnColor: AppColor.buttonBlue,
      textColor: Colors.white,
      textBtnColor: Colors.white,
      cardColor: Colors.black.withOpacity(0.25),
      playBtnColor: const Color(0xFFF6F6F6),
      navigationBtnColor: const Color(0xFF202020),
      dialogColor: const Color(0xFF121927),
      userBubbleColor: const Color(0xFF373E4E),
      botBubbleColor: const Color(0xFF272A35));
}

class AppColor {
  static const white = Colors.white;
  static const black = Colors.black;
  static const whiteBlue = Color(0xFFD0E0FF);
  static const activeBlue = Color(0xFF3881ED);
  static const inactiveBlue = Color(0xFF005DFF);
  static const buttonBlue = Color(0xFF0075FF);
  static const dartBlue = Color(0xFF0250BE);
  static const lightBlue = Color(0xFF5E9AFF);
  static const lightGrey = Color(0x14FFFFFF);
  static const lightGreen = Color(0xFFD0F1DB);
  static const dark = Color(0xFF1C1C1E);
  static const green = Color(0xFF2B9E52);
  static const orange = Color(0xFFFFD60A);
  static const blue = Color(0xFF4476CA);
  static const yellow = Color(0xFFFFB800);
  static const blurBlue = Color(0xFFD0E0FF);

  static const textFieldBG = Color(0xFF222838);
  static const chatPageBG = Color(0xFF1C212B);
  static const messageBlueBG = Color(0xFF384DBC);
  static const readmoreText = Color(0xFF3E82E7);
  static const darkBG = Color(0xFF1A1A1A);

  static Color parseColor(String color) {
    String hex = color.replaceAll("#", "");
    if (hex.isEmpty) hex = "ffffff";
    if (hex.length == 3) {
      hex =
          '${hex.substring(0, 1)}${hex.substring(0, 1)}${hex.substring(1, 2)}${hex.substring(1, 2)}${hex.substring(2, 3)}${hex.substring(2, 3)}';
    }
    Color col = Color(int.parse(hex, radix: 16)).withOpacity(1.0);
    return col;
  }
}
