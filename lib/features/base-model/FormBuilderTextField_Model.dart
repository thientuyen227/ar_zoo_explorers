import 'dart:core';

import 'package:flutter/material.dart';

class FormBuilderTextFieldModel {
  String name;
  String txtValue;
  String icon_prefix;
  String icon_suffix;
  String hint_text;
  TextInputType TIT;
  bool isObscured;

  FormBuilderTextFieldModel(
      {this.name = "",
      this.txtValue = "",
      this.hint_text = "",
      this.icon_prefix = "",
      this.icon_suffix = "",
      this.TIT = TextInputType.text,
      this.isObscured = true});

  void setIsObscured() {
    isObscured = !isObscured;
  }
}
