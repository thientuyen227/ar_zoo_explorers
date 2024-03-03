import 'package:ar_zoo_explorers/features/authentication/register/presentation/register_state.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

import '../../../../app/theme/icons.dart';
import '../../../../base/base_cubit.dart';
import '../../../base-model/form_builder_text_field_model.dart';

@injectable
class RegisterCubit extends BaseCubit<RegisterState> {
  RegisterCubit() : super(RegisterState());
  double HEIGHT = 0;
  double WIDTH = 0;

  bool isChecked = false;

  List<FormBuilderTextFieldModel> ListFormItem = [
    FormBuilderTextFieldModel(
        name: 'email',
        hint_text: "Email address",
        icon_prefix: AppIcons.icMail,
        TIT: TextInputType.emailAddress,
        isObscured: false),
    FormBuilderTextFieldModel(
        name: 'fullname',
        hint_text: "Full name",
        icon_prefix: AppIcons.icUser,
        isObscured: false),
    FormBuilderTextFieldModel(
        name: 'password',
        hint_text: 'Password',
        icon_prefix: AppIcons.icLock,
        isObscured: true),
    FormBuilderTextFieldModel(
        name: 'confirmPassword',
        hint_text: 'Confirm password',
        icon_prefix: AppIcons.icLock,
        isObscured: true)
  ];

  List<String> listOthersLoginButton = [
    AppIcons.icFacebookCircle,
    AppIcons.icGMailCircle,
    AppIcons.icAppleCircle
  ];

  void onChangeObscuredStatus(int index) {
    ListFormItem[index].isObscured = !ListFormItem[index].isObscured;
  }

  String? onCheckEmail(String? value) {
    if (value != null && value.isNotEmpty) {
      if (!value.contains("@") || !value.contains(".")) {
        return "The email address is invalid!";
      }
    } else {
      return null;
    }
    return null;
  }

  String? onCheckUsername(String? value) {
    // if (value != null && value.isNotEmpty) {
    //   final regex = RegExp(r'^[a-zA-Z ]+$');
    //   if (!regex.hasMatch(value)) {
    //     return "Họ và tên không hợp lệ";
    //   }
    // } else {
    //   return null;
    // }
    return null;
  }

  String? onCheckPassword(String? value) {
    if (value != null && value.isNotEmpty) {
      final regex1 = RegExp(r'[a-z]');
      final regex2 = RegExp(r'[A-Z]');
      final regex3 = RegExp(r'[A-Z]');
      final regex4 = RegExp(r'[@*&^]');
      if (value.length < 8) {
        return "Minimum 8 characters!";
      } else if (!regex1.hasMatch(value)) {
        return "Missing lowercase character!";
      } else if (!regex2.hasMatch(value)) {
        return "Missing uppercase character!";
      } else if (!regex3.hasMatch(value)) {
        return "Password must include a number!";
      } else if (!regex4.hasMatch(value)) {
        return "Must include special characters @*&^";
      }
    } else {
      return null;
    }
    return null;
  }

  String? onCheckConfirmPassword(String? confirmPassword, String? password) {
    if (password != null &&
        password.isNotEmpty &&
        confirmPassword != null &&
        confirmPassword.isNotEmpty) {
      if (!(password.compareTo(confirmPassword) == 0)) {
        return "Password confirmation does not match!";
      }
    } else {
      return null;
    }
    return null;
  }
}
