import 'package:ar_zoo_explorers/features/account/userinformation/presentation/userinformation_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';
import 'package:internationalization/internationalization.dart';

import '../../../../app/theme/icons.dart';
import '../../../../base/base_cubit.dart';
import '../../../base-model/form_builder_text_field_model.dart';
import '../model/provincial_name.dart';

@injectable
class UserInformationCubit extends BaseCubit<UserInformationState> {
  UserInformationCubit() : super(UserInformationState());

  double HEIGHT = 0;
  double WIDTH = 0;

  DateTime dtBirthday = DateTime.now();
  DateFormat dateFormat = DateFormat("dd/MM/yyyy");
  String address = "";
  String provincial = "An Giang";
  String userAvatar = "";
  String userBackground = "";
  String provider = "";
  String gender = "male";

  List<FormBuilderTextFieldModel> ListFormItem = [
    FormBuilderTextFieldModel(
        name: "fullname",
        hint_text: "Full name",
        icon_prefix: AppIcons.icUser,
        TIT: TextInputType.none),
    FormBuilderTextFieldModel(
        name: "email",
        hint_text: "Email Address",
        icon_prefix: AppIcons.icMail,
        TIT: TextInputType.emailAddress),
    FormBuilderTextFieldModel(
        name: "phone",
        hint_text: "Phone Number",
        icon_prefix: AppIcons.icPhone,
        TIT: TextInputType.phone),
    FormBuilderTextFieldModel(
        name: "address",
        hint_text: "Address",
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
    if (Provincial().names.contains(values[values.length - 1].trim())) {
      provincial = values[values.length - 1].trim();
    }
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

  void setGender(String userGender) {
    if (userGender == 'female') {
      gender = userGender;
    }
  }

  String getBirthday() {
    return dateFormat.format(dtBirthday);
  }

  String avatarName(String fullname) {
    String name = "";
    List<String> values = fullname.split(' ');
    for (int i = 0; i < values.length; i++) {
      name = "$name${values[i]}";
    }
    name = name +
        DateTime.now().day.toString() +
        DateTime.now().month.toString() +
        DateTime.now().year.toString() +
        DateTime.now().microsecond.toString() +
        DateTime.now().minute.toString() +
        DateTime.now().hour.toString();
    return name;
  }
}
