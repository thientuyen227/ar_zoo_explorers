import 'package:ar_zoo_explorers/features/account/userinformation/presentation/userinformation_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';

import '../../../../app/theme/icons.dart';
import '../../../../base/base_cubit.dart';
import '../../../base-model/FormBuilderTextField_Model.dart';

@injectable
class UserInformationCubit extends BaseCubit<UserInformationState> {
  UserInformationCubit() : super(UserInformationState());
  List<FormBuilderTextFieldModel> ListFormItem = [
    FormBuilderTextFieldModel(
        name: "fullname",
        hint_text: "Họ và tên",
        icon_prefix: AppIcons.icUser,
        TIT: TextInputType.none),
    FormBuilderTextFieldModel(
        name: "email",
        hint_text: "Địa chỉ email",
        icon_prefix: AppIcons.icMail,
        TIT: TextInputType.emailAddress),
    FormBuilderTextFieldModel(
        name: "phoneNumber",
        hint_text: "Số điện thoại",
        icon_prefix: AppIcons.icPhone,
        TIT: TextInputType.phone),
    FormBuilderTextFieldModel(
        name: "address",
        hint_text: "Địa chỉ",
        icon_prefix: AppIcons.icAddress,
        TIT: TextInputType.text),
    FormBuilderTextFieldModel(
        name: "provider",
        hint_text: "Công ty/Trường học",
        icon_prefix: AppIcons.icProvider,
        TIT: TextInputType.text)
  ];
}
