import 'package:flutter/material.dart';

import '../../app/theme/dimens.dart';
import '../../utils/extension/context_ext.dart';
import 'image_widget.dart';

class AppPrimaryButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String title;
  final Color? buttonColor;
  final TextStyle? titleStyle;
  final double? buttonHeight;
  final bool enable;
  final double? buttonRadius;
  final EdgeInsets? padding;
  final DecorationImage? imageBackground;

  const AppPrimaryButton({
    Key? key,
    required this.onPressed,
    required this.title,
    this.buttonColor,
    this.buttonHeight,
    this.enable = true,
    this.titleStyle,
    this.buttonRadius,
    this.padding,
    this.imageBackground,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: buttonHeight ?? AppDimens.buttonHeight,
      decoration: BoxDecoration(
          image: imageBackground, borderRadius: BorderRadius.circular(buttonRadius ?? AppDimens.buttonRadius)),
      child: Opacity(
          opacity: enable ? 1 : 0.5,
          child: ElevatedButton(
            style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(buttonRadius ?? AppDimens.buttonRadius),
                )),
                elevation: MaterialStateProperty.all(0),
                backgroundColor: MaterialStateProperty.all(buttonColor ?? context.myTheme.colorScheme.btnColor),
                padding: MaterialStateProperty.all(padding)),
            onPressed: enable ? onPressed : null,
            child: Text(title, style: titleStyle ?? context.myTheme.buttonTitleThemeT1.button),
          )),
    );
  }
}

class AppTextButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String title;
  final Color? titleColor;
  final TextStyle? style;
  final bool enable;
  final TextOverflow? textOverflow;
  final VoidCallback? sendAnalysisOnPressed;

  const AppTextButton({
    Key? key,
    required this.onPressed,
    required this.title,
    this.titleColor,
    this.style,
    this.enable = true,
    this.textOverflow,
    this.sendAnalysisOnPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: ButtonStyle(
        textStyle: MaterialStateProperty.all(style),
      ),
      child: Text(
        title,
        overflow: textOverflow,
        style: style ??
            context.myTheme.buttonThemeT1.textButton.copyWith(
              color: titleColor ?? context.myTheme.colorScheme.textColor,
            ),
      ),
      onPressed: () {
        if (enable) {
          onPressed();
        }
        if (sendAnalysisOnPressed != null) {
          sendAnalysisOnPressed!();
        }
      },
    );
  }
}

class AppIconButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Widget icon;
  final bool hasDropShadown;
  final Color? backgroundColor;
  final EdgeInsets? padding;
  final double? borderRadius;
  final double? borderWidth;
  final Color? borderColor;
  final Color? shadownColor;
  final double? height;
  final double? width;

  const AppIconButton({
    Key? key,
    required this.onPressed,
    required this.icon,
    this.hasDropShadown = false,
    this.backgroundColor,
    this.padding,
    this.borderRadius,
    this.borderWidth,
    this.borderColor,
    this.shadownColor,
    this.height,
    this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
          color: backgroundColor,
          border: Border.all(
            color: borderColor ?? Colors.transparent,
            width: borderWidth ?? 0,
          ),
          borderRadius: BorderRadius.circular(
            borderRadius ?? AppDimens.buttonRadius,
          ),
          boxShadow: hasDropShadown
              ? [
                  BoxShadow(
                    color: shadownColor ?? context.myTheme.colorScheme.primary,
                    spreadRadius: 2,
                    blurRadius: 4,
                  )
                ]
              : null),
      child: SizedBox(
        height: height,
        width: width,
        child: GestureDetector(
          child: icon,
          onTap: () => onPressed(),
        ),
      ),
    );
  }
}

class AppIconGradientButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Widget icon;
  final bool hasDropShadown;
  final Gradient? backgroundGradient;
  final EdgeInsets? padding;
  final double? borderRadius;
  final double? borderWidth;
  final Color? borderColor;
  final Color? shadownColor;
  final double? height;
  final double? width;

  const AppIconGradientButton({
    Key? key,
    required this.onPressed,
    required this.icon,
    this.hasDropShadown = false,
    this.backgroundGradient,
    this.padding,
    this.borderRadius,
    this.borderWidth,
    this.borderColor,
    this.shadownColor,
    this.height,
    this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
          gradient: backgroundGradient,
          border: Border.all(
            color: borderColor ?? Colors.transparent,
            width: borderWidth ?? 0,
          ),
          borderRadius: BorderRadius.circular(
            borderRadius ?? AppDimens.buttonRadius,
          ),
          boxShadow: hasDropShadown
              ? [
                  BoxShadow(
                    color: shadownColor ?? context.myTheme.colorScheme.primary,
                    spreadRadius: 2,
                    blurRadius: 4,
                  )
                ]
              : null),
      child: SizedBox(
        height: height,
        width: width,
        child: GestureDetector(
          child: icon,
          onTap: () => onPressed(),
        ),
      ),
    );
  }
}

class AppCircleButton extends StatelessWidget {
  const AppCircleButton({
    Key? key,
    required this.assetString,
    required this.onPressed,
    this.dimension,
    this.backgroundColor,
    this.iconColor, this.fit, this.iconSize,
  }) : super(key: key);

  final String assetString;
  final VoidCallback onPressed;
  final double? dimension;
  final Color? backgroundColor;
  final Color? iconColor;
  final BoxFit? fit;
  final Size? iconSize;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onPressed(),
      child: SizedBox.square(
        dimension: dimension,
        child: CircleAvatar(
            backgroundColor: backgroundColor,
            child: AbsorbPointer(
              absorbing: true,
              child: AppImageWidget(
                assetString: assetString,
                color: iconColor,
                fit: fit,
                size: iconSize,
              ),
            )),
      ),
    );
  }
}

class AppCircleIconButton extends StatelessWidget {
  const AppCircleIconButton({
    Key? key,
    required this.iconData,
    required this.onPressed,
    this.dimension,
  }) : super(key: key);

  final IconData iconData;
  final VoidCallback onPressed;
  final double? dimension;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onPressed(),
      child: SizedBox.square(
        dimension: dimension,
        child: CircleAvatar(
            backgroundColor: context.myTheme.colorScheme.navigationBtnColor,
            child: AbsorbPointer(
                absorbing: true,
                child: Icon(
                  iconData,
                  color: context.myTheme.colorScheme.textColor,
                ))),
      ),
    );
  }
}
