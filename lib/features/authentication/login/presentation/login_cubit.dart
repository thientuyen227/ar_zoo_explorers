import 'package:ar_zoo_explorers/base/base_cubit.dart';
import 'package:ar_zoo_explorers/features/authentication/login/presentation/login_state.dart';
import 'package:injectable/injectable.dart';

import '../../../../app/theme/icons.dart';
import '../../../base-model/FormBuilderTextField_Model.dart';

@injectable
class LoginCubit extends BaseCubit<LoginState> {
  LoginCubit() : super(LoginState());

  bool isVisible = true;
  bool isChecked = false;

  List<String> ListEmail = [];

  List<FormBuilderTextFieldModel> ListFormItem = [
    FormBuilderTextFieldModel(
        name: 'email',
        hint_text: "Địa chỉ email",
        icon_prefix: AppIcons.icUser,
        isObscured: false),
    FormBuilderTextFieldModel(
        name: 'password',
        hint_text: 'Mật khẩu',
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
}
