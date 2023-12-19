import 'package:ar_zoo_explorers/features/authentication/register/presentation/register_state.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

import '../../../../app/theme/icons.dart';
import '../../../../base/base_cubit.dart';
import '../../../base-model/form_builder_text_field_model.dart';
import '../../login/model/OthersLoginButton_Model.dart';

@injectable
class RegisterCubit extends BaseCubit<RegisterState> {
  RegisterCubit() : super(RegisterState());
  bool isChecked = false;

  List<FormBuilderTextFieldModel> ListFormItem = [
    FormBuilderTextFieldModel(
        name: 'email',
        hint_text: "Địa chỉ email",
        icon_prefix: AppIcons.icMail,
        TIT: TextInputType.emailAddress,
        isObscured: false),
    FormBuilderTextFieldModel(
        name: 'fullname',
        hint_text: "Họ và tên",
        icon_prefix: AppIcons.icUser,
        isObscured: false),
    FormBuilderTextFieldModel(
        name: 'password',
        hint_text: 'Mật khẩu',
        icon_prefix: AppIcons.icLock,
        isObscured: true),
    FormBuilderTextFieldModel(
        name: 'confirmPassword',
        hint_text: 'Nhập lại mật khẩu',
        icon_prefix: AppIcons.icLock,
        isObscured: true)
  ];

  List<OthersLoginButtonModel> listOthersLoginButton = [
    OthersLoginButtonModel(
        bgColor: Colors.red,
        bdColor: Colors.red,
        colorText: Colors.white,
        icon: AppIcons.icGMail,
        content: "Đăng nhập với GMail"),
    OthersLoginButtonModel(
        bgColor: Colors.blue,
        bdColor: Colors.blue,
        colorText: Colors.white,
        icon: AppIcons.icFacebook,
        content: "Đăng nhập với Facebook"),
    OthersLoginButtonModel(
        bgColor: Colors.white,
        bdColor: Colors.grey,
        colorText: Colors.black,
        icon: AppIcons.icApple,
        content: "Đăng nhập với ID Apple")
  ];

  void onChangeObscuredStatus(int index) {
    ListFormItem[index].isObscured = !ListFormItem[index].isObscured;
  }

  String? onCheckEmail(String? value) {
    if (value != null && value.isNotEmpty) {
      if (!value.contains("@") || !value.contains(".")) {
        return "Địa chỉ email không hợp lệ";
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
        return "Mật khẩu tối thiểu 8 ký tự";
      } else if (!regex1.hasMatch(value)) {
        return "Mật khẩu thiếu ký tự thường";
      } else if (!regex2.hasMatch(value)) {
        return "Mật khẩu thiếu ký tự hoa";
      } else if (!regex3.hasMatch(value)) {
        return "Mật khẩu phải có chữ số";
      } else if (!regex4.hasMatch(value)) {
        return "Mật khẩu phải chữ ký tự @*&^";
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
        return "Nhập lại mật khẩu không trùng khớp";
      }
    } else {
      return null;
    }
    return null;
  }
}
