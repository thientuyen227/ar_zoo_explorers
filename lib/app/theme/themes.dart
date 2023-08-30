import 'package:flutter/material.dart';

import 'colors.dart';

class AppThemeData {
  final Brightness brightness;
  final AppColorScheme colorScheme;
  final AppTextTheme textThemeT1;
  final AppTextTheme textThemeT2;
  final AppTextTheme textThemeT3;
  final AppTextTheme textThemeT4;
  final AppTextTheme buttonThemeT1;
  final AppTextTheme buttonThemeT2;
  final AppTextTheme borderThemeT1;
  final AppTextTheme buttonTitleThemeT1;

  const AppThemeData.raw({
    required this.brightness,
    required this.colorScheme,
    required this.textThemeT1,
    required this.textThemeT2,
    required this.textThemeT3,
    required this.buttonThemeT1,
    required this.buttonThemeT2,
    required this.textThemeT4,
    required this.borderThemeT1,
    required this.buttonTitleThemeT1,
  });

  factory AppThemeData({
    required Brightness brightness,
    required AppColorScheme colorScheme,
  }) =>
      AppThemeData.raw(
          brightness: brightness,
          colorScheme: colorScheme,
          textThemeT1: AppTextTheme.create(colorScheme.textColor),
          textThemeT2:
              AppTextTheme.create(colorScheme.textColor.withOpacity(0.7)),
          textThemeT3:
              AppTextTheme.create(colorScheme.textColor.withOpacity(0.5)),
          textThemeT4:
              AppTextTheme.create(colorScheme.textColor.withOpacity(0.2)),
          buttonThemeT1: AppTextTheme.create(colorScheme.btnColor),
          buttonThemeT2:
              AppTextTheme.create(colorScheme.btnColor.withOpacity(0.5)),
          borderThemeT1: AppTextTheme.create(
            colorScheme.btnColor,
          ),
          buttonTitleThemeT1: AppTextTheme.create(
            colorScheme.textBtnColor,
          ));

  ThemeData get themeData => ThemeData(
        brightness: brightness,
        primaryColor: colorScheme.primary,
        backgroundColor: colorScheme.primary,
        colorScheme: ColorScheme.light(
          brightness: brightness,
          primary: colorScheme.primary,
          surface: AppColor.white,
          onPrimary: AppColor.white,
        ),
        appBarTheme: AppBarTheme(
          foregroundColor: colorScheme.primary,
          backgroundColor: colorScheme.primary,
        ),
        tabBarTheme: TabBarTheme(
          labelColor: colorScheme.primary,
        ),
        scaffoldBackgroundColor: colorScheme.primary,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(colorScheme.btnColor),
          ),
        ),
        textSelectionTheme: TextSelectionThemeData(
          cursorColor: colorScheme.textColor,
          selectionColor: AppColor.lightGrey,
          selectionHandleColor: colorScheme.textColor,
        ),
      );

  factory AppThemeData.light() => AppThemeData(
      brightness: Brightness.dark, colorScheme: AppColorScheme.light());

  factory AppThemeData.dark() => AppThemeData(
      brightness: Brightness.dark, colorScheme: AppColorScheme.dark());
}

class AppTextTheme {
  final TextStyle bigTitle;
  final TextStyle title;
  final TextStyle button;
  final TextStyle textButton;
  final TextStyle header0;
  final TextStyle header1;
  final TextStyle header2;
  final TextStyle body;
  final TextStyle light;
  final TextStyle error;
  final TextStyle placeHolder;
  final TextStyle small;
  final TextStyle caption;

  AppTextTheme({
    required this.bigTitle,
    required this.title,
    required this.button,
    required this.textButton,
    required this.header0,
    required this.header1,
    required this.header2,
    required this.body,
    required this.light,
    required this.error,
    required this.placeHolder,
    required this.small,
    required this.caption,
  });

  factory AppTextTheme.create(Color color) {
    const fontFamily = 'Poppins';
    return AppTextTheme(
      bigTitle: TextStyle(
        fontFamily: fontFamily,
        fontWeight: FontWeight.bold,
        fontSize: 18,
        color: color,
      ),
      title: TextStyle(
        fontFamily: fontFamily,
        fontWeight: FontWeight.bold,
        fontSize: 17,
        color: color,
      ),
      button: TextStyle(
        fontFamily: fontFamily,
        fontWeight: FontWeight.bold,
        fontSize: 16,
        color: color,
      ),
      textButton: TextStyle(
        fontFamily: fontFamily,
        fontSize: 15,
        color: color,
      ),
      header0: TextStyle(
        fontFamily: fontFamily,
        fontWeight: FontWeight.bold,
        fontSize: 40,
        color: color,
      ),
      header1: TextStyle(
        fontFamily: fontFamily,
        fontWeight: FontWeight.bold,
        fontSize: 20,
        color: color,
      ),
      header2: TextStyle(
        fontFamily: fontFamily,
        fontSize: 16,
        color: color,
      ),
      body: TextStyle(
        fontFamily: fontFamily,
        fontSize: 16,
        color: color,
      ),
      light: TextStyle(
        fontFamily: fontFamily,
        fontSize: 13,
        color: color,
      ),
      error: TextStyle(
        fontFamily: fontFamily,
        fontSize: 17,
        color: color,
      ),
      placeHolder: TextStyle(
        fontFamily: fontFamily,
        fontSize: 15,
        color: color,
      ),
      small: TextStyle(
        fontFamily: fontFamily,
        fontSize: 10,
        color: color,
      ),
      caption: TextStyle(
        fontFamily: fontFamily,
        fontSize: 14,
        color: color,
      ),
    );
  }
}
