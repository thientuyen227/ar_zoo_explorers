import 'package:ar_zoo_explorers/app/languages/language_key.dart';
import 'package:ar_zoo_explorers/features/authentication/register/presentation/register_state.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
        hint_text: LanguageKeys.emailAddress.tr,
        icon_prefix: AppIcons.icMail,
        TIT: TextInputType.emailAddress,
        isObscured: false),
    FormBuilderTextFieldModel(
        name: 'fullname',
        hint_text: LanguageKeys.fullname.tr,
        icon_prefix: AppIcons.icUser,
        isObscured: false),
    FormBuilderTextFieldModel(
        name: 'password',
        hint_text: LanguageKeys.password.tr,
        icon_prefix: AppIcons.icLock,
        isObscured: true),
    FormBuilderTextFieldModel(
        name: 'confirmPassword',
        hint_text: LanguageKeys.confirmPassword.tr,
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
        return "${LanguageKeys.msg_invalidEmail.tr} !";
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
      final regex3 = RegExp(r'[0-9]');
      final regex4 = RegExp(r'[@*&^]');
      if (value.length < 8) {
        return "${LanguageKeys.msg_atLeast8Characters.tr} !";
      } else if (!regex1.hasMatch(value)) {
        return "${LanguageKeys.msg_missLowerCharacters} !";
      } else if (!regex2.hasMatch(value)) {
        return "${LanguageKeys.msg_missUpperCharacters.tr} !";
      } else if (!regex3.hasMatch(value)) {
        return "${LanguageKeys.msg_includeANumber} !";
      } else if (!regex4.hasMatch(value)) {
        return LanguageKeys.msg_includeSpecialCharacters;
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
        return "${LanguageKeys.msg_passwordNotMatch.tr} !";
      }
    } else {
      return null;
    }
    return null;
  }
}
