import 'dart:core';

class FormBuilderTextFieldModel {
  String name;
  String txtValue;
  String icon_prefix;
  String icon_suffix;
  String hint_text;
  bool isObscured;

  FormBuilderTextFieldModel(
      {this.name = "",
      this.txtValue = "",
      this.hint_text = "",
      this.icon_prefix = "",
      this.icon_suffix = "",
      this.isObscured = true});

  void setIsObscured() {
    isObscured = !isObscured;
  }
}
