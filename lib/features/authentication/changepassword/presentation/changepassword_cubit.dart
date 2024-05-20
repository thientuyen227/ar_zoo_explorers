import 'package:ar_zoo_explorers/app/languages/language_key.dart';
import 'package:ar_zoo_explorers/features/authentication/changepassword/presentation/changepassword_state.dart';
import 'package:get/get.dart';
import 'package:injectable/injectable.dart';

import '../../../../app/theme/icons.dart';
import '../../../../base/base_cubit.dart';
import '../../../base-model/form_builder_text_field_model.dart';

@injectable
class ChangePasswordCubit extends BaseCubit<ChangePasswordState> {
  ChangePasswordCubit() : super(ChangePasswordState());
  double HEIGHT = 0;
  double WIDTH = 0;

  List<FormBuilderTextFieldModel> ListFormItem = [
    FormBuilderTextFieldModel(
        name: 'oldPassword',
        hint_text: LanguageKeys.enterTheOldPassword.tr,
        icon_prefix: AppIcons.icLock,
        isObscured: true),
    FormBuilderTextFieldModel(
        name: 'password',
        hint_text: LanguageKeys.enterTheNewPassword.tr,
        icon_prefix: AppIcons.icLock,
        isObscured: true),
    FormBuilderTextFieldModel(
        name: 'confirmPassword',
        hint_text: LanguageKeys.enterTheConfirmPassword.tr,
        icon_prefix: AppIcons.icLock,
        isObscured: true)
  ];

  void onChangeObscuredStatus(int index) {
    ListFormItem[index].isObscured = !ListFormItem[index].isObscured;
  }

  String? onCheckPassword(String? value) {
    if (value != null && value.isNotEmpty) {
      final regex1 = RegExp(r'[a-z]');
      final regex2 = RegExp(r'[A-Z]');
      final regex3 = RegExp(r'[0-9]');
      final regex4 = RegExp(r'[@*&^]');
      if (value.length < 8) {
        return LanguageKeys.msg_atLeast8Characters.tr;
      } else if (!regex1.hasMatch(value)) {
        return LanguageKeys.msg_missLowerCharacters.tr;
      } else if (!regex2.hasMatch(value)) {
        return LanguageKeys.msg_missUpperCharacters.tr;
      } else if (!regex3.hasMatch(value)) {
        return LanguageKeys.msg_includeANumber.tr;
      } else if (!regex4.hasMatch(value)) {
        return LanguageKeys.msg_includeSpecialCharacters.tr;
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
        return LanguageKeys.msg_passwordNotMatch.tr;
      }
    } else {
      return null;
    }
    return null;
  }
}
