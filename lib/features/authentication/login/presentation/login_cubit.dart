import 'package:ar_zoo_explorers/base/base_cubit.dart';
import 'package:ar_zoo_explorers/features/authentication/login/presentation/login_state.dart';
import 'package:injectable/injectable.dart';

import '../../../../app/theme/icons.dart';
import '../../../base-model/form_builder_text_field_model.dart';

@injectable
class LoginCubit extends BaseCubit<LoginState> {
  LoginCubit() : super(LoginState());

  double HEIGHT = 0;
  double WIDTH = 0;

  bool isVisible = true;
  bool isChecked = false;

  List<String> ListEmail = [];

  List<FormBuilderTextFieldModel> ListFormItem = [
    FormBuilderTextFieldModel(
        name: 'email',
        hint_text: "Email address",
        icon_prefix: AppIcons.icUser,
        isObscured: false),
    FormBuilderTextFieldModel(
        name: 'password',
        hint_text: 'Password',
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
