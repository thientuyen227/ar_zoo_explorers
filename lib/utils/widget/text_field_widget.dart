import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../app/theme/dimens.dart';
import '../../utils/extension/context_ext.dart';

class AppTextFormField extends StatelessWidget {
  const AppTextFormField({
    Key? key,
    this.controller,
    this.label,
    this.hint,
    this.suffixIcon,
    this.keyboardType,
    this.obscureText = false,
    this.validator,
    this.error,
    this.focusNode,
    this.inputFormatters,
    this.enabled = true,
    this.readOnly = false,
    this.enableUnderline = false,
    this.onSuffixTap,
    this.textInputAction,
    this.onEditingComplete,
    this.onChanged,
    this.textAlign = TextAlign.start,
    this.style,
    this.floatingLabelBehavior,
    this.maxLength,
    this.hasBorder = false,
    this.padding,
    this.height,
    this.hintStyle,
    this.maxLines = 1,
    this.suffixText,
    this.prefixIcon,
    this.textFormBorderRadius,
    this.suffixSize,
    this.prefixSize,
    this.fillColor,
    this.onFieldSubmitted,
    this.backgroundColor,
    this.containerBorderRadius,
    this.cursorColor,
  }) : super(key: key);

  final TextEditingController? controller;
  final String? label;
  final String? hint;
  final Widget? suffixIcon;
  final TextInputType? keyboardType;
  final bool obscureText;
  final FormFieldValidator<String>? validator;
  final String? error;
  final FocusNode? focusNode;
  final List<TextInputFormatter>? inputFormatters;
  final bool enabled;
  final bool readOnly;
  final bool enableUnderline;
  final VoidCallback? onSuffixTap;
  final TextInputAction? textInputAction;
  final VoidCallback? onEditingComplete;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onFieldSubmitted;
  final TextAlign textAlign;
  final TextStyle? style;
  final TextStyle? hintStyle;
  final FloatingLabelBehavior? floatingLabelBehavior;
  final int? maxLength;
  final bool hasBorder;
  final EdgeInsets? padding;
  final double? height;
  final int? maxLines;
  final String? suffixText;
  final Widget? prefixIcon;
  final BorderRadius? textFormBorderRadius;
  final BoxConstraints? suffixSize;
  final BoxConstraints? prefixSize;
  final Color? fillColor;
  final Color? backgroundColor;
  final BorderRadius? containerBorderRadius;
  final Color? cursorColor;

  @override
  Widget build(BuildContext context) {
    final theme = context.myTheme;
    return Container(
      height: height,
      padding: padding,
      decoration: BoxDecoration(
        borderRadius: containerBorderRadius,
        color: backgroundColor,
        border: hasBorder
            ? Border.all(
                width: 0.5, color: context.myTheme.borderThemeT1.title.color!)
            : null,
      ),
      child: TextFormField(
        key: key,
        maxLength: maxLength,
        enableSuggestions: false,
        autocorrect: false,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        onChanged: onChanged,
        onFieldSubmitted: onFieldSubmitted,
        onEditingComplete: onEditingComplete,
        textInputAction: textInputAction,
        controller: controller,
        readOnly: readOnly,
        style: style ?? theme.textThemeT1.body,
        decoration: InputDecoration(
          fillColor: fillColor,
          filled: fillColor != null,
          isDense: true,
          prefixIcon: prefixIcon,
          prefixIconConstraints: prefixSize,
          suffixText: suffixText,
          suffixIconConstraints: suffixSize,
          suffixIcon: suffixIcon != null
              ? GestureDetector(onTap: onSuffixTap, child: suffixIcon)
              : null,
          border: enableUnderline
              ? const UnderlineInputBorder()
              : OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius:
                      textFormBorderRadius ?? BorderRadius.circular(0)),
          labelText: label,
          hintText: hint,
          errorText: error,
          labelStyle: theme.textThemeT1.body,
          hintStyle: hintStyle ?? theme.textThemeT4.body,
          floatingLabelBehavior: FloatingLabelBehavior.always,
          contentPadding:
              const EdgeInsets.symmetric(vertical: AppDimens.spacing6),
        ),
        keyboardType: keyboardType,
        obscureText: obscureText,
        maxLines: maxLines,
        textAlignVertical: TextAlignVertical.center,
        validator: validator,
        focusNode: focusNode,
        inputFormatters: inputFormatters,
        enabled: enabled,
        textAlign: textAlign,
        cursorColor: cursorColor,
      ),
    );
  }
}
