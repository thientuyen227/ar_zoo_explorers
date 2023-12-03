import 'package:ar_zoo_explorers/features/account/userinformation/presentation/userinformation_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';
import 'package:internationalization/internationalization.dart';

import '../../../../app/theme/icons.dart';
import '../../../../base/base_cubit.dart';
import '../../../base-model/FormBuilderTextField_Model.dart';

@injectable
class UserInformationCubit extends BaseCubit<UserInformationState> {
  UserInformationCubit() : super(UserInformationState());

  DateTime dtBirthday = DateTime.now();
  DateFormat dateFormat = DateFormat("dd/MM/yyyy");
  String address = "";
  String provincial = "An Giang";
  String userAvatar = "";
  String userBackground = "";
  String provider = "";

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
        name: "phone",
        hint_text: "Số điện thoại",
        icon_prefix: AppIcons.icPhone,
        TIT: TextInputType.phone),
    FormBuilderTextFieldModel(
        name: "address",
        hint_text: "Địa chỉ",
        icon_prefix: AppIcons.icAddress,
        TIT: TextInputType.text),
  ];

  void setBirthday(String? date) {
    if (date != "" && date != null) {
      dtBirthday = dateFormat.parse(date);
    }
  }

  void setUserAvatar(String? url) {
    if (url != "" && url != null) {
      userAvatar = url;
    }
  }

  void setUserBackground(String? url) {
    if (url != "" && url != null) {
      userBackground = url;
    }
  }

  void setAddress(String value) {
    List<String> values = value.split(', ');
    provincial = values[values.length - 1].trim();
    address = values[0];
    for (int i = 1; i < values.length - 1; i++) {
      address = "$address, ${values[i]}";
    }
  }

  void setProvider(String? url) {
    if (url != "" && url != null) {
      provider = url;
    }
  }

  String getBirthday() {
    return dateFormat.format(dtBirthday);
  }
}
