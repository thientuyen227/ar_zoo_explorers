import 'package:ar_zoo_explorers/features/authentication/changepassword/presentation/changepassword_state.dart';
import 'package:injectable/injectable.dart';

import '../../../../app/theme/icons.dart';
import '../../../../base/base_cubit.dart';
import '../../../base-model/form_builder_text_field_model.dart';

@injectable
class ChangePasswordCubit extends BaseCubit<ChangePasswordState> {
  ChangePasswordCubit() : super(ChangePasswordState());
  List<FormBuilderTextFieldModel> ListFormItem = [
    FormBuilderTextFieldModel(
        name: 'oldPassword',
        hint_text: 'Enter the old password',
        icon_prefix: AppIcons.icLock,
        isObscured: true),
    FormBuilderTextFieldModel(
        name: 'password',
        hint_text: 'Enter the new password',
        icon_prefix: AppIcons.icLock,
        isObscured: true),
    FormBuilderTextFieldModel(
        name: 'confirmPassword',
        hint_text: 'Re-enter the new password',
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
      final regex3 = RegExp(r'[A-Z]');
      final regex4 = RegExp(r'[@*&^]');
      if (value.length < 8) {
        return "At least 8 characters.";
      } else if (!regex1.hasMatch(value)) {
        return "Missing lowercase character.";
      } else if (!regex2.hasMatch(value)) {
        return "Missing uppercase character.";
      } else if (!regex3.hasMatch(value)) {
        return "Must include a number.";
      } else if (!regex4.hasMatch(value)) {
        return "Must include special characters @*&^.";
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
        return "Password confirmation does not match.";
      }
    } else {
      return null;
    }
    return null;
  }
}
