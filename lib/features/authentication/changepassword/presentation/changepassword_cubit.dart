import 'package:ar_zoo_explorers/features/authentication/changepassword/presentation/changepassword_state.dart';
import 'package:injectable/injectable.dart';

import '../../../../app/theme/icons.dart';
import '../../../../base/base_cubit.dart';
import '../../../base-model/FormBuilderTextField_Model.dart';

@injectable
class ChangePasswordCubit extends BaseCubit<ChangePasswordState> {
  ChangePasswordCubit() : super(ChangePasswordState());
  List<FormBuilderTextFieldModel> ListFormItem = [
    FormBuilderTextFieldModel(
        name: 'oldPassword',
        hint_text: 'Nhập mật khẩu cũ',
        icon_prefix: AppIcons.icLock,
        isObscured: true),
    FormBuilderTextFieldModel(
        name: 'password',
        hint_text: 'Nhập mật khẩu mới',
        icon_prefix: AppIcons.icLock,
        isObscured: true),
    FormBuilderTextFieldModel(
        name: 'confirmPassword',
        hint_text: 'Nhập lại mật khẩu mới',
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
